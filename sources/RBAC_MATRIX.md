# RBAC Matrix Baseline

This is the baseline matrix for high-risk modules. Backend authorization is authoritative. Flutter visibility converges to these rules.

### Context: The 3-Layer Decision Pipeline
In the normalized platform architecture, RBAC (Layer 3) operates downstream of Product Variant and Commercial Entitlement:
1. **Layer 1 (Product Capability)**: If the tenant's product variant does not support a feature (e.g., CBCS/DegreeAudit in K-12, or CCE Grading in Corporate), the feature is completely dropped.
2. **Layer 2 (Commercial Entitlement)**: If the tenant has not subscribed to the module in their plan, the feature is locked.
3. **Layer 3 (RBAC Permissions)**: Only when Layers 1 and 2 pass does RBAC evaluate whether the specific user holds the permission code to view or mutate the resource.

## Status Meaning

- `Aligned`: backend and frontend role visibility appear consistent at module level
- `Review`: role or action drift is likely and must be checked in Phase 1
- `Tighten`: module exists but action-level restrictions need explicit validation

## High-Risk Module Matrix

| Module | Backend Surface | Frontend Surface | Primary Roles | Required Module | Status | Notes |
|---|---|---|---|---|---|---|
| Admissions | `AdmissionController`, `AdmissionModuleController` | `admin_admissions_screen.dart`, `admin_enquiry_screen.dart`, `admin_seat_management_screen.dart`, `admissions_manager_screen.dart`, `counselor_crm_screen.dart` | `Admin`, `SchoolAdmin`, `AdmissionOfficer`, selected `Staff` | `Admissions` | Review | Backend has mixed authenticated and role-scoped flows; action-level review is required for staff visibility. |
| Fees | `FeesController`, `AdvancedFeesController`, `FeeReminderController` | `admin_fee_setup_screen.dart`, `admin_fee_dashboard_screen.dart`, `fees_screen.dart`, `fee_defaulter_screen.dart`, `fee_analytics_screen.dart` | `Admin`, `SchoolAdmin`, `Accountant`, end-user read paths for `Student` and `Parent` | `Finance` / fee-specific gating | Tighten | Reconciliation, reminder, concession, and override actions need explicit separation from read-only views. |
| Accounting | `AccountingController`, `VoucherController`, `DaybookController`, `FinancialController` | `voucher_entry_screen.dart`, `daybook_report_screen.dart`, finance dashboards | `Admin`, `SchoolAdmin`, `Accountant` | `Accounting` | Review | Approval and reversal paths must be checked against maker-checker expectations. |
| Payroll | `PayrollController`, `HrProfileController`, `LeaveController`, `LeaveManagementController` | `payroll_dashboard_screen.dart`, `hr_staff_profile_screen.dart`, `leave_management_screen.dart` | `Admin`, `SchoolAdmin`, `HR` | `Payroll` | Tighten | Payroll finalize and reopen semantics need explicit role validation. |
| Academic | `AcademicController`, `AcademicReportsController`, `OnlineExamController`, `ReportGenerationController` | `marks_entry_setup_screen.dart`, `teacher_evaluation_screen.dart`, `question_bank_screen.dart`, `report_card_screen.dart`, `holiday_calendar_screen.dart` | `Admin`, `SchoolAdmin`, `Teacher`, `Staff`, `Student`, `Parent` by action | `Academic` | Review | Teacher, staff, student, and parent read/write boundaries must be checked per action. |
| Attendance | `AttendanceEngineController`, `PeriodAttendanceController`, `BiometricController` | `attendance_history_screen.dart`, `attendance_camera_screen.dart`, `qr_attendance_*`, selfie review screens | `Admin`, `SchoolAdmin`, `Teacher`, `Staff`, `Student` by feature | `Attendance` | Tighten | Attendance anomaly, override, and payroll-lock interactions need dedicated review. |
| Communication | `NotificationController`, `BroadcastController`, `NoticeController`, `WhatsAppCampaignController`, `HelpdeskController` | `notification_screen.dart`, `notification_settings_screen.dart`, `notification_preferences_screen.dart`, `notice_board_screen.dart`, `whatsapp_campaign_screen.dart`, `helpdesk_*` | broad read roles; admin-send roles limited to `Admin`, `SchoolAdmin`, operational staff | `Communication` | Review | Draft/send/schedule/cancel actions require stricter separation than inbox/read surfaces. |
| Report Studio | `ReportStudioController`, `ReportTemplateController`, `ReportGenerationController` | `report_studio_screen.dart`, `report_studio_editor_screen.dart`, `report_studio_jobs_screen.dart` | `Admin`, `SchoolAdmin`, `SuperAdmin` | `Academic` for current implementation | Review | Publication and template-governance actions should map to maker-checker rules. |
| Inventory | `InventoryController` | `item_master_screen.dart`, `purchase_order_screen.dart`, `stock_receipt_screen.dart`, POS and stock screens | `Admin`, `SchoolAdmin`, operations staff | `Inventory` | Needs Review | Procurement, adjustment, and accounting sync need action-level permission mapping. |
| Library | `LibraryController` | `library_catalog_screen.dart`, `library_checkout_screen.dart`, `library_footfall_screen.dart` | `Admin`, `SchoolAdmin`, `Librarian`, `Staff`, `Teacher`, `Student` | `Library` | Review | Circulation versus catalog versus reporting actions need explicit split. |
| Transport | `TransportController`, `TransportAssignmentController` | `bus_tracking_screen.dart`, `bus_fleet_management_screen.dart`, `admin_transport_assignment_screen.dart` | `Admin`, `SchoolAdmin`, transport operators, read access for end users where enabled | `Transport` | Tighten | Assignment, live tracking, and parent-facing read surfaces should be separated in the matrix extension. |
| Hostel | `HostelController` | `hostel_room_management_screen.dart`, `hostel_occupancy_screen.dart` | `Admin`, `SchoolAdmin`, `Warden`, selected `Staff` | `Hostel` | Review | Fee tie-ins and occupancy controls need validated role split. |
| Laundry | `LaundryController` | `laundry_screen.dart` | `Admin`, `SchoolAdmin`, hostel or operations staff, selected student-facing paths | `Hostel` | Tighten | Current module coupling to hostel should be preserved until separated intentionally. |
| Visitor | `VisitorController` | `visitor_entry_screen.dart`, `visitor_book_screen.dart` | `Admin`, `SchoolAdmin`, `Staff`, `Security` | campus operations gating | Review | Security-sensitive actions need explicit audit and role review. |
| Staff Attendance | `StaffAttendanceController` | `staff_attendance_dashboard_screen.dart` | `SuperAdmin`, `OrgAdmin`, `HR`, `Manager`, `Employee` (self) | `PlatformPublic` / `StaffAttendance.Approve` | Aligned | 4-tier approval hierarchy (Employee $\rightarrow$ Manager $\rightarrow$ HR $\rightarrow$ Admin) with payroll freeze integration. |
| Tenant Backup & Restore | `TenantBackupRestoreController` | `tenant_backup_restore_screen.dart` | `SuperAdmin` exclusively | `SuperAdmin.BackupRestore` | Aligned | Strict SuperAdmin authority (`403 Forbidden` for School Admins). Supports branch-scoped and multi-variant backups. |
| LMS | `LmsController` | `admin_lms_screen.dart`, `lms_screen.dart` | `Admin`, `SchoolAdmin`, `Teacher`, `Staff`, `Student` by action | `Academic` | Review | Authoring, publishing, and student consumption are distinct permission bands. |

## Phase 1 Follow-Up (Action-Level RBAC Implemented)

A granular action-level authorization system has been introduced via `[RequirePermission("Permission.Action")]` in `.NET` and the `PermissionGate` widget in Flutter.

- A central `AppPermissions.cs` registry holds constants like `Fee.Read`, `Fee.Collect`, and `Fee.Override`.
- High-risk mutating endpoints in `FeesController.cs` (e.g., Apply Discount, Waive Fee, Collect Offline, Bulk Create) now explicitly require specific permissions like `AppPermissions.FeeOverride` and `AppPermissions.FeeCollect`.
- The `PermissionGate` widget conditionally renders UI elements based on explicit action claims from the `AuthProvider`.

### Next Steps for Phase 2:
- Map the explicit claims list from the `.NET` JWT to the `AuthProvider` session in Flutter.
- Wrap all CTA buttons across the Flutter admin screens (Fees, Admissions, HR) with `PermissionGate`.
- Enforce granular attributes across remaining controllers (`PayrollController`, `AccountingController`, `AdmissionController`).

---

## Granular User-Page RBAC Matrix & Dynamic Menu Engine (Enterprise Rollout)

To support school operations where specific staff members require customized access independent of broad role templates (e.g. an Accountant who needs access to Fee Setup but must be explicitly denied Fee Overrides, or a Senior Teacher granted read-write access to Attendance Reports), CampusConnectSphere provides the **Granular User-Page RBAC Matrix & Dynamic Menu Engine**.

### 1. Architectural Components

| Component | File / Surface | Description |
|---|---|---|
| **Data Model** | [`UserPagePermission.cs`](../backend_net/Models/UserPagePermission.cs) | Entity storing per-user, per-page/route CRUD permission overrides (`CanView`, `CanAdd`, `CanEdit`, `CanDelete`, `CanExport`) scoped by `SchoolId` and `BranchId`. |
| **Data Transfer Objects** | [`PagePermissionDtos.cs`](../backend_net/Dtos/PagePermissionDtos.cs) | DTOs for permission queries, batch matrix updates, dynamic menu tree filtering, and cache invalidation. |
| **Service Engine** | [`PagePermissionMatrixService.cs`](../backend_net/Platform/Authorization/PagePermissionMatrixService.cs) | Manages permission evaluations, batch upserts, Redis/Memory caching (12h sliding expiration), and dynamic navigation pruning. |
| **REST Controller** | [`UserPagePermissionController.cs`](../backend_net/Platform/Authorization/UserPagePermissionController.cs) | Protected endpoints under `[Authorize(Roles = "SuperAdmin,OrgAdmin,SchoolAdmin,Admin")]` with branch-level multi-tenant validation. |
| **Test Suite** | [`PagePermissionMatrixTests.cs`](file:///C:/Users/himan/Desktop/CampusConnectSphere/tests/backend_net_tests/PagePermissionMatrixTests.cs) | Comprehensive automated test fixture verifying matrix resolution, override precedence, and dynamic menu filtering (8/8 tests passing). |

### 2. Permission Resolution Hierarchy

When evaluating user access to a specific route or action, the engine adheres to strict deterministic precedence:
1. **Explicit User Denial (`CanView == false`)**: Overrides any role-level grants immediately.
2. **Explicit User Grant (`CanView == true`)**: Grants access even if the user's standard role does not include the page by default.
3. **Role Template Default**: If no explicit user override is configured, the system falls back to the default role permission mapping from `AppPermissions.cs`.

### 3. API Endpoints

- `GET /api/permissions/page-matrix/user/{userId}`: Retrieves the complete page-level permission matrix for a specific user.
- `POST /api/permissions/page-matrix/user/{userId}/batch`: Atomically upserts permission overrides for multiple pages/routes.
- `GET /api/permissions/page-matrix/my-menu`: Returns the dynamically filtered navigation menu for the authenticated user, excluding any unauthorized routes.
- `POST /api/permissions/page-matrix/user/{userId}/clear-cache`: Evicts the user's cached permission matrix from Redis/Memory, ensuring instant propagation.

### 4. High-Performance Caching & Eviction

- **12-Hour Sliding Window**: Evaluated matrices are cached using a composite key `page_matrix:{schoolId}:{userId}`.
- **Immediate Cache Eviction**: Batch updates or permission revocations automatically evict the cache key and trigger `SecurityStamp` invalidation if needed.
- **Dynamic Menu Pruning**: The mobile and web navigation drawer dynamically calls `GET /api/permissions/page-matrix/my-menu` upon login/resume, rendering only authorized route cards and navigation tiles.

