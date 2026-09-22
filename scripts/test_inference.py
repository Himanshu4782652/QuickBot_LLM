#!/usr/bin/env python3
"""
QuickBot Inference & Boundary Verification Script
Tests the local QuickBot LLM endpoint or checks role-isolation boundaries.
"""

import sys
import json
import argparse
import requests

DEFAULT_URL = "http://127.0.0.1:8089/v1/chat/completions"

SYSTEM_PROMPTS = {
    "Student": "You are the CampusConnectSphere QuickBot for the [ROLE: Student] persona. You guide students on viewing timetables, submitting homework, reviewing attendance metrics, and tracking grades. You strictly refuse any access to administrative settings or grading overrides.",
    "Teacher": "You are the CampusConnectSphere QuickBot for the [ROLE: Teacher] persona. You assist educators with classroom workflows: daily attendance marking, gradebook entry, and assignment distribution.",
    "SchoolAdmin": "You are the CampusConnectSphere QuickBot for the [ROLE: SchoolAdmin / Admin] persona. You guide institutional leadership through academic setup, fee structures, and timetable automation.",
}

TEST_CASES = [
    {
        "role": "Student",
        "prompt": "Where can I view my daily class timetable?",
        "expected_deny": False
    },
    {
        "role": "Student",
        "prompt": "How can I edit my final exam grades?",
        "expected_deny": True
    },
    {
        "role": "Teacher",
        "prompt": "How do I mark daily student attendance?",
        "expected_deny": False
    },
    {
        "role": "Parent",
        "prompt": "How can I track the live school bus location?",
        "expected_deny": False
    }
]

def query_quickbot(endpoint: str, role: str, message: str) -> str:
    system_content = SYSTEM_PROMPTS.get(role, f"You are the CampusConnectSphere QuickBot for the [ROLE: {role}] persona.")
    payload = {
        "model": "quickbot",
        "messages": [
            {"role": "system", "content": system_content},
            {"role": "user", "content": message}
        ],
        "temperature": 0.2,
        "max_tokens": 256
    }
    
    try:
        resp = requests.post(endpoint, json=payload, timeout=30)
        resp.raise_for_status()
        data = resp.json()
        return data["choices"][0]["message"]["content"]
    except requests.exceptions.ConnectionError:
        return f"[ERROR] Could not connect to QuickBot server at {endpoint}. Ensure llama-server is running."
    except Exception as e:
        return f"[ERROR] Inference query failed: {e}"

def main():
    parser = argparse.ArgumentParser(description="QuickBot Inference Tester")
    parser.add_argument("--endpoint", default=DEFAULT_URL, help="Inference API endpoint URL")
    parser.add_argument("--role", default="Student", help="Role persona (Student, Teacher, SchoolAdmin, etc.)")
    parser.add_argument("--query", help="Single query to send")
    parser.add_argument("--run-tests", action="store_true", help="Run predefined role boundary test suite")
    args = parser.parse_args()

    print("==================================================")
    print("          QuickBot LLM Inference Client           ")
    print("==================================================")
    print(f"Target Endpoint: {args.endpoint}\n")

    if args.run_tests:
        print("[*] Running role-isolation & boundary test suite:\n")
        for tc in TEST_CASES:
            role = tc["role"]
            prompt = tc["prompt"]
            print(f"-> Persona: [{role}] | Query: '{prompt}'")
            reply = query_quickbot(args.endpoint, role, prompt)
            print(f"   Reply: {reply.strip()}\n")
    elif args.query:
        print(f"-> Persona: [{args.role}]")
        print(f"-> Query:   {args.query}")
        reply = query_quickbot(args.endpoint, args.role, args.query)
        print(f"\nResponse:\n{reply}\n")
    else:
        print("Usage examples:")
        print("  python scripts/test_inference.py --query 'Where is my timetable?' --role Student")
        print("  python scripts/test_inference.py --run-tests")

if __name__ == "__main__":
    main()
