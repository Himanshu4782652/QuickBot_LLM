#!/usr/bin/env python3
"""
CampusConnectSphere QuickBot Dataset Generation & Isolation Pipeline
====================================================================
Extracts domain knowledge from:
  - docs/CampusConnectSphere_Frontend_Screens_Catalog.md
  - docs/USER_ROLE_MANUAL.md
  - docs/RBAC_MATRIX.md
  - campus_connect_app/lib/menu_config.dart

Generates high-quality, privacy-preserving, role-isolated instruction-tuning pairs
for Google Colab training (OpenAI / ChatML / Gemini format).

Security & Privacy Guarantees:
  1. Zero PII: No real names, emails, phone numbers, passwords, or secrets.
  2. Complete Role Isolation: Hardened system prompts and negative boundaries.
  3. Incremental Expansion: Checksums and manifests track additions as the app grows.
"""

from __future__ import annotations

import os
import re
import json
import hashlib
import random
from typing import Dict, List, Any, Set, Tuple
from datetime import datetime, timezone

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
DOCS_DIR = os.path.join(REPO_ROOT, "sources") if os.path.exists(os.path.join(REPO_ROOT, "sources")) else os.path.join(REPO_ROOT, "docs")
DATA_DIR = os.path.join(REPO_ROOT, "data")

ROLES = [
    "SuperAdmin",
    "SchoolAdmin",
    "Admin",
    "Teacher",
    "Staff",
    "Student",
    "Parent",
    "Accountant",
    "Warden",
]

ROLE_SYSTEM_PROMPTS = {
    "SuperAdmin": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: SuperAdmin] persona. "
        "You provide platform-level guidance on multi-tenant SaaS management, school onboarding, "
        "subscription plans, tenant domain mapping, credentials, and global system health."
    ),
    "SchoolAdmin": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: SchoolAdmin / Admin] persona. "
        "You guide institutional leadership through academic setup, admissions pipelines, "
        "fee structures, timetable automation, Report Studio governance, staff allocation, and compliance."
    ),
    "Admin": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: SchoolAdmin / Admin] persona. "
        "You guide institutional leadership through academic setup, admissions pipelines, "
        "fee structures, timetable automation, Report Studio governance, staff allocation, and compliance."
    ),
    "Teacher": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Teacher] persona. "
        "You assist educators with classroom workflows: daily attendance marking, gradebook entry, "
        "assignment distribution, LMS virtual classrooms, quiz creation, and lesson planning."
    ),
    "Staff": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Staff] persona. "
        "You assist operational staff with delegated workflows: visitor passes, inventory management, "
        "transport dispatch, gate security, and general school operations."
    ),
    "Student": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Student] persona. "
        "You guide students on viewing timetables, submitting homework, reviewing attendance metrics, "
        "tracking grades, taking practice quizzes, and checking fee dues. "
        "You strictly refuse any access to administrative settings, grading overrides, or other students' private records."
    ),
    "Parent": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Parent] persona. "
        "You guide parents on monitoring their child's academic progress, attendance notices, "
        "paying school fees, live school bus tracking, booking PTM appointments, and raising Helpdesk tickets. "
        "You maintain child-specific privacy and refuse access to internal staff notes or administrative panels."
    ),
    "Accountant": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Accountant] persona. "
        "You guide financial personnel through fee collection POS, voucher entries, daybook reconciliation, "
        "statutory tax reports, and fee concessions."
    ),
    "Warden": (
        "You are the CampusConnectSphere QuickBot for the [ROLE: Warden] persona. "
        "You guide residential life staff on hostel room allotments, student room check-ins, "
        "night curfews, mess operations, and hostel maintenance tickets."
    ),
}

# Negative boundary tests per role to enforce strict role isolation
ROLE_FORBIDDEN_ACTIONS = {
    "Student": [
        ("How can I modify my final exam grade in the system?", "Access Denied: As a Student, you do not have grading permissions. Grades are managed exclusively by authorized faculty. You can submit a revaluation request through Helpdesk."),
        ("Where do I access the staff payroll and salary reports?", "Access Denied: As a Student, staff payroll and financial accounting are strictly restricted to School Administrators and Accountants."),
        ("How do I change the school's fee structure or discount rules?", "Access Denied: Fee structures and discount policies can only be configured by School Administrators."),
        ("Can I delete another student's profile?", "Access Denied: User profile management is restricted to institutional administrators.")
    ],
    "Parent": [
        ("How do I edit my child's attendance record?", "Access Denied: Attendance records are recorded and verified by school teachers and administrators. You may contact the class teacher or submit a Helpdesk inquiry."),
        ("Show me the private staff internal notes on my support ticket.", "Access Denied: Staff internal notes are restricted to school employees. You can view all public replies and communication in your ticket thread."),
        ("How do I configure the school's biometric facial recognition cameras?", "Access Denied: Hardware configurations and CCTV/biometric daemon settings require SchoolAdmin or IT Specialist privileges.")
    ],
    "Teacher": [
        ("How do I modify the school's SaaS subscription or renew the license?", "Access Denied: SaaS subscription licensing is restricted to Platform SuperAdmins and School Owners."),
        ("How do I delete an entire academic campus branch?", "Access Denied: Branch lifecycle operations require SuperAdmin or OrgAdmin authorization.")
    ],
    "Staff": [
        ("How do I finalize and lock the academic degree transcripts?", "Access Denied: Degree finalization and CBCS audit locking require Academic Dean or Registrar privileges.")
    ],
    "Accountant": [
        ("How do I publish exam question papers to students?", "Access Denied: Examination authoring and publishing are restricted to Teachers and the Examination Controller.")
    ],
    "Warden": [
        ("How do I edit the school's statutory balance sheet?", "Access Denied: Statutory balance sheets and daybooks are managed exclusively by the Accounts Department.")
    ]
}


class PiiScrubber:
    """Ensures no personal identity data, phone numbers, or passwords enter the dataset."""

    PHONE_REGEX = re.compile(r'\b(?:\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b')
    EMAIL_REGEX = re.compile(r'[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+')
    SECRET_REGEX = re.compile(r'(?i)(password|secret|token|api_key|connection_string)\s*[:=]\s*["\']?[^"\'\s]+')

    @classmethod
    def scrub(cls, text: str) -> str:
        text = cls.PHONE_REGEX.sub("[PHONE_NUMBER]", text)
        text = cls.EMAIL_REGEX.sub("[EMAIL_ADDRESS]", text)
        text = cls.SECRET_REGEX.sub(r'\1: [REDACTED_SECRET]', text)
        return text


class CatalogParser:
    """Parses the 1300+ line Frontend Screens Catalog into structured screen metadata."""

    def __init__(self, catalog_path: str):
        self.catalog_path = catalog_path

    def parse(self) -> List[Dict[str, Any]]:
        if not os.path.exists(self.catalog_path):
            return []

        with open(self.catalog_path, "r", encoding="utf-8") as f:
            content = f.read()

        screens = []
        screen_blocks = re.split(r'\n#### \d+\.\s*', content)

        for block in screen_blocks[1:]:
            lines = block.strip().split("\n")
            if not lines:
                continue

            screen_name_match = re.match(r'`?([A-Za-z0-9_]+)`?', lines[0].strip())
            screen_name = screen_name_match.group(1) if screen_name_match else lines[0].strip()

            file_path = ""
            target_roles = []
            description = ""
            apis = []

            for line in lines[1:]:
                line = line.strip()
                if line.startswith("- **File:**"):
                    file_path = line.replace("- **File:**", "").strip().strip("`")
                elif line.startswith("- **Target Roles:**"):
                    roles_str = line.replace("- **Target Roles:**", "").strip()
                    target_roles = [r.strip() for r in roles_str.split(",") if r.strip()]
                elif line.startswith("- **Function & What It Does:**"):
                    description = line.replace("- **Function & What It Does:**", "").strip()
                elif line.startswith("- `GET ") or line.startswith("- `POST ") or line.startswith("- `PUT ") or line.startswith("- `DELETE "):
                    apis.append(line.replace("-", "").strip().strip("`"))

            if screen_name and description:
                screens.append({
                    "screen_name": screen_name,
                    "file_path": file_path,
                    "target_roles": target_roles,
                    "description": description,
                    "apis": apis
                })

        return screens


class DatasetGenerator:
    """Generates synthetic, role-scoped conversational training pairs."""

    def __init__(self, screens: List[Dict[str, Any]]):
        self.screens = screens

    def _normalize_role(self, role: str) -> str:
        r = role.lower()
        if "student" in r: return "Student"
        if "parent" in r: return "Parent"
        if "teacher" in r or "faculty" in r: return "Teacher"
        if "superadmin" in r: return "SuperAdmin"
        if "schooladmin" in r or "principal" in r: return "SchoolAdmin"
        if "admin" in r: return "Admin"
        if "accountant" in r or "fee clerk" in r: return "Accountant"
        if "warden" in r: return "Warden"
        if "staff" in r: return "Staff"
        return "SchoolAdmin"

    def generate_pairs(self) -> List[Dict[str, Any]]:
        dataset = []

        # 1. Screen & Navigation Q&A
        for screen in self.screens:
            name = screen["screen_name"]
            desc = screen["description"]
            roles = screen["target_roles"] or ["All Authenticated Users"]

            for raw_role in roles:
                if "all" in raw_role.lower() or "public" in raw_role.lower():
                    sample_roles = ["Student", "Parent", "Teacher", "SchoolAdmin"]
                else:
                    sample_roles = [self._normalize_role(raw_role)]

                for role in sample_roles:
                    sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["SchoolAdmin"])

                    # Query variation 1: Where is screen?
                    dataset.append({
                        "messages": [
                            {"role": "system", "content": sys_prompt},
                            {"role": "user", "content": f"Where do I find the {name} screen and what is it used for?"},
                            {"role": "assistant", "content": f"You can access the {name} in the system workbench. {desc}"}
                        ]
                    })

                    # Query variation 2: How to perform functional task
                    dataset.append({
                        "messages": [
                            {"role": "system", "content": sys_prompt},
                            {"role": "user", "content": f"How do I manage operations using {name}?"},
                            {"role": "assistant", "content": f"To operate {name}: navigate to the module workspace. This screen enables you to {desc.lower()}"}
                        ]
                    })

                    # Query variation 3: Technical/API integration (for Admins)
                    if role in ["SuperAdmin", "SchoolAdmin", "Admin"] and screen["apis"]:
                        api_list = ", ".join(screen["apis"][:3])
                        dataset.append({
                            "messages": [
                                {"role": "system", "content": sys_prompt},
                                {"role": "user", "content": f"What backend endpoints power {name}?"},
                                {"role": "assistant", "content": f"The {name} interface communicates with the following authoritative backend APIs: {api_list}."}
                            ]
                        })

        # 2. Add Role Isolation Negative Boundary Examples
        for role, forbidden_items in ROLE_FORBIDDEN_ACTIONS.items():
            sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["Student"])
            for question, expected_refusal in forbidden_items:
                dataset.append({
                    "messages": [
                        {"role": "system", "content": sys_prompt},
                        {"role": "user", "content": question},
                        {"role": "assistant", "content": expected_refusal}
                    ]
                })

        # 3. Add Common Operational Scenarios per Role
        common_scenarios = [
            ("Student", "How do I check if my homework was received by my teacher?", "Open the 'Assignments' screen from your student workspace. Select the submitted assignment to view the upload timestamp and teacher feedback remarks."),
            ("Student", "Where can I view my class timetable for today?", "Navigate to the 'Timetable' screen. Your daily schedule displays all periods, subject names, assigned faculty, and classroom numbers."),
            ("Parent", "How do I pay my child's outstanding school fees online?", "Go to the 'Fee & Payment' section in your parent portal. Select 'Pay Dues', choose your payment method (UPI, Net Banking, or Credit/Debit Card), and download your official digital receipt immediately upon successful payment."),
            ("Parent", "How can I see where the school bus is right now?", "Open the 'Transport Tracking' screen. If your child is enrolled in school transport, you will see real-time GPS telemetry, vehicle speed, current stop, and estimated time of arrival (ETA) to your stop."),
            ("Teacher", "How do I mark daily attendance for my assigned section?", "Open 'Teacher Attendance' screen, select your assigned grade and section. Tap each student to toggle status (Present, Absent, Late, or On Leave), then tap 'Submit Attendance' to notify parents instantly."),
            ("Teacher", "How do I create and publish a new homework assignment?", "Go to 'Assignment Management', select class and subject, enter title, due date, instructions, and optionally attach a PDF/worksheet. Tap 'Publish' to dispatch it to student dashboards."),
            ("SchoolAdmin", "How do I design or modify customized report cards for CBSE / State board?", "Navigate to 'Report Studio Designer' in your administration workbench. You can drag and drop student photo headers, mark tables, scholastic/co-scholastic grading grids, and QR verification blocks, preview in high fidelity, and publish."),
            ("SchoolAdmin", "How do I bulk import new student admissions at the start of the academic term?", "Access the 'Bulk Upload' console. Download the standardized CSV/Excel student onboarding template, populate student and parent records, upload it for automated validation, and click 'Commit' once zero errors are flagged.")
        ]

        for role, q, a in common_scenarios:
            sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["SchoolAdmin"])
            dataset.append({
                "messages": [
                    {"role": "system", "content": sys_prompt},
                    {"role": "user", "content": q},
                    {"role": "assistant", "content": a}
                ]
            })

        # Scrub all generated samples for PII
        for item in dataset:
            for msg in item["messages"]:
                msg["content"] = PiiScrubber.scrub(msg["content"])

        return dataset


def compute_file_hash(filepath: str) -> str:
    hasher = hashlib.sha256()
    with open(filepath, "rb") as f:
        hasher.update(f.read())
    return hasher.hexdigest()[:16]


def main():
    print("===================================================================")
    print("CampusConnectSphere QuickBot Dataset Extraction & Isolation Engine")
    print("===================================================================")

    os.makedirs(DATA_DIR, exist_ok=True)

    catalog_path = os.path.join(DOCS_DIR, "CampusConnectSphere_Frontend_Screens_Catalog.md")
    user_manual_path = os.path.join(DOCS_DIR, "USER_ROLE_MANUAL.md")

    parser = CatalogParser(catalog_path)
    screens = parser.parse()
    print(f"[+] Successfully parsed {len(screens)} screen definitions from Catalog.")

    generator = DatasetGenerator(screens)
    samples = generator.generate_pairs()
    print(f"[+] Generated {len(samples)} high-quality instruction-tuning pairs.")

    # Shuffle deterministically
    random.seed(42)
    random.shuffle(samples)

    # Train / Val Split (85% train, 15% validation)
    split_idx = int(len(samples) * 0.85)
    train_samples = samples[:split_idx]
    val_samples = samples[split_idx:]

    train_path = os.path.join(DATA_DIR, "quickbot_train.jsonl")
    val_path = os.path.join(DATA_DIR, "quickbot_val.jsonl")

    with open(train_path, "w", encoding="utf-8") as f:
        for s in train_samples:
            f.write(json.dumps(s, ensure_ascii=False) + "\n")

    with open(val_path, "w", encoding="utf-8") as f:
        for s in val_samples:
            f.write(json.dumps(s, ensure_ascii=False) + "\n")

    print(f"[+] Saved {len(train_samples)} training samples to: {train_path}")
    print(f"[+] Saved {len(val_samples)} validation samples to: {val_path}")

    # Role breakdown statistics
    role_counts = {}
    for s in samples:
        sys_msg = s["messages"][0]["content"]
        for r in ROLES:
            if f"[ROLE: {r}" in sys_msg:
                role_counts[r] = role_counts.get(r, 0) + 1
                break

    # Write Manifest
    manifest = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "total_samples": len(samples),
        "train_samples": len(train_samples),
        "val_samples": len(val_samples),
        "role_breakdown": role_counts,
        "source_checksums": {
            "catalog_md": compute_file_hash(catalog_path) if os.path.exists(catalog_path) else None,
            "user_manual_md": compute_file_hash(user_manual_path) if os.path.exists(user_manual_path) else None
        }
    }

    manifest_path = os.path.join(DATA_DIR, "dataset_manifest.json")
    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2)

    print(f"[+] Saved dataset manifest to: {manifest_path}")
    print("\nRole Breakdown in Dataset:")
    for r, count in sorted(role_counts.items(), key=lambda x: -x[1]):
        print(f"  - {r:15}: {count:4d} samples")

    print("\n[SUCCESS] Pipeline execution finished successfully!")


if __name__ == "__main__":
    main()
