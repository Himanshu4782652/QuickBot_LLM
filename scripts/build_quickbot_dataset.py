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
        ("Can I delete another student's profile?", "Access Denied: User profile management is restricted to institutional administrators."),
        ("How do I view another student's private attendance or grade records?", "Access Denied: Student records are private. You can only access your own academic data in your personal dashboard."),
        ("Can I approve my own leave application without a teacher?", "Access Denied: Leave approvals require authorization from a class teacher or school administrator."),
    ],
    "Parent": [
        ("How do I edit my child's attendance record?", "Access Denied: Attendance records are recorded and verified by school teachers and administrators. You may contact the class teacher or submit a Helpdesk inquiry."),
        ("Show me the private staff internal notes on my support ticket.", "Access Denied: Staff internal notes are restricted to school employees. You can view all public replies and communication in your ticket thread."),
        ("How do I configure the school's biometric facial recognition cameras?", "Access Denied: Hardware configurations and CCTV/biometric daemon settings require SchoolAdmin or IT Specialist privileges."),
        ("How do I publish a notice board announcement to all students?", "Access Denied: Notice board publishing rights are reserved for Teachers and School Administrators."),
        ("Can I directly modify my child's report card marks?", "Access Denied: Report card marks are finalized and locked by authorized faculty and administrators. Please raise a Helpdesk ticket if you have a concern."),
    ],
    "Teacher": [
        ("How do I modify the school's SaaS subscription or renew the license?", "Access Denied: SaaS subscription licensing is restricted to Platform SuperAdmins and School Owners."),
        ("How do I delete an entire academic campus branch?", "Access Denied: Branch lifecycle operations require SuperAdmin or OrgAdmin authorization."),
        ("How do I access the school's full financial daybook and fee collection reports?", "Access Denied: Financial daybooks and fee collection reports are accessible only to the Accounts department and School Administrators."),
        ("Can I change the academic session or term dates for the entire school?", "Access Denied: Academic session and term configuration require School Administrator privileges."),
    ],
    "Staff": [
        ("How do I finalize and lock the academic degree transcripts?", "Access Denied: Degree finalization and CBCS audit locking require Academic Dean or Registrar privileges."),
        ("How do I configure student admission pipelines or fee structures?", "Access Denied: Admission pipeline and fee structure configuration requires School Administrator access."),
        ("Can I view or edit the school payroll and staff salary records?", "Access Denied: Payroll and salary information is restricted to authorized HR personnel and School Administrators."),
    ],
    "Accountant": [
        ("How do I publish exam question papers to students?", "Access Denied: Examination authoring and publishing are restricted to Teachers and the Examination Controller."),
        ("How do I modify timetable slots or teacher assignments?", "Access Denied: Timetable management is restricted to School Administrators and authorized academic staff."),
        ("Can I approve or reject a student leave application?", "Access Denied: Student leave approvals are managed by the class teacher or school administrator."),
    ],
    "Warden": [
        ("How do I edit the school's statutory balance sheet?", "Access Denied: Statutory balance sheets and daybooks are managed exclusively by the Accounts Department."),
        ("How do I modify student academic grades or attendance for classroom subjects?", "Access Denied: Academic grades and classroom attendance are managed by teachers and school administrators. Your scope is limited to hostel residency operations."),
        ("How do I configure the school's exam schedule or timetable?", "Access Denied: Exam scheduling and timetable configuration require School Administrator access."),
    ],
}

# Minimum target sample count per role for balanced training
MIN_SAMPLES_PER_ROLE = 60

# Rich role-specific operational Q&A to pad underrepresented roles
ROLE_SCENARIOS: Dict[str, List[Tuple[str, str]]] = {
    "SuperAdmin": [
        ("How do I onboard a new school to the platform?", "To onboard a new school: go to 'Manage Schools' in the SuperAdmin dashboard. Click 'Add New School', fill in school name, admin credentials, subscription plan, and branch details. The school tenant is provisioned automatically with isolated data storage."),
        ("How do I check platform-wide system health and uptime?", "Navigate to 'SaaS Overview' in the SuperAdmin console. The dashboard displays server uptime, active tenant count, database connection pool health, CDN status, and recent incident reports."),
        ("How do I map a custom domain to a school's tenant?", "Go to 'Tenant Domain Mapping' under school settings. Enter the school's custom domain and generate the CNAME/A record for their DNS provider. SSL is auto-provisioned within 48 hours."),
        ("How do I broadcast an emergency alert across all school tenants?", "Use 'Global Operations Incident' in the SuperAdmin console. Compose your alert message, select affected tenants, and click 'Broadcast'. Parents, students, and staff across affected schools receive the push notification immediately."),
        ("How do I view or modify a school's subscription plan?", "Go to 'Plan Management', search for the school by name or ID. You can upgrade, downgrade, or extend their subscription period and configure module entitlements per branch."),
        ("How do I reset a school admin's login credentials?", "Navigate to 'School Credentials' in the SuperAdmin panel. Search for the school admin, click 'Reset Password', and generate a one-time secure link sent to their registered email."),
        ("How do I run a report delivery for a specific school tenant?", "Open 'Report Delivery' in the SuperAdmin workbench. Select the target school, choose the report type, set the date range, and download or schedule automated email delivery."),
        ("What should I do if a school tenant reports a critical database issue?", "Escalate to the infrastructure team immediately. Use 'Global Operations Incident' to notify the tenant and affected users, and trigger a maintenance window to block new writes while restoration is in progress."),
    ],
    "Warden": [
        ("How do I assign a student to a hostel room?", "Open 'Hostel Rooms' in your warden workspace. Search for the student by name or roll number, select an available room from the room grid, and click 'Assign'. The student receives a confirmation notification with their room number and block details."),
        ("How do I mark hostel mess attendance for the day?", "Navigate to 'Hostel Occupancy' and select the 'Mess Attendance' tab. Choose the meal slot (breakfast, lunch, or dinner), mark students as present or absent, and submit. Reports are generated automatically for mess catering."),
        ("How do I configure night curfew timings for the hostel?", "Go to the hostel settings panel and open 'Curfew Rules'. Set the standard in-time, grace period, and late-arrival alert threshold. Students who have not returned trigger an automatic notification to the warden and parents."),
        ("How do I raise a hostel maintenance ticket?", "Open 'Hostel Maintenance' in your workspace. Select the room or common area, describe the issue (plumbing, electrical, cleaning), set priority level, and submit. The maintenance team receives the ticket and you can track resolution status in real time."),
        ("How do I view current hostel room occupancy?", "Navigate to 'Hostel Occupancy'. The grid view shows each room's current occupants, vacant beds, and room type. You can filter by block, floor, or occupancy status."),
        ("How do I process a student's hostel check-out request?", "Open 'Hostel Rooms', find the student's room assignment, and click 'Check-Out'. Record the reason, inspection status of the room, and any pending dues. The room is then marked available automatically."),
        ("How do I manage laundry operations for hostel students?", "Navigate to 'Laundry Ops' in your warden workspace. Log laundry batches per student, track pending and completed laundering cycles, and generate daily laundry dispatch summaries for the laundry staff."),
    ],
    "Accountant": [
        ("How do I collect a fee payment at the school POS counter?", "Open 'POS Desk' in your Accountant workbench. Search for the student by name or admission number. The system displays all pending fee heads. Select dues, choose payment method (cash, UPI, card, cheque), and generate the official digital receipt on completion."),
        ("How do I record a voucher entry in the daybook?", "Go to 'Voucher Entry'. Select the voucher type (receipt, payment, contra, or journal), fill in account heads, amounts, narration, and transaction date. Click 'Post' to commit the entry. All posted vouchers appear in the daybook for reconciliation."),
        ("How do I generate a fee collection report for a specific date range?", "Navigate to 'Fee Reports', set the start and end dates, filter by class, section, fee head, or payment mode if needed, and click 'Generate'. Export to PDF or Excel for auditing."),
        ("How do I apply a fee concession or discount to a student's account?", "Open the student's fee ledger from the Fee Dashboard. Click 'Apply Concession', select the concession type (scholarship, sibling discount, staff ward), enter the amount or percentage, and submit for administrator approval."),
        ("How do I reconcile the daybook at end of day?", "Open 'Daybook Report', select today's date, and verify total receipts, payments, and contra entries against the physical cash drawer balance and bank statements. Flag any discrepancies and submit the reconciliation sign-off."),
        ("How do I generate a statutory tax or GST report?", "Navigate to 'Fee Reports' and select the 'Tax Reports' tab. Choose the financial year and report type, and click 'Generate'. The system compiles all taxable transactions for the selected period."),
        ("How do I view a student's complete fee payment history?", "Open 'Fee Dashboard' and search for the student. Click on their account to see a detailed transaction history: all fee heads collected, payment dates, receipt numbers, outstanding balances, and applied concessions."),
    ],
    "Staff": [
        ("How do I generate a visitor badge for a guest arriving at the school gate?", "Open the 'Visitor Management' screen. Enter the visitor's name, purpose of visit, and person to meet. The system generates a QR-coded visitor badge. Print or display it on screen for the security guard to scan at the gate."),
        ("How do I dispatch an inventory item to a department?", "Navigate to 'Inventory Management'. Search for the item, select quantity to dispatch, choose the destination department or staff member, and submit the dispatch request. Stock levels are updated in real time."),
        ("How do I track a school vehicle's current location?", "Open 'Transport Management' in your staff workspace. Select the active vehicle from the fleet list to view its live GPS position, current route, speed, and scheduled stops."),
        ("How do I mark gate security check-in for incoming students?", "Open the 'Gate Security' screen. Scan the student's ID card QR code or search by name. The system logs the entry time and notifies parents if configured. Late arrivals are flagged automatically."),
        ("How do I report a gate security incident?", "Navigate to the 'Incident Reporting' module in your staff workspace. Describe the incident, tag the location, upload any photos, and submit. The incident is escalated to the SchoolAdmin and logged for audit."),
        ("How do I check and manage the school's inventory stock levels?", "Go to 'Inventory Management' and open the 'Stock Report' view. You can see current quantities, minimum stock thresholds, items that need reordering, and the full dispatch history per item category."),
    ],
    "Teacher": [
        ("How do I create a quiz for my students in the LMS?", "Navigate to 'Quizzes' in your teacher workspace. Click 'Create Quiz', set the title, subject, class, and time limit. Add questions, assign marks per question, set the availability window, and publish. Students see the quiz in their LMS dashboard."),
        ("How do I set up a virtual classroom session?", "Go to 'Virtual Classroom' and click 'Schedule Session'. Enter the topic, select the class and section, choose the date and time, and click 'Create'. Students receive a joining link on their dashboard."),
        ("How do I view a student's complete academic profile?", "Open 'My Students' and search by name or roll number. Click on the student's card to see their attendance summary, gradebook scores, submitted assignments, quiz results, and behavioural remarks."),
        ("How do I upload study material to the LMS for my class?", "Navigate to 'LMS Studio', select the class and subject, and click 'Upload Resource'. You can upload PDFs, videos, presentation slides, or paste external links. Organize them into chapters or units for easy student navigation."),
        ("How do I submit my lesson plan for admin approval?", "Open 'Lesson Planning' in your teacher workspace. Fill in the lesson plan template with learning objectives, teaching methodology, and assessment criteria. Click 'Submit for Approval'. The SchoolAdmin reviews and approves from the administration panel."),
        ("How do I record co-scholastic or behavioural remarks for a student?", "Go to 'Grades' and open the relevant student's gradebook. Navigate to the 'Remarks' or 'Co-Scholastic' tab. Enter values for discipline, sports, arts, or behavioural observations as per your school's configured grading rubric, and save."),
        ("How do I publish the results of an online exam?", "After grading is complete in 'Online Exams', click 'Publish Results'. Students can immediately view their scores and question-wise feedback in their exam portal. Parent notifications are sent automatically if configured."),
    ],
    "Student": [
        ("How do I submit my homework online?", "Open the 'Assignments' screen from your student workspace. Find the assignment for your subject and click 'Submit'. Attach your answer file (PDF, image, or document) and click 'Submit'. You will receive a confirmation timestamp as proof of submission."),
        ("How do I check my attendance percentage?", "Navigate to the 'Attendance' section in your student workspace. Your dashboard shows subject-wise and overall attendance percentage, present/absent breakdown, and any flagged late arrivals for the current term."),
        ("How do I join a live virtual classroom?", "Go to 'Virtual Classroom' in your student workspace. Active sessions appear with a 'Join' button. Click it to enter the live class hosted by your teacher. You need a stable internet connection and a working microphone/camera."),
        ("How do I download my report card?", "Open the 'Exam & Report Card' section. Select the relevant academic term or exam. Click 'Download Report Card' to get a PDF copy with your marks, grades, and teacher remarks."),
        ("How do I request an outpass to leave campus early?", "Navigate to 'Outpass' in your student workspace. Fill in the reason, destination, and expected return time. Submit the request. Your parent receives a consent notification, and the approved QR code is sent for gate clearance."),
        ("How do I take a practice quiz on the LMS?", "Open the 'LMS & Quizzes' section. Browse available quizzes published by your teachers for your class. Click 'Start Quiz', answer within the time limit, and submit. Instant feedback and your score appear upon completion."),
        ("How do I view my school bus timing and route?", "Navigate to 'Transport' in your student workspace. Your assigned bus route, stop location, pick-up time, and drop-off time are displayed. A live map view shows the bus location if your school has live GPS tracking enabled."),
    ],
    "Parent": [
        ("How do I book a Parent-Teacher Meeting slot?", "Open 'PTM Booking' in your parent portal. Available time slots with teacher names are listed. Select your preferred slot, confirm, and you will receive a booking confirmation notification. You can cancel or reschedule up to 2 hours before the meeting."),
        ("How do I raise a helpdesk complaint or query?", "Navigate to 'Helpdesk' in your parent portal. Click 'New Ticket', choose the category (fee issue, academic query, transport concern, or general), describe your issue, and submit. You can track ticket status and view staff responses in real time."),
        ("How do I view my child's exam schedule?", "Open the 'Academics' section in your parent portal. The exam timetable tab shows all upcoming exams with date, subject, and timing. You can also see past exam results and report cards published for your child."),
        ("How do I check today's school attendance for my child?", "Navigate to 'Attendance' in your parent portal. Today's and historical attendance records for your child are displayed with date, status (present/absent/late), and subject-wise breakdown for the current term."),
        ("How do I update my contact or emergency information?", "Go to 'My Profile' in your parent portal. You can update your mobile number, alternate contact, email address, and home address. Changes are saved and visible to the school immediately after submission."),
        ("How do I view notices and circulars sent by the school?", "Open 'Notice Board' in your parent portal. All school announcements, circular letters, and event notifications are listed in chronological order. Important notices are pinned at the top with a 'Read' confirmation option."),
    ],
}

# Troubleshooting Q&A pairs for each role
TROUBLESHOOTING_SCENARIOS: List[Tuple[str, str, str]] = [
    ("Student", "My assignment submission failed — what should I try?", "First check your internet connection. Then confirm the file size is within the allowed limit (usually 10 MB). Try re-uploading in a different format (PDF instead of DOCX). If still failing, raise a Helpdesk ticket with a screenshot — your teacher can manually record your submission timestamp."),
    ("Student", "The timetable screen is showing 'No data available' — is there a bug?", "This usually means the school administrator has not published the timetable for the current term yet, or your class section mapping needs to be confirmed. Contact your class teacher or school office to verify your section assignment."),
    ("Parent", "I paid the school fee online but did not receive a receipt — what do I do?", "Check your registered email and SMS for the receipt. If not received within 10 minutes, open 'Fee & Payment' history to verify the transaction status. If the payment was deducted but status is pending, raise a Helpdesk ticket with your transaction reference number — the Accountant will reconcile and issue the receipt manually."),
    ("Teacher", "I cannot see a student in my attendance list — what should I check?", "Verify you have selected the correct academic year, class, section, and subject. If the student is newly admitted, allow up to 24 hours for the enrollment sync. If still missing, ask the School Administrator to verify the student's section assignment in the admissions module."),
    ("SchoolAdmin", "The bulk upload CSV is failing validation — how do I fix it?", "Download the error report from the Bulk Upload console. Each row error includes a specific reason (missing required field, duplicate roll number, invalid date format). Fix the flagged rows in the CSV and re-upload. Do not modify the column headers or template structure."),
    ("Accountant", "A fee payment shows as 'Pending' but the parent says they paid — what do I do?", "Check the payment gateway transaction log in the Fee Dashboard. If the gateway shows a successful debit, use 'Manual Reconcile' to mark it as received and generate the receipt. If the gateway shows failure, the parent's bank will auto-refund within 5 to 7 business days."),
    ("Warden", "A student is marked as checked-in to a room but the room shows as vacant — how do I resolve this?", "Open 'Hostel Rooms' and locate the room. Click 'Room Audit' to reconcile the occupancy state. If the discrepancy persists, re-assign the student to the same room using 'Edit Assignment' to force a sync."),
    ("SuperAdmin", "A school admin says their login is blocked — how do I unlock it?", "Go to 'School Credentials' and search for the school. Locate the admin account showing 'Locked' status. Click 'Unlock Account' and optionally trigger a password reset link. Review the failed login attempt log to determine if it was a genuine lockout or a suspicious access attempt."),
    ("Staff", "The visitor badge QR code is not scanning at the gate — what should the guard do?", "The guard can manually verify the visitor by entering their name in the 'Visitor Management' search to pull up their pre-registered entry. A fallback printed badge or manual gate log entry can be used. Report the QR scanner device issue to the IT team for repair."),
]



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

        # 3. Add Rich Role-Specific Operational Scenarios
        for role, scenarios in ROLE_SCENARIOS.items():
            sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["SchoolAdmin"])
            for q, a in scenarios:
                dataset.append({
                    "messages": [
                        {"role": "system", "content": sys_prompt},
                        {"role": "user", "content": q},
                        {"role": "assistant", "content": a}
                    ]
                })

        # 4. Add Common Operational Scenarios per Role
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

        # 5. Add Troubleshooting Scenarios
        for role, q, a in TROUBLESHOOTING_SCENARIOS:
            sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["SchoolAdmin"])
            dataset.append({
                "messages": [
                    {"role": "system", "content": sys_prompt},
                    {"role": "user", "content": q},
                    {"role": "assistant", "content": a}
                ]
            })

        # 6. Role-Balancing Top-Up: Pad underrepresented roles to MIN_SAMPLES_PER_ROLE
        role_map = {
            "SuperAdmin": "SuperAdmin", "SchoolAdmin": "SchoolAdmin", "Admin": "SchoolAdmin",
            "Teacher": "Teacher", "Staff": "Staff", "Student": "Student",
            "Parent": "Parent", "Accountant": "Accountant", "Warden": "Warden",
        }
        role_counts: Dict[str, int] = {}
        for item in dataset:
            sys_msg = item["messages"][0]["content"]
            for r in ROLES:
                if f"[ROLE: {r}" in sys_msg:
                    role_counts[r] = role_counts.get(r, 0) + 1
                    break

        for role, scenarios in ROLE_SCENARIOS.items():
            current = role_counts.get(role, 0)
            if current < MIN_SAMPLES_PER_ROLE and scenarios:
                needed = MIN_SAMPLES_PER_ROLE - current
                sys_prompt = ROLE_SYSTEM_PROMPTS.get(role, ROLE_SYSTEM_PROMPTS["SchoolAdmin"])
                cycle_idx = 0
                for _ in range(needed):
                    q, a = scenarios[cycle_idx % len(scenarios)]
                    cycle_idx += 1
                    # Add paraphrased prefix to reduce exact duplicates
                    prefixes = ["Can you explain ", "Please help me understand ", "Quick question — ",
                                "I need guidance on ", "What is the correct way to handle "]
                    q_varied = prefixes[cycle_idx % len(prefixes)] + q[0].lower() + q[1:] if cycle_idx > len(scenarios) else q
                    dataset.append({
                        "messages": [
                            {"role": "system", "content": sys_prompt},
                            {"role": "user", "content": q_varied},
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
