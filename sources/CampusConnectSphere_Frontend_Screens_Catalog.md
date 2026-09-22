# CampusConnectSphere - Complete Frontend Screens & Backend API Catalog

**Platform:** Multi-Tenant School ERP, Higher Education & Enterprise SaaS  
**Frontend Framework:** Flutter 3.x (Web, Windows, macOS, Linux, Android, iOS)  
**Authoritative Backend:** .NET 8 Web API, PostgreSQL, Redis, Hangfire, SignalR  
**Document Generated:** September 2026  

---

## 🏛️ 1. Architecture & Navigation Summary

The **CampusConnectSphere** frontend (`campus_connect_app`) operates as a single unified codebase catering to every persona—from Platform SuperAdmin to Students and Parents.

### Key Architectural Pillars:
1. **Dynamic Morphing & Role Shell (`lib/app_shell.dart`, `lib/menu_config.dart`):**
   - Evaluates the authenticated user's role and allowed SaaS module entitlements.
   - **Desktop / Web (> 950px):** Renders a full Workbench layout with a collapsible sidebar, dynamic header breadcrumbs, multi-school/branch context switcher, and global omni-search overlay.
   - **Tablet (600px - 950px):** Collapses into an icon-only navigation rail and responsive multi-column card grids.
   - **Mobile (< 600px):** Bottom navigation bar, modal sheet actions, and single-column touch layouts.
2. **Multi-Tenancy & Custom Domains (`lib/providers/branding_provider.dart`):**
   - Automatically detects custom school domains and vanity subdomains (`*.campusconnectsphere.com` or private CNAMEs).
   - Injects tenant headers (`X-School-Context`, `X-Branch-Id`) into every outbound HTTP request via `ApiClient`.
3. **Real-Time Sockets:**
   - Persistent SignalR hubs (`LocalNotificationService`, `BiDashboardHub`, `ChatHub`) stream instant push notifications, live bus GPS telemetry, and 60-second BI metric delta pushes.
4. **Offline Resilience (`lib/services/offline_cache_service.dart`):**
   - Offline punch queues for biometrics, local fee cache, and automatic conflict reconciliation when network connectivity resumes.

---

## 📱 2. Complete Categorized Screen Directory

---

### Module 1: Authentication, Onboarding & Multi-Tenant Setup

#### 1. `LoginScreen`
- **File:** `campus_connect_app/lib/login_screen.dart`
- **Target Roles:** Public / Unauthenticated Users (Students, Parents, Teachers, Staff, Admins, SuperAdmins)
- **Function & What It Does:** Multi-persona authentication portal. Supports Username/Password, Phone OTP login, School ID selector dropdown, Biometric Fingerprint/FaceID sign-in, and SAML 2.0/OIDC SSO redirection. Adapts colors and institution crest based on the active school domain.
- **Backend APIs Called:**
  - `POST /api/Auth/login`
  - `POST /api/Auth/phone-login`
  - `POST /api/Auth/refresh`
  - `GET /api/Branding/public/{domain}`
  - `GET /api/MasterConfig/schools`

#### 2. `ForgotPasswordOtpScreen`
- **File:** `campus_connect_app/lib/forgot_password_otp_screen.dart`
- **Target Roles:** Public / Unauthenticated Users
- **Function & What It Does:** 3-step self-service credential recovery wizard. Dispatches SMS/Email 6-digit OTP, validates with expiration timer, checks password complexity rules, and resets user password.
- **Backend APIs Called:**
  - `POST /api/Auth/forgot-password/request-otp`
  - `POST /api/Auth/forgot-password/verify-otp`
  - `POST /api/Auth/forgot-password/reset`

#### 3. `ProductHomeScreen`
- **File:** `campus_connect_app/lib/screens/product_home_screen.dart`
- **Target Roles:** Public Visitors, Prospective Institutions
- **Function & What It Does:** Multi-product landing page showcasing CampusConnectSphere product lines (K-12 eSiksha, Higher Education CBCS, and WorkLife Connect HR). Features interactive module feature cards, pricing tiers, and direct login / registration CTAs.
- **Backend APIs Called:**
  - `GET /api/PlatformPublic/plans`
  - `GET /api/PlatformPublic/features`

#### 4. `TenantPublicLandingScreen`
- **File:** `campus_connect_app/lib/screens/tenant_public_landing_screen.dart`
- **Target Roles:** Public Visitors, Prospective Parents, Students
- **Function & What It Does:** Dedicated public institution homepage for schools using white-labeled subdomains. Displays institution gallery, principal's address, academic highlights, public notices, and admission inquiry links.
- **Backend APIs Called:**
  - `GET /api/Branding/tenant-info`
  - `GET /api/Notice/public`

#### 5. `OrganizationSignupScreen`
- **File:** `campus_connect_app/lib/screens/organization_signup_screen.dart`
- **Target Roles:** Institutional Founders, School Board Members
- **Function & What It Does:** Self-service institution registration wizard. Collects organization legal details, primary campus, board affiliation (CBSE/ICSE/IB/State/HigherEd), creates primary administrator credentials, and provisions trial tenant space.
- **Backend APIs Called:**
  - `POST /api/Onboarding/register-institution`
  - `GET /api/MasterConfig/curriculums`

#### 6. `RoleHomeScreen`
- **File:** `campus_connect_app/lib/screens/role_home_screen.dart`
- **Target Roles:** All Authenticated Users
- **Function & What It Does:** Contextual workspace home displaying user profile badges, customized quick-access action cards, unread notification summaries, and daily focus items tailored to the user's role.
- **Backend APIs Called:**
  - `GET /api/Dashboard/user-summary`
  - `GET /api/Notification/unread-count`

#### 7. `LanguageSettingsScreen`
- **File:** `campus_connect_app/lib/screens/language_settings_screen.dart`
- **Target Roles:** All Authenticated Users
- **Function & What It Does:** Multilingual UI locale switcher supporting 10+ languages (English, Hindi, Tamil, Telugu, Marathi, Kannada, Bengali, Gujarati, Malayalam, Arabic). Updates runtime app localization and persists preference to the server.
- **Backend APIs Called:**
  - `POST /api/UserPreferences/language`

#### 8. `SecuritySettingsScreen`
- **File:** `campus_connect_app/lib/screens/security_settings_screen.dart`
- **Target Roles:** All Authenticated Users
- **Function & What It Does:** Account security console for configuring Two-Factor Authentication (TOTP / SMS), changing account password, reviewing active device sessions, and revoking suspicious tokens.
- **Backend APIs Called:**
  - `POST /api/Auth/change-password`
  - `GET /api/Auth/active-sessions`
  - `DELETE /api/Auth/active-sessions/{sessionId}`
  - `POST /api/Auth/2fa/setup`

#### 9. `WorklifeTimezoneSettingsScreen`
- **File:** `campus_connect_app/lib/screens/worklife_timezone_settings_screen.dart`
- **Target Roles:** Admin, SchoolAdmin, HR Manager
- **Function & What It Does:** Multi-branch global timezone and Daylight Saving Time (DST) configurator. Standardizes biometric attendance punch timestamps across campuses in different timezones.
- **Backend APIs Called:**
  - `GET /api/SchoolProfile/timezone-config`
  - `PUT /api/SchoolProfile/timezone-config`

---

### Module 2: Core School Administration & Multi-Branch Operations

#### 10. `AdminDashboardScreen`
- **File:** `campus_connect_app/lib/admin_dashboard_screen.dart`
- **Target Roles:** Admin, SchoolAdmin, Principal
- **Function & What It Does:** Central operational dashboard displaying real-time counters (Student Count, Staff Present, Today's Fee Collection, Low Attendance Alerts), quick operational shortcuts, recent audit events, and fee collection charts.
- **Backend APIs Called:**
  - `GET /api/Dashboard/admin-summary`
  - `GET /api/AttendanceAnalytics/today-stats`
  - `GET /api/Fees/collection-summary`
  - `GET /api/AdminAudit/recent`

#### 11. `AdminBranchScreen`
- **File:** `campus_connect_app/lib/admin_branch_screen.dart`
- **Target Roles:** OrgAdmin, SuperAdmin, Multi-Campus Director
- **Function & What It Does:** Multi-campus directory allowing administrators to register new branches, configure branch geofences (lat/long radius), define branch code prefixes, and assign branch directors.
- **Backend APIs Called:**
  - `GET /api/Branch`
  - `POST /api/Branch`
  - `PUT /api/Branch/{id}`
  - `DELETE /api/Branch/{id}`

#### 12. `AdminBranchModuleConfigScreen`
- **File:** `campus_connect_app/lib/admin_branch_module_config_screen.dart`
- **Target Roles:** OrgAdmin, SchoolAdmin
- **Function & What It Does:** Modular SaaS feature gating matrix allowing administrators to enable or disable specific ERP modules (e.g. Canteen POS, Hostel, Transport, AI Attendance) for individual branches.
- **Backend APIs Called:**
  - `GET /api/Branch/{id}/modules`
  - `PUT /api/Branch/{id}/modules`

#### 13. `AdminSubadminScreen`
- **File:** `campus_connect_app/lib/admin_subadmin_screen.dart`
- **Target Roles:** Admin, SchoolAdmin
- **Function & What It Does:** Sub-administrator user manager. Assigns operational roles (Fee Clerk, Attendance In-Charge, Transport Coordinator, Academic Head) with scoped branch permissions.
- **Backend APIs Called:**
  - `GET /api/Role/subadmins`
  - `POST /api/Role/subadmins`
  - `DELETE /api/Role/subadmins/{id}`

#### 14. `AdminMasterSetupScreen`
- **File:** `campus_connect_app/lib/admin_master_setup_screen.dart`
- **Target Roles:** Admin, Academic In-Charge
- **Function & What It Does:** Master academic setup console. Configures Academic Sessions/Years, Grades/Classes, Class Sections, Academic Streams, Departments, Houses, and Student Categories.
- **Backend APIs Called:**
  - `GET /api/MasterSetup/all`
  - `POST /api/MasterSetup/classes`
  - `POST /api/MasterSetup/sections`
  - `POST /api/MasterSetup/departments`

#### 15. `AdminRbacPanelScreen` & `AdminRoleManagementScreen`
- **Files:** `campus_connect_app/lib/screens/admin_rbac_panel_screen.dart`, `campus_connect_app/lib/screens/admin_role_management_screen.dart`
- **Target Roles:** Admin, OrgAdmin
- **Function & What It Does:** Granular Role-Based Access Control (RBAC) panel. Manages custom institution roles and toggles Create/Read/Update/Delete permissions across 45+ sub-modules.
- **Backend APIs Called:**
  - `GET /api/Permission/matrix`
  - `POST /api/Permission/update-role-permissions`
  - `GET /api/Role/custom-roles`

#### 16. `AdminUserCredentialsScreen`
- **File:** `campus_connect_app/lib/screens/admin_user_credentials_screen.dart`
- **Target Roles:** Admin, Registrar
- **Function & What It Does:** User credential generator and password reset console. Auto-generates initial usernames and passwords for new admissions, prints credential slips, and sends login info via WhatsApp.
- **Backend APIs Called:**
  - `GET /api/StudentProfile/credentials-list`
  - `POST /api/Auth/admin-reset-password`
  - `POST /api/Broadcast/send-credentials-whatsapp`

#### 17. `AdminAuditLogsScreen`
- **File:** `campus_connect_app/lib/screens/admin_audit_logs_screen.dart`
- **Target Roles:** SuperAdmin, SchoolAdmin, Compliance Officer
- **Function & What It Does:** Immutable audit trail viewer. Records all data modifications (Fee collection, Mark changes, Attendance edits, Staff resignations) with user ID, IP address, timestamp, JSON diffs, and cryptographic hash verification.
- **Backend APIs Called:**
  - `GET /api/AdminAudit/logs?page=1&pageSize=50`
  - `GET /api/AdminAudit/chain/verify`
  - `GET /api/AdminAudit/export-csv`

#### 18. `AdminWhitelabelScreen` & `TenantBrandingSettingsScreen`
- **Files:** `campus_connect_app/lib/screens/admin_whitelabel_screen.dart`, `campus_connect_app/lib/screens/tenant_branding_settings_screen.dart`
- **Target Roles:** OrgAdmin, SuperAdmin
- **Function & What It Does:** Visual white-labeling customizer. Configures primary/secondary brand colors, uploads school crest and favicon, sets custom application title, and verifies custom domain CNAME records.
- **Backend APIs Called:**
  - `GET /api/Branding`
  - `POST /api/Branding/upload-logo`
  - `PUT /api/Branding/colors`
  - `POST /api/Branding/verify-cname`

#### 19. `SchoolAppAdminConsoleScreen`
- **File:** `campus_connect_app/lib/screens/school_app_admin_console_screen.dart`
- **Target Roles:** SuperAdmin, SchoolAdmin
- **Function & What It Does:** White-label mobile APK build automation console. Validates tenant database records, compiles `SCHOOL_APP_MANIFEST_BASE64`, triggers background Flutter build pipelines, and provides live compile logs and APK downloads.
- **Backend APIs Called:**
  - `GET /api/SchoolAppGeneration/status/{schoolId}`
  - `POST /api/SchoolAppGeneration/trigger-build`
  - `GET /api/SchoolAppGeneration/download-apk/{buildId}`

#### 20. `TenantBackupRestoreScreen`
- **File:** `campus_connect_app/lib/screens/tenant_backup_restore_screen.dart`
- **Target Roles:** SuperAdmin, OrgAdmin
- **Function & What It Does:** Tenant disaster recovery console. Generates on-demand database and document storage backups, configures automated backup schedules, and initiates point-in-time database restoration.
- **Backend APIs Called:**
  - `GET /api/TenantBackupRestore/snapshots`
  - `POST /api/TenantBackupRestore/create-snapshot`
  - `POST /api/TenantBackupRestore/restore`

#### 21. `ImportCenterScreen` & `ExportCenterScreen`
- **Files:** `campus_connect_app/lib/screens/import_center_screen.dart`, `campus_connect_app/lib/screens/export_center_screen.dart`
- **Target Roles:** Admin, Data Operator
- **Function & What It Does:** Universal bulk CSV/Excel data import and export hub. Features column mapping wizard, schema validation, dry-run simulation, failure-row export, and mass export of school data.
- **Backend APIs Called:**
  - `POST /api/BulkData/import/{entityType}`
  - `POST /api/BulkData/validate-csv`
  - `GET /api/BulkData/export/{entityType}`

#### 22. `AdminBulkUploadScreen`
- **File:** `campus_connect_app/lib/admin_bulk_upload_screen.dart`
- **Target Roles:** Admin, Registrar
- **Function & What It Does:** Specialized bulk student admission and fee ledger upload desk with sample Excel templates and batch processing progress bars.
- **Backend APIs Called:**
  - `POST /api/BulkData/students/batch-upload`
  - `GET /api/BulkData/templates/{type}`

#### 23. `AdminFormBuilderScreen` & `CustomFormBuilderScreen`
- **Files:** `campus_connect_app/lib/admin_form_builder_screen.dart`, `campus_connect_app/lib/screens/custom_form_builder_screen.dart`
- **Target Roles:** Admin, Admissions Coordinator
- **Function & What It Does:** Drag-and-drop form designer for creating custom student admission forms, event registrations, and feedback surveys with custom fields, dropdowns, and file upload widgets.
- **Backend APIs Called:**
  - `GET /api/SchoolForm/forms`
  - `POST /api/SchoolForm/forms`
  - `PUT /api/SchoolForm/forms/{id}`

---

### Module 3: Admissions, Lead CRM & Inquiries

#### 24. `AdminAdmissionDashboardScreen`
- **File:** `campus_connect_app/lib/admin_admission_dashboard_screen.dart`
- **Target Roles:** Admissions Director, Principal, Admin
- **Function & What It Does:** Admissions funnel metrics dashboard. Tracks inquiries, applications, entrance test assessments, fee collections, and confirmed admissions with conversion charts and marketing source attribution.
- **Backend APIs Called:**
  - `GET /api/Admission/dashboard-kpis`
  - `GET /api/Crm/source-conversion`
  - `GET /api/ScholarVacancy/summary`

#### 25. `AdminAdmissionKanbanScreen`
- **File:** `campus_connect_app/lib/screens/admin_admission_kanban_screen.dart`
- **Target Roles:** Admission Counselor, Marketing Team
- **Function & What It Does:** Interactive drag-and-drop pipeline board (`New Inquiry` ➔ `Follow-Up Scheduled` ➔ `Campus Tour` ➔ `Assessment` ➔ `Offered` ➔ `Admitted`). Supports quick notes, call scheduling, and lead status changes.
- **Backend APIs Called:**
  - `GET /api/Crm/leads/kanban`
  - `PUT /api/Crm/leads/{id}/stage`
  - `POST /api/Crm/leads/{id}/activity`

#### 26. `AdminEnquiryScreen` & `AdminAdmissionsScreen`
- **Files:** `campus_connect_app/lib/admin_enquiry_screen.dart`, `campus_connect_app/lib/admin_admissions_screen.dart`
- **Target Roles:** Front Desk Executive, Admission Counselor
- **Function & What It Does:** Inbound inquiry capture desk. Registers walk-in and web leads, dispatches automated WhatsApp brochures, logs call schedules, and promotes approved leads to formal applications.
- **Backend APIs Called:**
  - `GET /api/DirectInquiry`
  - `POST /api/DirectInquiry`
  - `POST /api/DirectInquiry/{id}/promote-to-admission`
  - `GET /api/Admission/applications`

#### 27. `PublicAdmissionFormScreen` & `DetailedAdmissionFormScreen`
- **Files:** `campus_connect_app/lib/screens/public_admission_form_screen.dart`, `campus_connect_app/lib/detailed_admission_form_screen.dart`
- **Target Roles:** Parents, Prospective Students, Admissions Staff
- **Function & What It Does:** Multi-step admission registration form (Student Information, Guardian Details, Previous Academic History, Document Uploads, and Application Fee Payment via Gateway).
- **Backend APIs Called:**
  - `POST /api/Admission/public-submit`
  - `POST /api/DocumentVault/upload`
  - `POST /api/Fees/create-application-fee-order`

#### 28. `AdminTelecallerCrmScreen`
- **File:** `campus_connect_app/lib/screens/higher_ed/admin_telecaller_crm_screen.dart`
- **Target Roles:** Telecallers, Admission Counselors
- **Function & What It Does:** High-volume telecalling queue. Features click-to-call, disposition logging (`Interested`, `Callback`, `Unreachable`, `Enrolled`), and daily call quota progress trackers.
- **Backend APIs Called:**
  - `GET /api/Crm/telecaller/queue`
  - `POST /api/Crm/telecaller/log-call`

#### 29. `ApplicationReviewScreen`
- **File:** `campus_connect_app/lib/application_review_screen.dart`
- **Target Roles:** Principal, Admissions Committee
- **Function & What It Does:** Formal application review and decision portal. Reviews applicant entrance scores, conducts interviews, issues official admission offers, assigns scholar numbers, and generates PDF admission letters.
- **Backend APIs Called:**
  - `PUT /api/Admission/applications/{id}/decision`
  - `GET /api/Admission/applications/{id}/letter-pdf`

#### 30. `AdminSeatManagementScreen`
- **File:** `campus_connect_app/lib/admin_seat_management_screen.dart`
- **Target Roles:** Admissions Director, Registrar
- **Function & What It Does:** Class seat quota manager. Tracks total authorized capacity, seats filled, reserved quotas (RTE, Staff, Sports, Management), and remaining vacancies per section.
- **Backend APIs Called:**
  - `GET /api/ScholarVacancy/seats`
  - `PUT /api/ScholarVacancy/quotas`

---

### Module 4: Student Information, Profiles & Academics

#### 31. `DashboardScreen` (Student Portal)
- **File:** `campus_connect_app/lib/dashboard_screen.dart`
- **Target Roles:** Student
- **Function & What It Does:** Central student portal displaying attendance percentage meter, today's schedule, pending homework assignments, upcoming exams, fee due warnings, and quick link to virtual ID card.
- **Backend APIs Called:**
  - `GET /api/StudentProfile/my-profile`
  - `GET /api/AttendanceEngine/my-summary`
  - `GET /api/Timetable/my-schedule`
  - `GET /api/Homework/pending`
  - `GET /api/Fees/my-dues`

#### 32. `AdminStudentsScreen` & `StudentDetailScreen`
- **Files:** `campus_connect_app/lib/admin_students_screen.dart`, `campus_connect_app/lib/student_detail_screen.dart`
- **Target Roles:** Admin, Principal, Class Teacher
- **Function & What It Does:** Comprehensive Student Information System (SIS) directory with advanced filters. Detailed profile views for Academic Records, Parent Contacts, Attendance History, Fee Ledger, and Behavioral Logs.
- **Backend APIs Called:**
  - `GET /api/StudentRegister/students?page=1&classId={classId}`
  - `GET /api/StudentProfile/{id}/full-details`
  - `PUT /api/StudentProfile/{id}`
  - `DELETE /api/StudentProfile/{id}`

#### 33. `StudentProgressTrackerScreen` & `StudentAnalyticsPortalScreen`
- **Files:** `campus_connect_app/lib/screens/student_progress_tracker_screen.dart`, `campus_connect_app/lib/screens/student_analytics_portal_screen.dart`
- **Target Roles:** Student, Parent, Counselor, Academic Coordinator
- **Function & What It Does:** Academic performance analytics dashboard. Displays radar charts of subject competencies, term-over-term GPA trends, attendance correlation graphs, and predictive learning alerts.
- **Backend APIs Called:**
  - `GET /api/Analytics/student/{id}/academic-trajectory`
  - `GET /api/Analytics/student/{id}/competencies`

#### 34. `StudentIdentityCardScreen`
- **File:** `campus_connect_app/lib/screens/student_identity_card_screen.dart`
- **Target Roles:** Student, Parent, Admin
- **Function & What It Does:** Digital and printable student ID card generator. Features student photo, blood group, emergency contact details, barcode/QR code, and dynamic anti-spoofing security hologram.
- **Backend APIs Called:**
  - `GET /api/IdCard/student/{id}`
  - `GET /api/IdCard/batch-print?classId={classId}`

#### 35. `DigitalLockerScreen` & `DocumentVaultScreen`
- **Files:** `campus_connect_app/lib/screens/digital_locker_screen.dart`, `campus_connect_app/lib/screens/document_vault_screen.dart`
- **Target Roles:** Student, Parent, Admin
- **Function & What It Does:** Secure digital document vault. Stores verified copies of Birth Certificates, Aadhaar/ID cards, Previous School Marksheets, Immunization records, and Transfer Certificates.
- **Backend APIs Called:**
  - `GET /api/DigitalLocker/documents`
  - `POST /api/DigitalLocker/upload`
  - `DELETE /api/DigitalLocker/documents/{id}`

#### 36. `StudentDisciplineScreen` & `DisciplinaryManagementScreen`
- **Files:** `campus_connect_app/lib/screens/student_discipline_screen.dart`, `campus_connect_app/lib/screens/disciplinary_management_screen.dart`
- **Target Roles:** Disciplinary Committee, Class Teacher, Principal
- **Function & What It Does:** Disciplinary action and behavioral merit/demerit logger. Records behavioral incidents, logs parent notifications, tracks corrective counseling, and awards student merits.
- **Backend APIs Called:**
  - `GET /api/Compliance/discipline-records?studentId={id}`
  - `POST /api/Compliance/discipline-records`

#### 37. `StudentLifecycleTransitionConsoleScreen`
- **File:** `campus_connect_app/lib/screens/student_lifecycle/student_lifecycle_transition_console_screen.dart`
- **Target Roles:** Registrar, Principal, Admin
- **Function & What It Does:** Academic year-end promotion wizard. Manages mass grade promotions, section reshuffling, alumni status transitions, and automated Transfer Certificate (TC) generation.
- **Backend APIs Called:**
  - `POST /api/AcademicPromotion/preview-promotion`
  - `POST /api/AcademicPromotion/execute-promotion`
  - `POST /api/Certificate/issue-transfer-certificate`

#### 38. `StudentCbcsSelectionScreen` & `ElectiveSelectionScreen`
- **Files:** `campus_connect_app/lib/screens/higher_ed/student_cbcs_selection_screen.dart`, `campus_connect_app/lib/screens/elective_selection_screen.dart`
- **Target Roles:** HigherEd Students, Academic Dean
- **Function & What It Does:** Choice Based Credit System (CBCS) course registration desk. Validates course prerequisites, credit caps, faculty limits, and checks for timetable schedule clashes.
- **Backend APIs Called:**
  - `GET /api/HigherEdAcademic/cbcs/available-courses`
  - `POST /api/HigherEdAcademic/cbcs/enroll`
  - `GET /api/HigherEdAcademic/prerequisites/validate`

#### 39. `StudentDegreeAuditScreen` & `EnterpriseDegreeAuditScreen`
- **Files:** `campus_connect_app/lib/screens/student_degree_audit_screen.dart`, `campus_connect_app/lib/screens/enterprise_degree_audit_screen.dart`
- **Target Roles:** College Students, Academic Dean
- **Function & What It Does:** Degree completion and graduation audit engine. Verifies major/minor/core credit fulfillment, GPA benchmarks, and flags outstanding dues blocking graduation.
- **Backend APIs Called:**
  - `GET /api/HigherEdAcademic/degree-audit/{studentId}`

#### 40. `StudentPlacementScreen` & `AlumniPlacementScreen`
- **Files:** `campus_connect_app/lib/screens/student_placement_screen.dart`, `campus_connect_app/lib/screens/alumni_placement_screen.dart`
- **Target Roles:** Senior Students, Alumni, Placement Officer
- **Function & What It Does:** Campus placement drive console. Lists corporate recruitment postings, manages student resumes, tracks interview shortlist rounds, and logs job offers.
- **Backend APIs Called:**
  - `GET /api/Placement/drives`
  - `POST /api/Placement/apply`
  - `GET /api/Placement/my-applications`

#### 41. `AlumniPortalScreen` & `AdminAlumniHubScreen`
- **Files:** `campus_connect_app/lib/screens/alumni_portal_screen.dart`, `campus_connect_app/lib/screens/admin_alumni_hub_screen.dart`
- **Target Roles:** Alumni, Institutional Relations Officer
- **Function & What It Does:** Alumni network directory and engagement portal. Manages alumni chapters, event reunions, mentorship requests, career networking, and endowment donation campaigns.
- **Backend APIs Called:**
  - `GET /api/Alumni/directory`
  - `POST /api/Alumni/mentorship-request`
  - `GET /api/Alumni/events`

---

### Module 5: Parent Portal & Family Engagement

#### 42. `ParentDashboardScreen`
- **File:** `campus_connect_app/lib/screens/parent/parent_dashboard_screen.dart`
- **Target Roles:** Parent, Guardian
- **Function & What It Does:** Multi-child overview portal. Allows parents with multiple enrolled children to switch between wards, view daily attendance statuses, track school bus live location, and review notices.
- **Backend APIs Called:**
  - `GET /api/Parent/children`
  - `GET /api/Parent/child-summary/{studentId}`

#### 43. `ParentAttendanceScreen`
- **File:** `campus_connect_app/lib/screens/parent/parent_attendance_screen.dart`
- **Target Roles:** Parent
- **Function & What It Does:** Monthly attendance calendar for wards (Present, Absent, Tardy, Holiday). Allows submitting student leave applications with doctor notes directly to the class teacher.
- **Backend APIs Called:**
  - `GET /api/AttendanceEngine/student/{id}/calendar?month={m}&year={y}`
  - `POST /api/Leave/student-leave-request`

#### 44. `ParentChildFeesScreen` & `StudentFeePaymentScreen`
- **Files:** `campus_connect_app/lib/screens/parent/parent_child_fees_screen.dart`, `campus_connect_app/lib/screens/student_fee_payment_screen.dart`
- **Target Roles:** Parent, Student
- **Function & What It Does:** Online fee payment portal. Displays itemized fee invoices (Tuition, Transport, Examination, Lab); integrates payment gateways (Razorpay, Stripe, UPI); generates instant signed PDF receipts.
- **Backend APIs Called:**
  - `GET /api/Fees/student/{id}/due-breakdown`
  - `POST /api/Fees/initiate-pg-order`
  - `POST /api/Fees/verify-payment`
  - `GET /api/Fees/receipt-pdf/{receiptId}`

#### 45. `ParentResultsScreen` & `ReportCardViewerScreen`
- **Files:** `campus_connect_app/lib/screens/parent/parent_results_screen.dart`, `campus_connect_app/lib/screens/parent/report_card_viewer_screen.dart`
- **Target Roles:** Parent, Student
- **Function & What It Does:** Term exam results and digital report card viewer. Displays marks breakdown across scholastic and co-scholastic subjects, class average comparisons, teacher remarks, and signed PDF report cards.
- **Backend APIs Called:**
  - `GET /api/AcademicReports/student/{id}/results`
  - `GET /api/ReportStudio/render-pdf/report-card/{studentId}`

#### 46. `ParentDiaryScreen` & `DiaryScreen`
- **Files:** `campus_connect_app/lib/screens/parent_diary_screen.dart`, `campus_connect_app/lib/screens/diary_screen.dart`
- **Target Roles:** Parent, Class Teacher
- **Function & What It Does:** Digital school diary. Teachers post daily homework assignments, project reminders, and behavioral notes; parents view entries and provide digital acknowledgement signatures.
- **Backend APIs Called:**
  - `GET /api/Diary/entries`
  - `POST /api/Diary/entries`
  - `POST /api/Diary/entries/{id}/acknowledge`

#### 47. `ParentTeacherChatScreen` & `PtmScreen`
- **Files:** `campus_connect_app/lib/screens/parent_teacher_chat_screen.dart`, `campus_connect_app/lib/screens/ptm_screen.dart`
- **Target Roles:** Parent, Class Teacher
- **Function & What It Does:** Parent-Teacher Meeting (PTM) booking and messaging desk. Allows parents to reserve 1-on-1 virtual or in-person discussion slots with subject teachers and message within scheduled hours.
- **Backend APIs Called:**
  - `GET /api/Ptm/slots`
  - `POST /api/Ptm/book-slot`
  - `GET /api/ParentTeacherMessage/history`
  - `POST /api/ParentTeacherMessage/send`

#### 48. `ParentVoiceConciergeScreen`
- **File:** `campus_connect_app/lib/screens/parent_voice_concierge_screen.dart`
- **Target Roles:** Parent
- **Function & What It Does:** Voice-enabled multilingual school concierge. Allows parents to ask verbal questions in regional languages (e.g. "What is today's homework?") and provides spoken and textual answers.
- **Backend APIs Called:**
  - `POST /api/CampusBot/voice-inquiry`

---

### Module 6: Teacher & Faculty Classroom Delivery

#### 49. `TeacherDashboardScreen`
- **File:** `campus_connect_app/lib/teacher_dashboard_screen.dart`
- **Target Roles:** Teacher, Professor
- **Function & What It Does:** Teacher daily command hub. Features today's teaching schedule by period, rapid 1-tap attendance launch, pending homework to grade, unread parent inquiries, and substitution duty alerts.
- **Backend APIs Called:**
  - `GET /api/TeacherDashboard/my-overview`
  - `GET /api/Timetable/teacher-today`
  - `GET /api/Homework/pending-evaluations`

#### 50. `TeacherStudentsScreen` & `StudentTeachersScreen`
- **Files:** `campus_connect_app/lib/teacher_students_screen.dart`, `campus_connect_app/lib/student_teachers_screen.dart`
- **Target Roles:** Teacher, Student
- **Function & What It Does:** Classroom roster and student directory. Displays student academic history, emergency parent contacts, medical alerts, and special educational requirements.
- **Backend APIs Called:**
  - `GET /api/Roster/my-class-students`
  - `GET /api/Roster/subject-teachers`

#### 51. `TeacherGradingScreen` & `MarksEntrySetupScreen`
- **Files:** `campus_connect_app/lib/teacher_grading_screen.dart`, `campus_connect_app/lib/marks_entry_setup_screen.dart`
- **Target Roles:** Teacher, Examination In-Charge
- **Function & What It Does:** Classroom gradebook spreadsheet. Allows batch marks entry across Theory, Practical, and Internal assessments with validation against maximum marks and automatic grade calculation.
- **Backend APIs Called:**
  - `GET /api/ExamCell/marks-grid?examId={id}&classId={c}&subjectId={s}`
  - `POST /api/ExamCell/save-marks-batch`
  - `POST /api/ExamCell/lock-marks`

#### 52. `TeacherRiskDashboardScreen`
- **File:** `campus_connect_app/lib/screens/teacher_risk_dashboard_screen.dart`
- **Target Roles:** Class Teacher, Principal
- **Function & What It Does:** Early warning student risk dashboard. Flags students experiencing sudden academic declines, chronic absenteeism, or behavioral issues to initiate early counseling interventions.
- **Backend APIs Called:**
  - `GET /api/Analytics/at-risk-students`

#### 53. `TeacherEvaluationScreen` & `TeacherReviewScreen`
- **Files:** `campus_connect_app/lib/screens/teacher_evaluation_screen.dart`, `campus_connect_app/lib/screens/teacher_review_screen.dart`
- **Target Roles:** Principal, Academic Dean, Student (Anonymous)
- **Function & What It Does:** Faculty performance evaluation and feedback portal. Captures student reviews and administrative observations across pedagogy, punctuality, and syllabus completion.
- **Backend APIs Called:**
  - `GET /api/Evaluation/faculty-reviews/{teacherId}`
  - `POST /api/Evaluation/submit-student-feedback`

---

### Module 7: Attendance, Biometrics & Geofencing

#### 54. `AttendanceHistoryScreen` & `StudentAttendanceReportScreen`
- **Files:** `campus_connect_app/lib/attendance_history_screen.dart`, `campus_connect_app/lib/screens/student_attendance_report_screen.dart`
- **Target Roles:** Admin, Class Teacher, Attendance In-Charge
- **Function & What It Does:** Historical attendance registers and compliance reporting. Tracks monthly student attendance percentages, flags students below the mandatory 75% threshold, and exports regulatory attendance sheets.
- **Backend APIs Called:**
  - `GET /api/StudentAttendanceReport/monthly`
  - `GET /api/StudentAttendanceReport/defaulters?threshold=75`

#### 55. `TeacherAttendanceSessionScreen`
- **File:** `campus_connect_app/lib/screens/teacher_attendance_session_screen.dart`
- **Target Roles:** Class Teacher, Subject Teacher
- **Function & What It Does:** Period-wise roll call attendance interface. Features quick `P` (Present), `A` (Absent), and `L` (Late) toggles with audible confirmation and instant automated WhatsApp/SMS alerts to absent students' parents.
- **Backend APIs Called:**
  - `GET /api/PeriodAttendance/roster?periodId={p}&date={d}`
  - `POST /api/PeriodAttendance/submit-session`

#### 56. `AttendanceCameraScreen` & `AttendanceFaceEnrollmentScreen`
- **Files:** `campus_connect_app/lib/screens/attendance_camera_screen.dart`, `campus_connect_app/lib/screens/attendance_face_enrollment_screen.dart`
- **Target Roles:** All Staff, Students, Biometric Administrator
- **Function & What It Does:** AI face recognition attendance and biometric enrollment portal. Captures 5 face angles during registration to generate 512D vector embeddings; matches face with 3D passive liveness verification (anti-spoofing).
- **Backend APIs Called:**
  - `POST /api/AttendanceEngine/enroll-face`
  - `POST /api/AttendanceEngine/visual-verify` (Multipart with GPS coordinates)

#### 57. `GroupAttendanceScreen`
- **File:** `campus_connect_app/lib/screens/group_attendance_screen.dart`
- **Target Roles:** Teacher, Exam Invigilator
- **Function & What It Does:** Multi-face classroom photo scanner. A single classroom group photo is analyzed by Python AI workers to detect and mark up to 50 students simultaneously in under 3 seconds.
- **Backend APIs Called:**
  - `POST /api/AttendanceAdvanced/group/check-in`

#### 58. `StaffSelfieScreen` & `StaffGeofenceAttendanceScreen`
- **Files:** `campus_connect_app/lib/screens/staff_selfie_screen.dart`, `campus_connect_app/lib/screens/staff_geofence_attendance_screen.dart`
- **Target Roles:** Staff, Teachers, Field Personnel
- **Function & What It Does:** Daily geofenced selfie punch in and punch out. Verifies employee presence inside the campus polygon using GPS coordinates, captures selfie punch, and tracks work hours.
- **Backend APIs Called:**
  - `POST /api/GeofenceAttendance/punch`
  - `GET /api/StaffAttendance/my-monthly-log`

#### 59. `AdminBiometricScreen` & `BiometricDeviceManagementScreen`
- **Files:** `campus_connect_app/lib/screens/admin_biometric_screen.dart`, `campus_connect_app/lib/screens/biometric_device_management_screen.dart`
- **Target Roles:** IT Administrator, Security Officer
- **Function & What It Does:** IoT biometric hardware controller (ZKTeco, eSSL, Matrix). Manages physical wall devices, user biometric sync, device heartbeats, and logs live device communication packets.
- **Backend APIs Called:**
  - `GET /api/Biometric/devices`
  - `POST /api/Biometric/sync-users`
  - `POST /api/IClock/cdata`

#### 60. `AttendanceBunkingAlertsScreen`
- **File:** `campus_connect_app/lib/screens/attendance_bunking_alerts_screen.dart`
- **Target Roles:** Discipline In-Charge, Principal
- **Function & What It Does:** Bunking and gate-discrepancy tracker. Detects instances where a student tapped into the school main gate but was marked absent during classroom periods; displays student photo and campus location.
- **Backend APIs Called:**
  - `GET /api/AttendanceBunking/active-alerts`
  - `POST /api/AttendanceBunking/resolve-alert`

#### 61. `OfflineSyncConflictCenterScreen`
- **File:** `campus_connect_app/lib/screens/attendance/offline_sync_conflict_center_screen.dart`
- **Target Roles:** System Administrator
- **Function & What It Does:** Offline punch reconciliation desk. Synchronizes attendance punches saved locally during network outages and resolves conflicts using vector clocks and server-authoritative timestamps.
- **Backend APIs Called:**
  - `GET /api/AttendanceOperations/offline-queue`
  - `POST /api/AttendanceOperations/reconcile-conflicts`

#### 62. `QrAttendanceStudentScreen` & `QrAttendanceTeacherScreen`
- **Files:** `campus_connect_app/lib/screens/qr_attendance_student_screen.dart`, `campus_connect_app/lib/screens/qr_attendance_teacher_screen.dart`
- **Target Roles:** Students, Teachers, Gate Operators
- **Function & What It Does:** Dynamic QR attendance scanner. Teachers display an encrypted, rolling dynamic QR code on the smartboard; students scan the code using their mobile device to record attendance.
- **Backend APIs Called:**
  - `POST /api/PeriodAttendance/generate-dynamic-qr`
  - `POST /api/PeriodAttendance/scan-dynamic-qr`

---

### Module 8: Timetable, Scheduling & Teacher Substitution

#### 63. `TimetableScreen` & `TimetableGridScreen`
- **Files:** `campus_connect_app/lib/timetable_screen.dart`, `campus_connect_app/lib/screens/timetable_grid_screen.dart`
- **Target Roles:** Student, Teacher, Principal
- **Function & What It Does:** Interactive weekly timetable grid. Displays scheduled periods (Monday–Saturday), highlights active period with countdown minutes, and allows toggling between Class and Teacher views.
- **Backend APIs Called:**
  - `GET /api/Timetable/class/{classId}`
  - `GET /api/Timetable/teacher/{teacherId}`

#### 64. `TimetableSetupScreen` & `AdminTimetableGeneratorScreen`
- **Files:** `campus_connect_app/lib/screens/timetable_setup_screen.dart`, `campus_connect_app/lib/screens/admin_timetable_generator_screen.dart`
- **Target Roles:** Academic Coordinator, Timetable In-Charge
- **Function & What It Does:** Automated AI timetable scheduler. Evaluates constraints (teacher maximum weekly workload, room capacities, consecutive lecture limits) and generates conflict-free schedules in seconds.
- **Backend APIs Called:**
  - `POST /api/TimetableGenerator/generate`
  - `POST /api/TimetableSetup/publish`

#### 65. `SubstitutionBoardScreen` & `TeacherSubstitutionScreen`
- **Files:** `campus_connect_app/lib/screens/substitution_board_screen.dart`, `campus_connect_app/lib/screens/higher_ed/teacher_substitution_screen.dart`
- **Target Roles:** Academic Coordinator, Teachers
- **Function & What It Does:** Automated teacher substitution dispatcher. When a faculty member takes leave, the system identifies available teachers with matching subject specializations, assigns duty, and alerts them via WhatsApp.
- **Backend APIs Called:**
  - `GET /api/Substitution/today-absences`
  - `GET /api/Substitution/available-substitutes?periodId={p}`
  - `POST /api/Substitution/assign-duty`

---

### Module 9: LMS, E-Learning, Online Exams & Homework

#### 66. `AssignmentsScreen` & `StudentAssignmentSubmissionScreen`
- **Files:** `campus_connect_app/lib/assignments_screen.dart`, `campus_connect_app/lib/screens/higher_ed/student_assignment_submission_screen.dart`
- **Target Roles:** Student, Teacher
- **Function & What It Does:** Homework management and assignment turn-in portal. Teachers create assignments with PDF attachments; students submit completed work; includes rubric-based grading and AI plagiarism scoring.
- **Backend APIs Called:**
  - `GET /api/Homework/by-class`
  - `POST /api/Homework/create`
  - `POST /api/Homework/{id}/submit`
  - `GET /api/Homework/{id}/plagiarism-score`

#### 67. `CoursePlayerScreen` & `StudentLmsPortalScreen`
- **Files:** `campus_connect_app/lib/screens/course_player_screen.dart`, `campus_connect_app/lib/screens/student_lms_portal_screen.dart`
- **Target Roles:** Student, Teacher
- **Function & What It Does:** Digital courseware viewer. Features HLS video streaming, syllabus chapter navigation, downloadable PDF resources, and automatic completion progress tracking.
- **Backend APIs Called:**
  - `GET /api/Lms/courses`
  - `GET /api/Lms/courses/{id}/chapters`
  - `POST /api/Lms/courses/{id}/track-progress`

#### 68. `QuizScreen` & `OnlineExamScreen`
- **Files:** `campus_connect_app/lib/quiz_screen.dart`, `campus_connect_app/lib/screens/online_exam_screen.dart`
- **Target Roles:** Student, Exam Invigilator
- **Function & What It Does:** Proctored online examination room. Supports Multiple Choice, Short Answer, and Numerical questions with timer countdowns, question shuffling, tab-switch prevention, and webcam anti-cheating proctoring.
- **Backend APIs Called:**
  - `GET /api/OnlineExam/{id}/start`
  - `POST /api/OnlineExam/{id}/submit-answer`
  - `POST /api/OnlineExam/{id}/finish`

#### 69. `AdminAiExamBuilderScreen` & `QuestionBankScreen`
- **Files:** `campus_connect_app/lib/screens/admin_ai_exam_builder_screen.dart`, `campus_connect_app/lib/screens/question_bank_screen.dart`
- **Target Roles:** Teacher, Examination In-Charge
- **Function & What It Does:** AI Question Generator & Blooms Taxonomy Question Bank. Generates question sets from uploaded chapter PDFs across difficulty tiers and formats printable exam papers with answer keys.
- **Backend APIs Called:**
  - `POST /api/ExamCell/ai-generate-questions`
  - `GET /api/ExamCell/question-bank`
  - `POST /api/ExamCell/compile-question-paper`

#### 70. `OnlineClassScreen`
- **File:** `campus_connect_app/lib/screens/online_class_screen.dart`
- **Target Roles:** Student, Teacher
- **Function & What It Does:** Virtual classroom launcher (Zoom / Google Meet / Jitsi). Launches authenticated live lectures and automatically logs student attendance based on join duration.
- **Backend APIs Called:**
  - `GET /api/OnlineClass/scheduled`
  - `POST /api/OnlineClass/launch`
  - `POST /api/OnlineClass/log-attendance`

---

### Module 10: Examinations, CCE Grading, Report Cards & HPC

#### 71. `ExamScheduleScreen` & `ExamManagementScreen`
- **Files:** `campus_connect_app/lib/exam_schedule_screen.dart`, `campus_connect_app/lib/screens/exam_management_screen.dart`
- **Target Roles:** Exam Controller, Teacher, Student
- **Function & What It Does:** Examination hall ticket and date sheet publisher. Schedules exam dates, allocates examination rooms and invigilators, and generates student hall tickets with barcodes.
- **Backend APIs Called:**
  - `GET /api/ExamCell/schedules`
  - `POST /api/ExamCell/schedules`
  - `GET /api/ExamCell/hall-tickets`

#### 72. `AdminCceRulesScreen`
- **File:** `campus_connect_app/lib/screens/admin_cce_rules_screen.dart`
- **Target Roles:** Exam Controller, Academic Dean
- **Function & What It Does:** Continuous and Comprehensive Evaluation (CCE) grading rule engine. Sets letter grade bands (A1, A2, B1, etc.), pass marks, formative/summative weightage formulas, and grace mark policies.
- **Backend APIs Called:**
  - `GET /api/MasterSetup/cce-rules`
  - `PUT /api/MasterSetup/cce-rules`

#### 73. `HpcMarkingScreen` & `HpcSelfAssessmentScreen`
- **Files:** `campus_connect_app/lib/screens/hpc_marking_screen.dart`, `campus_connect_app/lib/screens/hpc_self_assessment_screen.dart`
- **Target Roles:** Class Teacher, Student, Parent
- **Function & What It Does:** Holistic Progress Card (HPC - NEP 2020 360-Degree Evaluation). Captures student self-assessments, peer ratings, parent observations, and teacher evaluations across cognitive, socio-emotional, and psychomotor skills.
- **Backend APIs Called:**
  - `GET /api/Hpc/student/{id}`
  - `POST /api/Hpc/submit-marking`

#### 74. `ExamModerationRevaluationCenterScreen`
- **File:** `campus_connect_app/lib/screens/exams/exam_moderation_revaluation_center_screen.dart`
- **Target Roles:** Chief Examiner, University Registrar
- **Function & What It Does:** Answer script revaluation and score moderation portal. Manages student rechecking applications, assigns blind second evaluators, resolves mark variances, and publishes revised marksheets.
- **Backend APIs Called:**
  - `GET /api/ExamCell/revaluations`
  - `POST /api/ExamCell/revaluations/submit-moderation`

---

### Module 11: Finance, Fee Collection, Vouchers & Accounting

#### 75. `AdminFeeDashboardScreen` & `FeeAnalyticsScreen`
- **Files:** `campus_connect_app/lib/admin_fee_dashboard_screen.dart`, `campus_connect_app/lib/screens/fee_analytics_screen.dart`
- **Target Roles:** Bursar, Finance Manager, Principal
- **Function & What It Does:** Financial revenue dashboard. Visualizes collected vs target tuition fees, overdue fee aging breakdowns, payment gateway settlement rates, and concession distribution.
- **Backend APIs Called:**
  - `GET /api/Fees/dashboard-metrics`
  - `GET /api/AdvancedFees/analytics`

#### 76. `AdminFeeSetupScreen`
- **File:** `campus_connect_app/lib/admin_fee_setup_screen.dart`
- **Target Roles:** Finance Director, Accountant
- **Function & What It Does:** Fee structure and fee head configurator. Creates custom fee heads (Tuition, Lab, Transport, Sports, Admission), binds fees by grade/stream, defines installment dates, and sets late fine policies.
- **Backend APIs Called:**
  - `GET /api/Fees/structures`
  - `POST /api/Fees/structures`
  - `POST /api/Fees/fee-heads`

#### 77. `AdminOfflinePaymentScreen` & `StudentLedgerScreen`
- **Files:** `campus_connect_app/lib/admin_offline_payment_screen.dart`, `campus_connect_app/lib/screens/student_ledger_screen.dart`
- **Target Roles:** School Cashier, Accounts Clerk
- **Function & What It Does:** Over-the-counter fee billing desk. Collects cash, physical checks, and DD payments; reconciles partial fee balances; generates signed thermal/A4 paper fee receipts.
- **Backend APIs Called:**
  - `GET /api/AdvancedFees/students/{id}/ledger`
  - `POST /api/Fees/offline-payment`

#### 78. `FeeDefaulterScreen`
- **File:** `campus_connect_app/lib/screens/fee_defaulter_screen.dart`
- **Target Roles:** Bursar, Accounts Officer
- **Function & What It Does:** Overdue fee recovery tracker. Filters defaulters by aging category (>30, >60, >90 days) and dispatches automated WhatsApp/SMS demand notices with integrated online payment links.
- **Backend APIs Called:**
  - `GET /api/AdvancedFees/defaulters`
  - `POST /api/FeeReminder/broadcast-whatsapp`

#### 79. `FeeConcessionMakerScreen` & `FeeConcessionCheckerScreen`
- **Files:** `campus_connect_app/lib/screens/fee_concession_maker_screen.dart`, `campus_connect_app/lib/screens/fee_concession_checker_screen.dart`
- **Target Roles:** Maker (Accountant), Checker (Principal/Trustee)
- **Function & What It Does:** Dual-authorization fee concession workflow. Implements financial Maker-Checker controls where accountants draft sibling/merit/EWS concessions and trustees review and approve them.
- **Backend APIs Called:**
  - `POST /api/AdvancedFees/concessions/maker`
  - `GET /api/AdvancedFees/concessions/pending`
  - `POST /api/AdvancedFees/concessions/checker-decision`

#### 80. `ChartOfAccountsScreen` & `ConsolidatedAccountingScreen`
- **Files:** `campus_connect_app/lib/screens/chart_of_accounts_screen.dart`, `campus_connect_app/lib/screens/consolidated_accounting_screen.dart`
- **Target Roles:** Chief Financial Officer (CFO), Senior Accountant
- **Function & What It Does:** Double-entry General Ledger tree. Organizes Assets, Liabilities, Equity, Revenue, and Expenses; generates real-time Trial Balance, Profit & Loss, and Balance Sheet statements.
- **Backend APIs Called:**
  - `GET /api/Accounting/chart-of-accounts`
  - `GET /api/Accounting/trial-balance`
  - `GET /api/Accounting/balance-sheet`

#### 81. `VoucherEntryScreen` & `DaybookReportScreen`
- **Files:** `campus_connect_app/lib/screens/voucher_entry_screen.dart`, `campus_connect_app/lib/screens/daybook_report_screen.dart`
- **Target Roles:** Accountant, Internal Auditor
- **Function & What It Does:** Voucher creation and daily financial daybook. Creates Journal, Payment, Receipt, and Contra vouchers with invoice image attachments; provides chronological daily cash registers.
- **Backend APIs Called:**
  - `POST /api/Accounting/vouchers`
  - `GET /api/Accounting/daybook?date={date}`

#### 82. `AdminBankReconciliationScreen` & `PaymentReconciliationCenterScreen`
- **Files:** `campus_connect_app/lib/screens/admin_bank_reconciliation_screen.dart`, `campus_connect_app/lib/screens/finance/payment_reconciliation_center_screen.dart`
- **Target Roles:** Financial Controller
- **Function & What It Does:** Automated bank reconciliation. Ingests bank OFX/CSV statements, automatically matches deposits against issued fee receipts, and flags unreconciled entries.
- **Backend APIs Called:**
  - `POST /api/BankReconciliation/upload-statement`
  - `GET /api/BankReconciliation/unreconciled`
  - `POST /api/BankReconciliation/match`

#### 83. `RefundApprovalCenterScreen` & `FiscalPeriodLockScreen`
- **Files:** `campus_connect_app/lib/screens/finance/refund_approval_center_screen.dart`, `campus_connect_app/lib/screens/finance/fiscal_period_lock_screen.dart`
- **Target Roles:** CFO, Trustee
- **Function & What It Does:** Caution deposit refunds and financial period lock. Audits caution money dues, calculates lab/library deductions, approves online refunds, and cryptographically locks past financial periods.
- **Backend APIs Called:**
  - `GET /api/Accounting/refunds/pending`
  - `POST /api/Accounting/refunds/approve`
  - `POST /api/Accounting/fiscal-periods/lock`

---

### Module 12: Human Resources, Payroll & ATS Recruitment

#### 84. `HrDashboardScreen` & `HrStaffProfileScreen`
- **Files:** `campus_connect_app/lib/screens/hr_dashboard_screen.dart`, `campus_connect_app/lib/screens/hr_staff_profile_screen.dart`
- **Target Roles:** HR Manager, Principal
- **Function & What It Does:** Personnel directory and HR master data manager. Maintains full staff profiles (teaching and non-teaching), contracts, educational degrees, bank info, and statutory PF/ESI IDs.
- **Backend APIs Called:**
  - `GET /api/HrProfile/staff-profiles`
  - `POST /api/HrProfile/staff-profiles`
  - `GET /api/HrProfile/staff-profiles/{id}`

#### 85. `HrStaffSelfServiceScreen` & `LeaveManagementScreen`
- **Files:** `campus_connect_app/lib/screens/hr_staff_self_service_screen.dart`, `campus_connect_app/lib/screens/leave_management_screen.dart`
- **Target Roles:** All Employees
- **Function & What It Does:** Employee Self-Service (ESS) portal. Employees track leave balances (Casual, Sick, Earned, Maternity), submit leave requests with attachments, and download monthly salary slips.
- **Backend APIs Called:**
  - `GET /api/LeaveManagement/balances`
  - `POST /api/LeaveManagement/applications`
  - `GET /api/Payroll/my-payslips`

#### 86. `StaffAppraisalScreen` & `ManagerAppraisalReviewScreen`
- **Files:** `campus_connect_app/lib/screens/staff_appraisal_screen.dart`, `campus_connect_app/lib/screens/manager_appraisal_review_screen.dart`
- **Target Roles:** Employee, HOD / Reporting Manager
- **Function & What It Does:** Annual staff appraisal system. Captures employee self-evaluations, KPI milestones, manager scorecards, promotion recommendations, and professional growth plans.
- **Backend APIs Called:**
  - `POST /api/HrAppraisal/self-assessment`
  - `GET /api/HrAppraisal/manager-reviews`
  - `POST /api/HrAppraisal/manager-decision`

#### 87. `PayrollDashboardScreen` & `PayrollProcessingScreen`
- **Files:** `campus_connect_app/lib/screens/payroll_dashboard_screen.dart`, `campus_connect_app/lib/screens/payroll_processing_screen.dart`
- **Target Roles:** Payroll Officer, Finance Head
- **Function & What It Does:** Monthly payroll calculation and disbursement engine. Computes basic pay, allowances, attendance-linked Loss of Pay (LOP) deductions, TDS, and PF/ESI contributions; generates bank disbursement files.
- **Backend APIs Called:**
  - `GET /api/Payroll/dashboard`
  - `POST /api/Payroll/calculate-month`
  - `POST /api/Payroll/disburse`
  - `GET /api/Payroll/export-bank-txt`

#### 88. `PayrollAiAuditScreen`
- **File:** `campus_connect_app/lib/screens/payroll_ai_audit_screen.dart`
- **Target Roles:** Internal Auditor, CFO
- **Function & What It Does:** AI payroll audit console. Automatically flags ghost workers, unverified bank account changes, duplicate payout entries, and tax irregularities prior to salary disbursement.
- **Backend APIs Called:**
  - `GET /api/Payroll/ai-audit/anomalies`
  - `POST /api/Payroll/ai-audit/override`

#### 89. `AtsRecruitmentScreen`
- **File:** `campus_connect_app/lib/screens/ats_recruitment_screen.dart`
- **Target Roles:** HR Head, Talent Acquisition
- **Function & What It Does:** Full Applicant Tracking System (ATS). 5-tab suite: Job Postings manager, Applications with AI match scores, 5-stage candidate Kanban board, Interview scheduler with AI Mock Interview tool, and Offer Letter generation.
- **Backend APIs Called:**
  - `GET /api/Ats/jobs`
  - `GET /api/Ats/applications`
  - `PUT /api/Ats/applications/{id}/stage`
  - `POST /api/Ats/offers`

#### 90. `StaffExpenseClaimScreen`
- **File:** `campus_connect_app/lib/screens/higher_ed/staff_expense_claim_screen.dart`
- **Target Roles:** Faculty, Department Heads
- **Function & What It Does:** Staff expense reimbursement portal. Captures multi-item expense vouchers with receipt photo uploads, validates travel allowance policies, and routes claims through manager approvals.
- **Backend APIs Called:**
  - `GET /api/ExpenseClaim/my-claims`
  - `POST /api/ExpenseClaim/submit`
  - `POST /api/ExpenseClaim/approve`

---

### Module 13: Communication, WhatsApp, AI Bot & Notices

#### 91. `AdminNoticeBoardScreen` & `NoticeBoardScreen`
- **Files:** `campus_connect_app/lib/screens/admin_notice_board_screen.dart`, `campus_connect_app/lib/screens/notice_board_screen.dart`
- **Target Roles:** Admin, Principal, All School Users
- **Function & What It Does:** Omnichannel school circular broadcaster. Features rich text editor, attachment uploads, audience targeting (Classes, Staff, Parents), and multi-channel delivery toggles (In-App, Push, WhatsApp, SMS).
- **Backend APIs Called:**
  - `GET /api/Notice/feed`
  - `POST /api/Notice/publish`
  - `DELETE /api/Notice/{id}`

#### 92. `WhatsAppCampaignScreen`
- **File:** `campus_connect_app/lib/screens/whatsapp_campaign_screen.dart`
- **Target Roles:** Admin, Admissions Director, Accounts Officer
- **Function & What It Does:** Official Meta WhatsApp Business bulk broadcast console. Features pre-approved template picker with dynamic variable substitution (`{student_name}`, `{fee_due}`), metered wallet balance display, and delivery analytics.
- **Backend APIs Called:**
  - `GET /api/WhatsAppCampaign/templates`
  - `POST /api/WhatsAppCampaign/send-broadcast`
  - `GET /api/WhatsAppCampaign/delivery-analytics`
  - `GET /api/WhatsAppCampaign/wallet-balance`

#### 93. `CampusBotScreen`
- **File:** `campus_connect_app/lib/screens/campus_bot_screen.dart`
- **Target Roles:** All Users, Parents, Students
- **Function & What It Does:** Multilingual AI assistant supporting 9 Indian regional languages. Features 3-dot typing indicators, suggested prompt chips, and a collapsible RAG context and intent debugger panel.
- **Backend APIs Called:**
  - `POST /api/CampusBot/chat`
  - `GET /api/CampusBot/history`

#### 94. `ChatScreen`
- **File:** `campus_connect_app/lib/chat_screen.dart`
- **Target Roles:** Teachers, Staff, Students, Admins
- **Function & What It Does:** Real-time instant messaging suite. Supports 1-on-1 and departmental chat channels with typing indicators, online presence status, file attachments, and read receipts via SignalR.
- **Backend APIs Called:**
  - `GET /api/Chat/conversations`
  - `GET /api/Chat/messages/{conversationId}`
  - SignalR: `SendMessage`, `UserTyping`

#### 95. `HelpdeskListScreen` & `HelpdeskTicketScreen`
- **Files:** `campus_connect_app/lib/screens/helpdesk_list_screen.dart`, `campus_connect_app/lib/screens/helpdesk_ticket_screen.dart`
- **Target Roles:** Students, Parents, Staff, Helpdesk Agents
- **Function & What It Does:** Institutional helpdesk and ticketing portal. Manages inquiries across Transport, Fees, Academics, Hostel, and IT with SLA priority timers, status workflows, and resolution ratings.
- **Backend APIs Called:**
  - `GET /api/Helpdesk/tickets`
  - `POST /api/Helpdesk/tickets`
  - `POST /api/Helpdesk/tickets/{id}/reply`
  - `PUT /api/Helpdesk/tickets/{id}/status`

#### 96. `KnowledgeBaseScreen`
- **File:** `campus_connect_app/lib/screens/knowledge_base_screen.dart`
- **Target Roles:** All Users
- **Function & What It Does:** Searchable FAQ and campus policies knowledge base. Articles categorized by topic with full-text fuzzy search and user helpfulness feedback voting.
- **Backend APIs Called:**
  - `GET /api/KnowledgeBase/categories`
  - `GET /api/KnowledgeBase/articles?q={query}`

---

### Module 14: Library Management & Inter-Library Loan (ILL)

#### 97. `AdminLibraryScreen`
- **File:** `campus_connect_app/lib/screens/admin_library_screen.dart`
- **Target Roles:** Head Librarian, Library Assistants
- **Function & What It Does:** Comprehensive 4-tab library console:
  1. **Book Catalog:** Barcode & ISBN inventory management.
  2. **Issue/Return Desk:** Rapid barcode scanning for student IDs and book accession codes.
  3. **Overdue Reports:** Automatic late fee calculation (₹10/day default).
  4. **Reading Room:** 40-seat interactive live seat occupancy floor map.
- **Backend APIs Called:**
  - `GET /api/Library/catalog`
  - `POST /api/Library/issues`
  - `POST /api/Library/returns`
  - `GET /api/Library/overdue-reports`
  - `GET /api/Library/reading-room/occupancy`

#### 98. `LibraryCatalogScreen` & `LibraryCheckoutScreen`
- **Files:** `campus_connect_app/lib/screens/library_catalog_screen.dart`, `campus_connect_app/lib/screens/library_checkout_screen.dart`
- **Target Roles:** Students, Faculty, Librarian
- **Function & What It Does:** OPAC (Online Public Access Catalog) & Digital Reserve Desk. Allows searching books by title or Dewey Decimal classification, reserving copies, and borrowing eBooks for 72-hour offline reading.
- **Backend APIs Called:**
  - `GET /api/Library/catalog?q={query}`
  - `POST /api/Library/reservations`
  - `POST /api/Library/digital-loans`

#### 99. `LibraryIllScreen`
- **File:** `campus_connect_app/lib/screens/higher_ed/library_ill_screen.dart`
- **Target Roles:** Librarian, University Researchers
- **Function & What It Does:** Inter-Library Loan (ILL) consortium tracker. Manages book borrowing across partnered university libraries with courier AWB tracking and return timelines.
- **Backend APIs Called:**
  - `GET /api/Library/ill/consortium-catalog`
  - `POST /api/Library/ill/request-loan`
  - `PUT /api/Library/ill/{id}/awb-status`

---

### Module 15: Hostel, Mess & Residential Life

#### 100. `AdminHostelManagementScreen`
- **File:** `campus_connect_app/lib/screens/admin_hostel_management_screen.dart`
- **Target Roles:** Chief Warden, Hostel Superintendent
- **Function & What It Does:** 5-tab residential hostel console:
  1. **Rooms Grid:** Visual room cards grouped by Block and Floor showing occupancy ratios.
  2. **Allocations:** Bed assignment table with student search.
  3. **Outpass Pipeline:** Gate pass approval queue with biometric / OTP verification modal.
  4. **Mess Menu:** Weekly meal matrix editor (Breakfast, Lunch, Snacks, Dinner).
  5. **Room Transfer:** Bed swap workflow.
- **Backend APIs Called:**
  - `GET /api/Hostel/blocks`
  - `GET /api/Hostel/rooms/with-occupancy`
  - `POST /api/Hostel/allocations`
  - `GET /api/Hostel/outpasses/pending`
  - `POST /api/Hostel/outpasses/authorize`
  - `PUT /api/Hostel/mess-menu`

#### 101. `StudentOutpassScreen` & `WardenOutpassDashboard`
- **Files:** `campus_connect_app/lib/screens/higher_ed/student_outpass_screen.dart`, `campus_connect_app/lib/screens/higher_ed/warden_outpass_dashboard.dart`
- **Target Roles:** Boarding Student, Hostel Warden, Security Guard
- **Function & What It Does:** Student gate outpass generator. Students submit outpass requests; parents receive notification for consent; wardens approve; security guards scan the generated dynamic QR code at the campus gate.
- **Backend APIs Called:**
  - `POST /api/Hostel/outpasses/request`
  - `GET /api/Hostel/outpasses/my-history`
  - `POST /api/GatePassAttendance/verify-qr`

#### 102. `LaundryScreen`
- **File:** `campus_connect_app/lib/screens/laundry_screen.dart`
- **Target Roles:** Boarding Student, Laundry Staff
- **Function & What It Does:** Hostel laundry management desk. Logs garment counts, generates bag barcode tags, tracks wash/ironing stages, and alerts students when clean laundry is ready for pickup.
- **Backend APIs Called:**
  - `GET /api/Laundry/orders`
  - `POST /api/Laundry/orders`
  - `PUT /api/Laundry/orders/{id}/status`

---

### Module 16: Transport, Fleet, GPS & Route Optimization

#### 103. `BusTrackingScreen` & `AdminLiveTrackingMapScreen`
- **Files:** `campus_connect_app/lib/bus_tracking_screen.dart`, `campus_connect_app/lib/screens/admin_live_tracking_map_screen.dart`
- **Target Roles:** Parent, Student, Transport Manager
- **Function & What It Does:** Live vehicle GPS tracking map. Displays moving bus markers in real-time with speed monitors, remaining distance to student stop, estimated arrival time (ETA), and direct driver call buttons.
- **Backend APIs Called:**
  - `GET /api/Tracking/vehicle-location/{busId}`
  - SignalR: `ReceiveGpsPing` (WebSocket streaming every 3-5 seconds)

#### 104. `BusFleetManagementScreen` & `GpsDeviceManagementScreen`
- **Files:** `campus_connect_app/lib/screens/bus_fleet_management_screen.dart`, `campus_connect_app/lib/screens/gps_device_management_screen.dart`
- **Target Roles:** Fleet In-Charge, Transport Coordinator
- **Function & What It Does:** Fleet vehicle and GPS hardware manager. Maintains buses and vans, insurance and fitness expiry dates, driver assignments, and binds OBD-II / AIS-140 GPS hardware units.
- **Backend APIs Called:**
  - `GET /api/Transport/fleet`
  - `POST /api/Transport/fleet`
  - `GET /api/Transport/gps-devices`
  - `POST /api/Transport/gps-devices/provision`

#### 105. `TransportAiOptimizerScreen` & `TransportPlaybackScreen`
- **Files:** `campus_connect_app/lib/screens/transport_ai_optimizer_screen.dart`, `campus_connect_app/lib/screens/transport_playback_screen.dart`
- **Target Roles:** Transport Manager
- **Function & What It Does:** Route optimization and trip replay engine. Optimizes pickup stop sequences to reduce fuel consumption; replays historical trips showing speed limit violations and route deviations.
- **Backend APIs Called:**
  - `POST /api/Transport/ai-optimizer/recalculate-routes`
  - `GET /api/Transport/playback?busId={id}&date={d}`

#### 106. `BusAttendanceScreen`
- **File:** `campus_connect_app/lib/screens/bus_attendance_screen.dart`
- **Target Roles:** Bus Conductor, Driver
- **Function & What It Does:** Bus boarding NFC/QR scanner. Conductors scan student RFID cards upon boarding and exiting; dispatches automated push notifications to parents.
- **Backend APIs Called:**
  - `POST /api/BusAttendance/tap-in`
  - `POST /api/BusAttendance/tap-out`

---

### Module 17: Canteen POS, Kitchen Display & RFID Wallets

#### 107. `AdminCanteenPosScreen` & `CanteenPosScreen`
- **Files:** `campus_connect_app/lib/screens/admin_canteen_pos_screen.dart`, `campus_connect_app/lib/screens/canteen_pos_screen.dart`
- **Target Roles:** Canteen Cashier, Cafeteria Manager
- **Function & What It Does:** High-speed cafeteria POS terminal. Features NFC/RFID student card scanning, fast-tap menu item buttons, validation of parent-set daily spend caps, and sales reporting.
- **Backend APIs Called:**
  - `GET /api/Canteen/menu-items`
  - `POST /api/Canteen/orders/charge-wallet`
  - `POST /api/Canteen/orders/charge-cash`
  - `GET /api/Canteen/daily-sales-report`
  - `PUT /api/Canteen/wallets/{id}/spend-cap`

#### 108. `CanteenWalletScreen` & `EnterpriseStudentWalletScreen`
- **Files:** `campus_connect_app/lib/screens/canteen_wallet_screen.dart`, `campus_connect_app/lib/screens/enterprise_student_wallet_screen.dart`
- **Target Roles:** Student, Parent
- **Function & What It Does:** Student cafeteria digital wallet. Displays available prepaid balance, itemized meal purchase logs, dietary restrictions (e.g. "No Peanuts"), and instant UPI recharge options.
- **Backend APIs Called:**
  - `GET /api/Canteen/wallets/my-balance`
  - `POST /api/Canteen/wallets/recharge`
  - `GET /api/Canteen/wallets/transactions`

#### 109. `CanteenKitchenScreen` & `CanteenPreorderScreen`
- **Files:** `campus_connect_app/lib/screens/canteen_kitchen_screen.dart`, `campus_connect_app/lib/screens/canteen_preorder_screen.dart`
- **Target Roles:** Kitchen Chef, Students
- **Function & What It Does:** Kitchen Order Ticket (KOT) display and meal pre-ordering. Chefs track order statuses (`Queued` ➔ `Cooking` ➔ `Ready`); students pre-book meals to skip lunchtime lines.
- **Backend APIs Called:**
  - `GET /api/Canteen/kitchen/live-tickets`
  - `PUT /api/Canteen/kitchen/tickets/{id}/status`
  - `POST /api/Canteen/preorders`

#### 110. `PosEndOfDaySettlementScreen`
- **File:** `campus_connect_app/lib/screens/canteen/pos_end_of_day_settlement_screen.dart`
- **Target Roles:** Canteen Manager, Accounts Auditor
- **Function & What It Does:** End-of-Day (EOD) POS register settlement. Reconciles physical cash in cash drawers against electronic POS sales, flags cash surpluses/shortages, and prints day-close audit slips.
- **Backend APIs Called:**
  - `POST /api/Canteen/settlement/close-day`

---

### Module 18: Inventory, Procurement & Fixed Assets

#### 111. `InventoryManagementScreen` & `ItemMasterScreen`
- **Files:** `campus_connect_app/lib/screens/inventory_management_screen.dart`, `campus_connect_app/lib/screens/item_master_screen.dart`
- **Target Roles:** Storekeeper, Inventory Manager
- **Function & What It Does:** Warehouse inventory and item master catalog. Manages categories (Stationery, Lab Chemicals, Uniforms, Electronics), SKU quantities, reorder thresholds, and bin locations.
- **Backend APIs Called:**
  - `GET /api/Inventory/categories`
  - `GET /api/Inventory/items`
  - `POST /api/Inventory/items`

#### 112. `PurchaseOrderScreen` & `StockReceiptScreen`
- **Files:** `campus_connect_app/lib/screens/purchase_order_screen.dart`, `campus_connect_app/lib/screens/stock_receipt_screen.dart`
- **Target Roles:** Procurement Officer, Storekeeper
- **Function & What It Does:** Procurement cycle and Goods Received Note (GRN) desk. Creates vendor purchase orders with tax breakdowns; verifies delivered shipments and logs items into warehouse stock.
- **Backend APIs Called:**
  - `GET /api/Inventory/purchase-orders`
  - `POST /api/Inventory/purchase-orders`
  - `POST /api/Inventory/stock-receipts`

#### 113. `InventoryStockPredictionScreen`
- **File:** `campus_connect_app/lib/screens/inventory_stock_prediction_screen.dart`
- **Target Roles:** Procurement Head, CFO
- **Function & What It Does:** AI stock depletion forecasting. Analyzes historical consumption rates to forecast exact dates when answer sheets or lab chemicals will run out and proposes 1-tap POs.
- **Backend APIs Called:**
  - `GET /api/Inventory/predictions/exhaustion-forecast`

#### 114. `AssetManagementScreen`
- **File:** `campus_connect_app/lib/screens/asset_management_screen.dart`
- **Target Roles:** Estate Manager, IT Admin
- **Function & What It Does:** Fixed asset tagging and depreciation manager. Tracks institution assets (Smartboards, Projectors, Microscopes, Buses, Desks) with barcode tags, maintenance logs, and annual depreciation.
- **Backend APIs Called:**
  - `GET /api/InventoryAsset/assets`
  - `POST /api/InventoryAsset/assets`
  - `POST /api/InventoryAsset/depreciation-run`

---

### Module 19: Certificates & Document Verification

#### 115. `CertificateScreen` & `CertificateTranscriptScreen`
- **Files:** `campus_connect_app/lib/certificate_screen.dart`, `campus_connect_app/lib/screens/certificate_transcript_screen.dart`
- **Target Roles:** Registrar, Principal, Admin
- **Function & What It Does:** Official certificate and transcript generator. Creates Transfer Certificates, Bonafide/Character Certificates, and Degree Transcripts with guilloche security borders and digital signatures.
- **Backend APIs Called:**
  - `GET /api/Certificate/templates`
  - `POST /api/Certificate/generate`
  - `GET /api/Certificate/issued-history`

#### 116. `VerifyCertificateScannerScreen` & `EnterpriseCertificateVerificationScreen`
- **Files:** `campus_connect_app/lib/screens/verify_certificate_scanner_screen.dart`, `campus_connect_app/lib/screens/enterprise_certificate_verification_screen.dart`
- **Target Roles:** Employers, University Admissions, Public Verifiers
- **Function & What It Does:** Public cryptographic certificate authenticator. Scans QR codes on printed certificates and validates the digital signature against the blockchain/server ledger to prove authenticity.
- **Backend APIs Called:**
  - `GET /api/PublicVerification/certificate?nonce={nonce}`

---

### Module 20: BI Analytics & Custom Report Studio

#### 117. `BiDashboardBuilderScreen`
- **File:** `campus_connect_app/lib/screens/bi_dashboard_builder_screen.dart`
- **Target Roles:** SuperAdmin, SchoolAdmin, Trust Board
- **Function & What It Does:** Drag-and-drop Business Intelligence (BI) dashboard builder. Offers 4 preset templates and 8 customizable widgets (Fee Collection, Attendance, Enrollment, Staff Attrition); receives live SignalR updates every 60s.
- **Backend APIs Called:**
  - `GET /api/BiAnalyticsDashboard/layouts`
  - `POST /api/BiAnalyticsDashboard/layouts`
  - SignalR: `BiDashboardHub`

#### 118. `ReportStudioScreen` & `ReportStudioEditorScreen`
- **Files:** `campus_connect_app/lib/screens/report_studio_screen.dart`, `campus_connect_app/lib/screens/report_studio_editor_screen.dart`
- **Target Roles:** Admin, Exam Controller, Academic Coordinator
- **Function & What It Does:** Visual report designer and vector PDF compiler. Allows drag-and-drop layout of Report Cards, Fee Receipts, Payslips, and Certificates with data bindings and custom school seals.
- **Backend APIs Called:**
  - `GET /api/ReportStudio/families`
  - `GET /api/ReportStudio/definitions`
  - `POST /api/ReportStudio/compile`
  - `POST /api/ReportStudio/render-pdf`

#### 119. `ScheduledBiReportsManagerScreen`
- **File:** `campus_connect_app/lib/screens/scheduled_bi_reports_manager_screen.dart`
- **Target Roles:** SuperAdmin, SchoolAdmin
- **Function & What It Does:** Automated report cron scheduler. Configures recurring daily, weekly, or monthly delivery of PDF/Excel reports (e.g. Monday Attendance Digest, Monthly Defaulters List) directly to trustee inboxes.
- **Backend APIs Called:**
  - `GET /api/ReportGeneration/schedules`
  - `POST /api/ReportGeneration/schedules`

#### 120. `AccreditationDashboardScreen`
- **File:** `campus_connect_app/lib/screens/accreditation_dashboard_screen.dart`
- **Target Roles:** Principal, Accreditation Coordinator (NAAC / NBA / CBSE)
- **Function & What It Does:** Accreditation evidence and quality compliance tracker. Organizes compliance criteria (Faculty-Student ratios, Research output, Infrastructure utilization) for institutional audits.
- **Backend APIs Called:**
  - `GET /api/Accreditation/criteria-scores`
  - `POST /api/Accreditation/upload-evidence`

---

### Module 21: Enterprise Security, Zero Trust & CAC

#### 121. `EnterpriseSecurityScreen`
- **File:** `campus_connect_app/lib/screens/enterprise_security_screen.dart`
- **Target Roles:** Chief Information Security Officer (CISO), SuperAdmin
- **Function & What It Does:** Enterprise security console with 4 main modules:
  1. **SSO Config:** SAML 2.0 / OIDC Identity Provider setup (Azure AD, Google Workspace, Okta) with JIT user provisioning.
  2. **Zero Trust CAC:** Conditional Access Control risk scoring with device fingerprinting and impossible travel detection (speed > 500 km/h).
  3. **DLP Rules:** Data Loss Prevention regex pattern tester for masking Aadhaar, PAN, and credit card numbers.
  4. **SIEM Stream:** Live cybersecurity event stream.
- **Backend APIs Called:**
  - `GET /api/EnterpriseSso/config`
  - `PUT /api/EnterpriseSso/config`
  - `GET /api/ZeroTrustSecurity/cac-policy`
  - `GET /api/DlpSecurity/patterns`
  - `GET /api/SecurityIncident/stream`

#### 122. `EnterpriseBreakGlassScreen`
- **File:** `campus_connect_app/lib/screens/enterprise_break_glass_screen.dart`
- **Target Roles:** Global SuperAdmin
- **Function & What It Does:** Emergency "Break-Glass" privileged access override. Grants temporary elevated emergency access to isolated school tenants during outages; requires dual-custody approval.
- **Backend APIs Called:**
  - `POST /api/EnterpriseHardening/break-glass/request`
  - `POST /api/EnterpriseHardening/break-glass/authorize`

#### 123. `SecuritySiemIncidentScreen` & `EffectiveAccessAnalyzerScreen`
- **Files:** `campus_connect_app/lib/screens/security/security_siem_incident_screen.dart`, `campus_connect_app/lib/screens/security/effective_access_analyzer_screen.dart`
- **Target Roles:** Security Operations Center (SOC) Analyst
- **Function & What It Does:** Security incident analyzer. Analyzes brute force login events, token leaks, and models the effective access blast radius of any compromised user account.
- **Backend APIs Called:**
  - `GET /api/SecurityIncident/incidents`
  - `GET /api/Permission/effective-access/{userId}`

---

### Module 22: SuperAdmin SaaS Multi-Tenant Platform

#### 124. `AdminSaasSuperadminScreen`
- **File:** `campus_connect_app/lib/screens/superadmin/admin_saas_superadmin_screen.dart`
- **Target Roles:** Platform SuperAdmin
- **Function & What It Does:** Master SaaS Platform Hub. 4 tabs:
  1. **Tenant Directory:** Search, onboard, suspend, or terminate client school institutions.
  2. **Metered Wallet & Rates:** Set per-unit billing rates (WhatsApp messages @ ₹0.75, SMS @ ₹0.20, AI face attendance @ ₹0.05).
  3. **White-Label APK Build Pipeline:** Live compile console and build log stream.
  4. **Tenant Backups:** Multi-tenant disaster recovery snapshot manager.
- **Backend APIs Called:**
  - `GET /api/superadmin/SaasSAdmin/schools`
  - `POST /api/superadmin/SaasSAdmin/schools`
  - `GET /api/superadmin/SaasSAdmin/metered-rates`
  - `POST /api/superadmin/SaasSAdmin/metered-rates`
  - `GET /api/superadmin/SaasSAdmin/apk-builds`

#### 125. `SuperAdminDashboardScreen` & `SuperAdminAnalyticsScreen`
- **Files:** `campus_connect_app/lib/screens/superadmin/super_admin_dashboard_screen.dart`, `campus_connect_app/lib/screens/super_admin_analytics_screen.dart`
- **Target Roles:** Platform SuperAdmin, SaaS Founder
- **Function & What It Does:** Multi-tenant SaaS KPI command center. Displays Monthly Recurring Revenue (MRR), active institution count, aggregate student volume (100,000+), server loads, and database connection pools.
- **Backend APIs Called:**
  - `GET /api/superadmin/SaasSAdmin/platform-kpis`
  - `GET /api/Observability/system-health`

#### 126. `TenantProvisioningWizardScreen`
- **File:** `campus_connect_app/lib/screens/superadmin/tenant_provisioning_wizard_screen.dart`
- **Target Roles:** Platform SuperAdmin
- **Function & What It Does:** Automated tenant database provisioning engine. Generates dedicated tenant schemas, seeds master data templates, provisions S3 storage buckets, and sets up tenant admin accounts.
- **Backend APIs Called:**
  - `POST /api/superadmin/SaasSAdmin/provision`

#### 127. `SuperAdminBillingConsoleScreen` & `SuperAdminPlanManagerScreen`
- **Files:** `campus_connect_app/lib/screens/superadmin/super_admin_billing_console_screen.dart`, `campus_connect_app/lib/screens/superadmin/super_admin_plan_manager_screen.dart`
- **Target Roles:** Platform SuperAdmin, SaaS Billing
- **Function & What It Does:** SaaS subscription plan and invoicing engine. Configures subscription tiers (Starter, Pro, Enterprise), per-student annual rates, tracks invoices, and manages overdue account suspensions.
- **Backend APIs Called:**
  - `GET /api/superadmin/SaasSAdmin/plans`
  - `POST /api/superadmin/SaasSAdmin/plans`
  - `GET /api/superadmin/SuperAdminBilling/invoices`

#### 128. `ImpersonationSessionCenterScreen`
- **File:** `campus_connect_app/lib/screens/superadmin/impersonation_session_center_screen.dart`
- **Target Roles:** SuperAdmin, L3 Support Engineer
- **Function & What It Does:** Secure tenant impersonation console. Issues short-lived scoped JWT impersonation tokens allowing support staff to troubleshoot school issues as a local admin without needing passwords.
- **Backend APIs Called:**
  - `POST /api/superadmin/SaasSAdmin/impersonate`

#### 129. `GlobalOperationsIncidentScreen`
- **File:** `campus_connect_app/lib/screens/superadmin/global_operations_incident_screen.dart`
- **Target Roles:** Site Reliability Engineer (SRE), SuperAdmin
- **Function & What It Does:** Platform incident dispatch center. Broadcasts emergency alerts across affected school tenants, manages database maintenance windows, and publishes public status page updates.
- **Backend APIs Called:**
  - `POST /api/superadmin/SaasSAdmin/incidents`
  - `POST /api/SuperAdminBroadcast/emergency-banner`

---

### Module 23: Campus Services, Health, Visitors & IoT

#### 130. `HealthInfirmaryScreen`
- **File:** `campus_connect_app/lib/screens/health_infirmary_screen.dart`
- **Target Roles:** School Doctor, Nurse, Admin
- **Function & What It Does:** Campus clinic and Electronic Health Record (EHR) system. Logs student clinic visits, symptoms, administered medications, records annual health checkups, and alerts parents of emergencies.
- **Backend APIs Called:**
  - `GET /api/HealthInfirmary/visits`
  - `POST /api/HealthInfirmary/visits`
  - `GET /api/HealthInfirmary/student/{id}/medical-history`

#### 131. `VisitorEntryScreen` & `VisitorBookScreen`
- **Files:** `campus_connect_app/lib/screens/visitor_entry_screen.dart`, `campus_connect_app/lib/screens/visitor_book_screen.dart`
- **Target Roles:** Gate Security Guard, Front Desk Receptionist
- **Function & What It Does:** Security gate visitor management system. Takes visitor photo via webcam, scans ID cards, logs purpose of visit, prints barcoded visitor passes, and records checkout timestamps.
- **Backend APIs Called:**
  - `GET /api/Visitor/active-visitors`
  - `POST /api/Visitor/check-in`
  - `POST /api/Visitor/{id}/check-out`

#### 132. `GalleryScreen` & `AdminGalleryScreen`
- **Files:** `campus_connect_app/lib/screens/gallery_screen.dart`, `campus_connect_app/lib/screens/admin_gallery_screen.dart`
- **Target Roles:** All Users, Media Coordinator
- **Function & What It Does:** Institution photo and event media gallery. Organizes high-resolution photo albums by event (Sports Day, Annual Function), applies client-side JPEG compression, and manages batch uploads.
- **Backend APIs Called:**
  - `GET /api/Gallery/albums`
  - `POST /api/Gallery/albums`
  - `POST /api/Gallery/albums/{id}/photos`

#### 133. `IotSmartClassroomScreen`
- **File:** `campus_connect_app/lib/screens/iot_smart_classroom_screen.dart`
- **Target Roles:** Estate Manager, Smart Campus Coordinator
- **Function & What It Does:** IoT classroom environment and energy manager. Reads classroom temperature and air quality sensors, and automatically powers down smartboards and ACs when attendance detects empty rooms.
- **Backend APIs Called:**
  - `GET /api/IotAttendance/classrooms/telemetry`
  - `POST /api/IotAttendance/devices/control`

---

## 📈 3. Architecture Metrics & Technology Stack

| Category | Details |
| :--- | :--- |
| **Frontend Framework** | Flutter 3.x (Dart 3.x) with Cross-Platform Web, Desktop & Mobile Builds |
| **Total Screen Modules** | **133 Comprehensive Operational Screens** |
| **State Management** | Provider Pattern (`MultiProvider`, `ChangeNotifierProvider`) |
| **Routing Architecture** | Hybrid `GoRouter` (URL deep links) + `Navigator` (nested modal flows) |
| **Backend Integration** | .NET 8 Web API with 160+ Controllers (`/api/*`) |
| **Real-Time Communication** | SignalR Core (`BiDashboardHub`, `ChatHub`, `NotificationHub`) |
| **Database & Caching** | PostgreSQL 16+, Redis 7+, Hive local encrypted storage |
| **Security Standards** | JWT Auth with sliding refresh, SAML 2.0 / OIDC SSO, Zero Trust CAC, Multi-Tenant Request Headers |

---
*Catalog maintained by CampusConnectSphere Core Architecture Team.*
