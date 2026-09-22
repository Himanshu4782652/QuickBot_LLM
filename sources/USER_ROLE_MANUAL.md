# CampusConnectSphere User Role Manual

This is the operational manual for the current role-based product.

Use it for:

- role onboarding
- training
- UAT preparation
- day-to-day operating reference

## Common Experience

### 1. School Branding And Login

Users can reach the app by school search or by a mapped school domain.

When branding is configured, the platform can show school-specific:

- logo
- colors
- login background
- app-shell identity
- browser title and favicon

School search requires at least 2 characters.

### 2. Login Models

- staff-style login: email and password
- student login: mobile number and DOB
- parent login: mobile number and child DOB
- SuperAdmin login is platform-scoped rather than school-scoped

### 3. Role Shell

The current app uses:

- a role home or workspace
- a workbench for frequent actions
- `Full menu` for the complete searchable launcher

Users should confirm school, branch, and academic session before entering or approving data.

### 4. Module Locks

Locked menus usually mean a subscription or branch-module restriction, not a broken screen.

### 5. Bulk Upload

`Bulk Upload` is the shared data-exchange console for bulk import and export.

It should be used for:

- onboarding
- annual setup
- controlled master-data updates

It should not be used for:

- live collections
- daily attendance marking
- payroll approvals
- live notifications or campaign sending

## Role Guides

### SuperAdmin

Purpose:

- manage schools, subscriptions, credentials, and tenant-wide visibility

Main areas:

- SaaS Overview
- Manage Schools
- Plan Management
- School Credentials
- Report Delivery

Good practice:

- stay at platform level
- avoid school-level daily operations unless debugging

### SchoolAdmin and Admin

Purpose:

- run school setup, oversight, and cross-module operations

Main areas:

- admissions and enquiry pipeline
- finance and daybook
- communication and campaigns
- report governance
- Report Studio authoring, asset management, preview, and publish workflow
- staff access and master setup
- timetable setup
- school branding in `My Profile & School Branding` (supports high-resolution logos up to 10 MB and background assets up to 15 MB)
- `Bulk Upload` for controlled data onboarding

Typical start-of-term work:

1. confirm school branding, branches, sessions, and groups
2. validate teacher, subject, timetable, and academic setup
3. review finance setup, Report Studio definitions, and staff access
4. use `Bulk Upload` for onboarding or large setup corrections
5. preview and publish governed report layouts only after review

### Teacher and Staff

Purpose:

- execute classroom and delegated operational workflows

Teacher areas:

- My Students
- Grades
- Assignments
- Quizzes
- Online Exams
- LMS Studio
- Virtual Classroom
- Timetable
- Notice Board

Staff areas vary by deployment and may include:

- admissions support
- visitor
- inventory support
- transport
- hostel support
- gallery or laundry operations

Good practice:

- stay within assigned groups and modules
- do not bypass published or locked academic states

### Accountant and Warden

Purpose:

- run finance execution and hostel execution workflows

Accountant areas:

- Financials
- Fee Dashboard
- Voucher Entry
- Daybook Report
- Fee Reports
- POS Desk

Warden areas:

- Hostel Rooms
- Hostel Occupancy
- Laundry Ops

Good practice:

- use exports for review and reconciliation
- reserve bulk finance or hostel setup changes for approved admin-led data loads

### Student, Parent, and Alumni

Student areas:

- timetable
- assignments
- LMS and live classes
- exams and report card
- attendance and fee visibility
- certificates, notices, wallet, and other enabled modules

Parent areas:

- child visibility
- PTM bookings
- fee and notice visibility
- helpdesk and school communication

Alumni areas:

- alumni profile
- alumni events
- alumni job posts
- alumni notices where enabled

### Specialist Roles

Specialist roles such as `AdmissionOfficer`, `Librarian`, and `HR` use focused workspaces granted by the school.

Their access is usually narrower than Admin or SchoolAdmin and should be kept task-specific.

## Cross-Role Rules

- always verify school, branch, and session context first
- search before creating duplicate records
- use published and approved workflows as the source of truth
- use the bulk console only for controlled setup, not live transactional work
- escalate permissions, locking, or workflow-state issues instead of forcing data edits

## Troubleshooting

### School not visible

- enter at least 2 characters in school search
- if the school uses a mapped domain, confirm the correct domain is being used

### Data cannot be edited

- check whether the record is published, approved, posted, locked, or finalized

### Screen is visible but unusable

- check module entitlement and branch-module access

### Bulk upload fails

- start with the downloaded template
- validate before commit
- fix row-level errors instead of forcing partial data manually
