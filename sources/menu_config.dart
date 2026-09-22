/// Menu Configuration Model
/// Defines menu items that can be loaded dynamically based on user role
library;

import 'screens/asset_management_screen.dart';
import 'screens/import_center_screen.dart';
import 'screens/export_center_screen.dart';
import 'package:flutter/material.dart';
import 'screens/workflow_dashboard_screen.dart';
import 'screens/workflow_template_builder_screen.dart';
import 'screens/my_workflows_screen.dart';

// Screens imports
import 'dashboard_screen.dart';
import 'screens/student_feedback_screen.dart';
import 'screens/admin_feedback_moderation_screen.dart';
import 'screens/idea_box_screen.dart';
import 'screens/parent/parent_dashboard_screen.dart';
import 'screens/teacher/teacher_dashboard_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/trust_dashboard_screen.dart';
import 'screens/admissions/admin_admissions_screen.dart';
import 'screens/admissions/admin_enquiry_screen.dart';
import 'screens/admin/admin_master_setup_screen.dart';
import 'screens/admin_bulk_upload_screen.dart';
import 'screens/fees/admin_fee_setup_screen.dart';
import 'screens/fees/admin_fee_dashboard_screen.dart';
import 'screens/admin/admin_groups_screen.dart';
import 'screens/admissions/admin_seat_management_screen.dart';
import 'screens/exams/marks_entry_setup_screen.dart';
import 'screens/admin_notice_board_screen.dart';
import 'screens/fees/admin_offline_payment_screen.dart';
import 'screens/teacher/admin_teachers_screen.dart';
import 'screens/exams/assignments_screen.dart';
import 'screens/attendance/attendance_history_screen.dart';
import 'screens/attendance_camera_screen.dart'; // <--- NEW Visual Check-In
import 'screens/transport/bus_tracking_screen.dart';
import 'screens/student/certificate_screen.dart';
import 'screens/communication/chat_screen.dart';
import 'screens/exams/exam_schedule_screen.dart';
import 'screens/fees/fees_screen.dart';
import 'screens/admin_canteen_pos_screen.dart';
import 'screens/canteen_wallet_screen.dart';
import 'screens/canteen_preorder_screen.dart';
import 'screens/canteen_kitchen_screen.dart';
import 'screens/communication/notification_screen.dart';
import 'screens/exams/quiz_screen.dart';
import 'screens/report_card_screen.dart';
import 'screens/student/student_teachers_screen.dart';
import 'screens/teacher/teacher_grading_screen.dart';
import 'screens/teacher/teacher_students_screen.dart';
import 'screens/exams/timetable_screen.dart';
import 'screens/admin/admin_branch_screen.dart';
import 'screens/admin/admin_subadmin_screen.dart';
import 'screens/admin_rbac_panel_screen.dart';
import 'screens/admin_billing_pos_screen.dart';
import 'screens/admin_subscription_billing_screen.dart';
import 'screens/student_ledger_screen.dart';
import 'screens/digital_locker_screen.dart';
import 'screens/admin_webhooks_screen.dart';
import 'screens/admin_biometric_screen.dart';
import 'screens/admin_whitelabel_screen.dart';
import 'screens/design_system_gallery_screen.dart';
import 'screens/fees/admin_financial_dashboard_screen.dart';
import 'product_config.dart';
import 'platform/product/capabilities.dart';
import 'platform/product/capability_registry.dart';
import 'platform/product/navigation_resolver.dart';
import 'screens/finance_ai_audit_screen.dart';
import 'screens/payroll_ai_audit_screen.dart';

// 🔥 NEW CRM Screens
import 'screens/public_admission_form_screen.dart';
import 'screens/counselor_crm_screen.dart';
import 'screens/admissions_manager_screen.dart';
import 'screens/crm_source_analytics_screen.dart';

// 🔥 NEW Academic Module Screens
import 'screens/online_exam_screen.dart';
import 'screens/online_class_screen.dart';
import 'screens/teacher_review_screen.dart';

// 🔥 NEW Timetable & Substitution Module Screens
import 'screens/timetable_grid_screen.dart';
import 'screens/substitution_board_screen.dart';
import 'screens/timetable_setup_screen.dart';

// 🔥 NEW HR, Payroll & Attendance Module Screens
import 'screens/hr_dashboard_screen.dart';
import 'screens/payroll_processing_screen.dart';
import 'screens/hr_staff_profile_screen.dart';
import 'screens/hr_extended_module_screen.dart'; // 🔥 NEW: Appraisals, Loans, Assets
import 'screens/payroll_dashboard_screen.dart';
import 'screens/leave_management_screen.dart';
import 'screens/hr_staff_self_service_screen.dart';
import 'screens/staff_appraisal_screen.dart';
import 'screens/manager_appraisal_review_screen.dart';
import 'screens/hr_appraisal_dashboard_screen.dart';
import 'screens/diary_screen.dart';
import 'screens/parent_diary_screen.dart';
import 'screens/parent_teacher_chat_screen.dart';
import 'screens/accreditation_dashboard_screen.dart';
import 'screens/student_progress_tracker_screen.dart';
import 'screens/knowledge_base_screen.dart';
import 'screens/hpc_marking_screen.dart';
import 'screens/hpc_self_assessment_screen.dart';
import 'screens/offline_attendance_queue_screen.dart';
import 'screens/language_settings_screen.dart';
import 'screens/security_settings_screen.dart';

// 🔥 NEW Vouchers, Expenses & Daybook Accounting Screens
import 'screens/voucher_entry_screen.dart';
import 'screens/daybook_report_screen.dart';
import 'screens/fee_concession_checker_screen.dart';
import 'screens/fee_concession_maker_screen.dart';
import 'screens/smart_receipt_builder_screen.dart';

// 🔥 NEW Library / LMS Screens
import 'screens/library_scanner_screen.dart';
import 'screens/library_checkout_screen.dart';
import 'screens/library_catalog_screen.dart';
import 'screens/library_footfall_screen.dart';
import 'screens/library_fines_desk_screen.dart';
import 'screens/student_lms_portal_screen.dart';
import 'screens/admin_lms_screen.dart';
import 'screens/hostel_occupancy_screen.dart';
import 'screens/hostel_room_management_screen.dart';
import 'screens/hostel_ai_allotment_screen.dart';
import 'screens/notice_board_screen.dart';
import 'screens/notification_settings_screen.dart';
import 'screens/notification_preferences_screen.dart';
import 'screens/whatsapp_campaign_screen.dart';
import 'screens/bus_fleet_management_screen.dart';
import 'screens/staff_selfie_screen.dart';
import 'screens/admin_selfie_review_screen.dart';
import 'screens/role_selfie_attendance_screen.dart';
import 'screens/group_attendance_screen.dart';
import 'screens/attendance_face_enrollment_screen.dart';
import 'screens/attendance_review_queue_screen.dart';
import 'screens/attendance_policy_admin_screen.dart';
import 'screens/attendance_device_ops_screen.dart';
import 'screens/teacher_attendance_session_screen.dart';
import 'screens/attendance_timeline_screen.dart';
import 'screens/attendance_outbox_screen.dart';
import 'screens/attendance/admin_ai_attendance_analytics_screen.dart';
import 'screens/admin_ai_analytics_dashboard_screen.dart';
import 'screens/school_app_admin_console_screen.dart';
import 'screens/visitor_entry_screen.dart';
import 'screens/visitor_book_screen.dart';
import 'screens/admin_transport_assignment_screen.dart';
import 'screens/transport_playback_screen.dart';
import 'screens/holiday_calendar_screen.dart';
import 'screens/transport_ai_optimizer_screen.dart';
import 'screens/admin_audit_logs_screen.dart';

// 🔥 NEW SuperAdmin Screens
import 'screens/superadmin/super_admin_dashboard_screen.dart';
import 'screens/superadmin/super_admin_school_list_screen.dart';
import 'screens/superadmin/super_admin_billing_console_screen.dart';
import 'screens/superadmin/super_admin_plan_manager_screen.dart';
import 'screens/superadmin/super_admin_school_credentials_screen.dart';
import 'screens/superadmin/super_admin_metering_wallet_screen.dart';
import 'screens/superadmin/impersonation_session_center_screen.dart';
import 'screens/superadmin/admin_report_jobs_screen.dart';
import 'screens/super_admin_analytics_screen.dart';

// 🔥 NEW Credential Management
import 'screens/admin_user_credentials_screen.dart';
import 'screens/student_profile_history_screen.dart';
import 'screens/student_analytics_portal_screen.dart';

// 🔥 Phase 13: Inventory, POS & Stock Module Screens
import 'screens/pos_screen.dart';
import 'screens/item_master_screen.dart';
import 'screens/purchase_order_screen.dart';
import 'screens/inventory_purchase_return_screen.dart';
import 'screens/inventory_stock_audit_screen.dart';
import 'screens/stock_receipt_screen.dart';

// 🔥 Phase 14: Report Template Management
import 'screens/reports/admin_report_template_screen.dart';

// 🔥 Sprint 7: Report Studio V2
import 'screens/report_studio_screen.dart';
import 'screens/report_studio_v2_screen.dart';
import 'screens/scheduled_bi_reports_manager_screen.dart';

// 🔥 Phase 15: Admin Profile
import 'screens/admin/admin_profile_screen.dart';
import 'screens/alumni_portal_screen.dart';
import 'screens/admin_alumni_hub_screen.dart';
import 'screens/biometric_device_management_screen.dart';
import 'screens/admin_cce_rules_screen.dart';
import 'screens/fee_defaulter_screen.dart';
import 'screens/laundry_screen.dart';
import 'screens/admin_gallery_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/exam_analytics_screen.dart';
import 'screens/admin_ptm_screen.dart';
import 'screens/ptm_screen.dart';
import 'screens/qr_attendance_teacher_screen.dart';
import 'screens/qr_attendance_student_screen.dart';
import 'screens/fee_analytics_screen.dart';
import 'screens/teacher_risk_dashboard_screen.dart';
import 'screens/helpdesk_list_screen.dart';

// 🔥 Missing Mapped Screens
import 'screens/inventory_stock_prediction_screen.dart';
import 'screens/student_fee_payment_screen.dart';
import 'screens/enterprise/admin_enterprise_attendance_screen.dart';
import 'screens/enterprise/parent_enterprise_attendance_screen.dart';
import 'screens/enterprise/staff_enterprise_attendance_screen.dart';
import 'screens/campus_bot_screen.dart';
import 'screens/worklife_timezone_settings_screen.dart';
import 'screens/field_tracking_screen.dart';
import 'screens/gps_device_management_screen.dart';
import 'screens/chart_of_accounts_screen.dart';
import 'screens/verify_certificate_scanner_screen.dart';
import 'screens/student_course_prerequisites_screen.dart';
import 'screens/student_holds_screen.dart';
import 'screens/student_financial_aid_screen.dart';
import 'screens/student_degree_audit_screen.dart';
import 'screens/student_course_registration_screen.dart';
import 'screens/student_discipline_screen.dart';
import 'screens/student_placement_screen.dart';
import 'screens/admin_live_tracking_map_screen.dart';

// Operational Control Consoles
import 'screens/finance/payment_reconciliation_center_screen.dart';
import 'screens/finance/refund_approval_center_screen.dart';
import 'screens/finance/payment_webhook_dead_letter_screen.dart';
import 'screens/finance/fiscal_period_lock_screen.dart';
import 'screens/finance/security_deposit_admin_screen.dart';
import 'screens/superadmin/tenant_provisioning_wizard_screen.dart';
import 'screens/superadmin/global_operations_incident_screen.dart';
import 'screens/security/effective_access_analyzer_screen.dart';
import 'screens/security/security_siem_incident_screen.dart';
import 'screens/student_lifecycle/student_lifecycle_transition_console_screen.dart';
import 'screens/attendance/offline_sync_conflict_center_screen.dart';
import 'screens/exams/exam_moderation_revaluation_center_screen.dart';
import 'screens/canteen/pos_end_of_day_settlement_screen.dart';
import 'screens/ats_recruitment_screen.dart';
import 'screens/student_identity_card_screen.dart';
import 'screens/elective_selection_screen.dart';
import 'screens/higher_ed/student_outpass_screen.dart';
import 'screens/higher_ed/warden_outpass_dashboard.dart';

enum MenuBadgeType { none, updates, attention, live }

enum MenuPersonaCluster {
  executive,
  schoolOps,
  specialistOps,
  teaching,
  endUser,
  general,
}

enum RoleDashboardTemplate {
  executive,
  schoolOps,
  specialistOps,
  teaching,
  endUser,
}

class RoleShellConfig {
  final String role;
  final String homeItemId;
  final String homeTitle;
  final IconData homeIcon;
  final List<String> workbenchItemIds;
  final List<String> mobilePrimaryItemIds;
  final List<String> defaultFavoriteItemIds;
  final List<String> focusItemIds;
  final List<String> quickAccessItemIds;
  final String welcomeTitle;
  final String welcomeSubtitle;
  final RoleDashboardTemplate dashboardTemplate;
  final Color accentColor;

  RoleShellConfig({
    required this.role,
    required this.homeItemId,
    required this.homeTitle,
    required this.homeIcon,
    required this.workbenchItemIds,
    required this.mobilePrimaryItemIds,
    required this.defaultFavoriteItemIds,
    required this.focusItemIds,
    required this.quickAccessItemIds,
    required this.welcomeTitle,
    required this.welcomeSubtitle,
    required this.dashboardTemplate,
    required this.accentColor,
  });
}

/// Represents a menu item in the app
class MenuItem {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<String> keywords;
  final int priority;
  final bool showInWorkbench;
  final bool showInMobilePrimary;
  final bool allowFavorite;
  final MenuBadgeType badgeType;
  final MenuPersonaCluster personaCluster;
  final List<String> allowedRoles; // Which roles can see this item
  final List<String> allowedVariants; // Which variants this applies to (eSiksha, Worklife, All)
  final bool isNavItem; // Is this a primary navigation item?
  final String category; // Group name for section headers
  final String? requiredModule; // Which SaaS module is required
  final String? requiredPermission; // 🔥 NEW: Permission required to view
  final String? requiredCapability; // Capability key required (Layer 1 product architecture)
  final bool isLocked; // 🔥 NEW: Whether the module is locked
  final Widget Function(String token) pageBuilder;

  MenuItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.allowedRoles,
    this.allowedVariants = const ['All'],
    required this.pageBuilder,
    this.isNavItem = false,
    this.category = 'General',
    this.requiredModule,
    this.requiredPermission,
    this.requiredCapability,
    this.isLocked = false,
    this.keywords = const <String>[],
    this.priority = 500,
    this.showInWorkbench = false,
    this.showInMobilePrimary = false,
    this.allowFavorite = true,
    this.badgeType = MenuBadgeType.none,
    this.personaCluster = MenuPersonaCluster.general,
  });
}

/// Menu configuration for the entire app
class MenuConfig {
  /// All available menu items in the app
  static List<MenuItem> getAllMenuItems() {
    return [
      MenuItem(
        id: 'super_admin_analytics',
        title: "Cross-Module Analytics",
        icon: Icons.analytics,
        color: Colors.deepPurple,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => const SuperAdminAnalyticsScreen(),
        category: '⚡ Super Admin Console',
      ),
      MenuItem(
        id: 'report_studio_v2',
        title: "Report Studio V2",
        icon: Icons.dashboard_customize,
        color: Colors.purple,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const ReportStudioV2Screen(),
        category: '⚡ Super Admin Console',
      ),
      MenuItem(
        id: 'scheduled_bi_reports',
        title: "Scheduled BI Reports",
        icon: Icons.schedule_send,
        color: Colors.deepOrange,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const ScheduledBiReportsManagerScreen(),
        category: '⚡ Super Admin Console',
      ),
      MenuItem(
        id: 'tenant_provisioning',
        title: 'Tenant Provisioning Wizard',
        icon: Icons.domain_add_rounded,
        color: Colors.purple,
        allowedRoles: const ['SuperAdmin'],
        pageBuilder: (token) => const TenantProvisioningWizardScreen(),
        category: '⚡ Super Admin Console',
      ),
      MenuItem(
        id: 'global_operations_incident',
        title: 'Global Ops Incidents',
        icon: Icons.crisis_alert_rounded,
        color: Colors.redAccent,
        allowedRoles: const ['SuperAdmin'],
        pageBuilder: (token) => const GlobalOperationsIncidentScreen(),
        category: '⚡ Super Admin Console',
      ),
      MenuItem(
        id: 'effective_access_analyzer',
        title: 'Effective Access Analyzer',
        icon: Icons.security_rounded,
        color: Colors.indigo,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const EffectiveAccessAnalyzerScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'security_siem_incident',
        title: 'SIEM Security Incidents',
        icon: Icons.shield_outlined,
        color: Colors.deepOrange,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const SecuritySiemIncidentScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'payment_reconciliation',
        title: 'Payment Reconciliation Center',
        icon: Icons.receipt_long_rounded,
        color: Colors.teal,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => const PaymentReconciliationCenterScreen(),
        category: '💰 Fee Management',
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'refund_approval',
        title: 'Refund Approval Center',
        icon: Icons.assignment_return_rounded,
        color: Colors.deepOrange,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => const RefundApprovalCenterScreen(),
        category: '💰 Fee Management',
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'payment_dead_letter',
        title: 'Payment Webhook Dead-Letter',
        icon: Icons.mark_email_unread_rounded,
        color: Colors.red,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const PaymentWebhookDeadLetterScreen(),
        category: '💰 Fee Management',
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fiscal_period_lock',
        title: 'Fiscal Period Lock',
        icon: Icons.lock_clock_rounded,
        color: Colors.blueGrey,
        allowedRoles: const ['SuperAdmin', 'Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => const FiscalPeriodLockScreen(),
        category: '💰 Fee Management',
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'security_deposits',
        title: 'Security Deposit Admin',
        icon: Icons.savings_rounded,
        color: Colors.teal,
        allowedRoles: const ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => const SecurityDepositAdminScreen(),
        category: '💰 Fee Management',
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'student_lifecycle_console',
        title: 'Lifecycle Transition Console',
        icon: Icons.swap_calls_rounded,
        color: Colors.indigo,
        allowedRoles: const ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const StudentLifecycleTransitionConsoleScreen(),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'offline_sync_conflict',
        title: 'Offline Sync Conflicts',
        icon: Icons.sync_problem_rounded,
        color: Colors.orange,
        allowedRoles: const ['Admin', 'SchoolAdmin', 'Teacher'],
        pageBuilder: (token) => const OfflineSyncConflictCenterScreen(),
        category: '⚙️ Administration',
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'exam_moderation_revaluation',
        title: 'Exam Moderation & Revaluation',
        icon: Icons.grading_rounded,
        color: Colors.deepPurple,
        allowedRoles: const ['Admin', 'SchoolAdmin', 'Teacher'],
        pageBuilder: (token) => const ExamModerationRevaluationCenterScreen(),
        category: '📊 Examination & Result',
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'canteen_settlement',
        title: 'POS End-of-Day Settlement',
        icon: Icons.point_of_sale_rounded,
        color: Colors.orange,
        allowedRoles: const ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => const PosEndOfDaySettlementScreen(),
        category: '🍎 Canteen',
        requiredModule: 'Canteen',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'import_center',
        title: "Import Center",
        icon: Icons.file_upload,
        color: Colors.blue,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => ImportCenterScreen(),
        category: '📥 Import & Export Center',
      ),
      MenuItem(
        id: 'export_center',
        title: "Export Center",
        icon: Icons.file_download,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => ExportCenterScreen(),
        category: '📥 Import & Export Center',
      ),
      MenuItem(
        id: 'admin_live_tracking',
        title: 'Live Tracking Map',
        icon: Icons.map,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AdminLiveTrackingMapScreen(token: token),
        category: '⚙️ Administration',
        requiredModule: 'FieldTracking',
        requiredPermission: 'Tracking.ViewLive',
        requiredCapability: Capability.fieldTracking,
      ),
      MenuItem(
        id: 'asset_management',
        title: 'Asset Management',
        icon: Icons.inventory_2,
        color: Colors.blue,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AssetManagementScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'workflow_dashboard',
        title: "Workflow Dashboard",
        icon: Icons.account_tree,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Staff', 'OrgAdmin'],
        pageBuilder: (token) => WorkflowDashboardScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'workflow_template_builder',
        title: "Workflow Templates",
        icon: Icons.schema,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => WorkflowTemplateBuilderScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'my_workflows',
        title: "My Workflows",
        icon: Icons.checklist_rtl,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Staff', 'OrgAdmin', 'Employee', 'Student'],
        pageBuilder: (token) => MyWorkflowsScreen(),
        category: '⚙️ Administration',
      ),
      // ========================================
      // STUDENT MENU ITEMS
      // ========================================
      MenuItem(
        id: 'idea_box',
        title: 'Idea Box',
        icon: Icons.lightbulb_outline,
        color: Colors.amber,
        allowedRoles: [
          'Manager',
          'Employee',
          'HRManager',
          'OrgAdmin',
          'SchoolAdmin',
        ],
        pageBuilder: (token) => IdeaBoxScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        requiredModule: 'Communication',
      ),
      MenuItem(
        id: 'parent_home',
        title: 'My Children',
        icon: Icons.family_restroom,
        color: Colors.indigo,
        allowedRoles: ['Parent'],
        pageBuilder: (token) => ParentDashboardScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        requiredCapability: Capability.parentPortal,
      ),
      if (ProductConfig.current.variant != 'worklife_connect')
        MenuItem(
          id: 'alumni_portal',
          title: 'Alumni Portal',
          icon: Icons.groups,
          color: Colors.blue,
          allowedRoles: ['Alumni'],
          pageBuilder: (token) => AlumniPortalScreen(token: token),
          isNavItem: true,
          category: '🎓 Student Management',
          requiredModule: 'Alumni',
          requiredCapability: Capability.alumni,
        ),
      MenuItem(
        id: 'student_home',
        title: 'Home',
        icon: Icons.home,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => DashboardScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'student_analytics',
        title: 'My Analytics',
        icon: Icons.insights,
        color: Colors.orange,
        allowedRoles: ['Student', 'Parent'],
        pageBuilder: (token) => StudentAnalyticsPortalScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
      ),
      MenuItem(
        id: 'digital_locker',
        title: 'Digital Locker',
        icon: Icons.cloud_done,
        color: Colors.blueAccent,
        allowedRoles: ['Student', 'Alumni'],
        pageBuilder: (token) => DigitalLockerScreen(),
        isNavItem: true,
        category: '🌐 Online Learning',
        requiredModule: null,
      ),
      MenuItem(
        id: 'student_feedback',
        title: 'Feedback',
        icon: Icons.feedback,
        color: Colors.blue,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentFeedbackScreen(),
        isNavItem: false,
        category: '💰 Fee Management',
        requiredModule: null,
      ),
      MenuItem(
        id: 'admin_feedback_moderation',
        title: 'Feedback Moderation',
        icon: Icons.rate_review,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => const AdminFeedbackModerationScreen(),
        isNavItem: false,
        category: '💬 Communication',
        requiredModule: 'Communication',
      ),
      MenuItem(
        id: 'student_teachers',
        title: 'My Teachers',
        icon: Icons.school,
        color: Colors.teal,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentTeachersScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'assignments',
        title: 'Assignments',
        icon: Icons.book,
        color: Colors.orange,
        allowedRoles: ['Student', 'Teacher'],
        pageBuilder: (token) =>
            AssignmentsScreen(token: token, isTeacher: false),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'chat',
        title: 'Class Chat',
        icon: Icons.chat_bubble,
        color: Colors.blue,
        allowedRoles: ['Student', 'Teacher'],
        pageBuilder: (token) => ChatScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'parent_diary',
        title: 'Digital Diary',
        icon: Icons.book,
        color: Colors.teal,
        allowedRoles: ['Parent'],
        pageBuilder: (token) => ParentDiaryScreen(),
        isNavItem: true,
        category: '📅 Academic Management',
        requiredModule: 'Communication',
        requiredCapability: Capability.parentPortal,
      ),
      MenuItem(
        id: 'teacher_diary',
        title: 'Digital Diary',
        icon: Icons.menu_book,
        color: Colors.amber,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => DiaryScreen(),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
        requiredModule: 'Communication',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'parent_teacher_chat',
        title: 'Parent-Teacher Chat',
        icon: Icons.forum,
        color: Colors.indigo,
        allowedRoles: ['Parent', 'Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => ParentTeacherChatScreen(token: token),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
        requiredModule: 'Communication',
        requiredCapability: Capability.parentPortal,
      ),
      MenuItem(
        id: 'timetable',
        title: 'Timetable',
        icon: Icons.calendar_month,
        color: Colors.deepPurple,
        allowedRoles: ['Student', 'Teacher'],
        pageBuilder: (token) => TimetableScreen(token: token, isTeacher: false),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Timetable',
        requiredCapability: Capability.timetable,
      ),
      MenuItem(
        id: 'exams',
        title: 'My Exams',
        icon: Icons.timer,
        color: Colors.redAccent,
        allowedRoles: ['Student', 'Teacher'],
        pageBuilder: (token) =>
            ExamScheduleScreen(token: token, isTeacher: false),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'library',
        title: 'E-Library',
        icon: Icons.library_books,
        color: Colors.brown,
        allowedRoles: ['Student', 'Teacher'],
        pageBuilder: (token) => LibraryCatalogScreen(token: token),
        category: '🌐 Online Learning',
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'library_scanner',
        title: 'Library Scanner',
        icon: Icons.qr_code_scanner,
        color: Colors.brown,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'Librarian'],
        pageBuilder: (token) => const LibraryScannerScreen(),
        category: '📚 Library',
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'knowledge_base',
        title: 'Knowledge Base',
        icon: Icons.menu_book,
        color: Colors.blue,
        allowedRoles: const [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Student',
          'Parent',
          'HRManager',
          'Manager',
          'Employee',
          'OrgAdmin',
        ],
        pageBuilder: (token) => KnowledgeBaseScreen(token: token),
        isNavItem: true,
        category: '🌐 Online Learning',
        requiredModule: 'KnowledgeBase',
      ),
      MenuItem(
        id: 'report_card',
        title: 'Report Card',
        icon: Icons.analytics,
        color: Colors.pink,
        allowedRoles: ['Student'],
        pageBuilder: (token) => ReportCardScreen(token: token),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Grading,
      ),
      MenuItem(
        id: 'hpc_marking',
        title: 'HPC Marking',
        icon: Icons.grading,
        color: Colors.deepPurple,
        allowedRoles: const ['Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => HpcMarkingScreen(token: token, isAdmin: true),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Grading,
      ),
      MenuItem(
        id: 'hpc_self_assessment',
        title: 'My Self-Assessment',
        icon: Icons.self_improvement,
        color: Colors.teal,
        allowedRoles: const ['Student'],
        pageBuilder: (token) => HpcSelfAssessmentScreen(token: token),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Grading,
      ),
      MenuItem(
        id: 'offline_attendance_queue',
        title: 'Offline Attendance Queue',
        icon: Icons.cloud_sync,
        color: Colors.orange,
        allowedRoles: const ['Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => OfflineAttendanceQueueScreen(token: token),
        category: '📅 Academic Management',
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'language_settings',
        title: 'Language',
        icon: Icons.translate,
        color: Colors.indigo,
        allowedRoles: const [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Student',
          'Parent',
          'HRManager',
          'Manager',
          'Employee',
          'OrgAdmin',
        ],
        pageBuilder: (token) => LanguageSettingsScreen(token: token),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'online_exams',
        title: 'Online Exams',
        icon: Icons.computer,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => OnlineExamScreen(),
        isNavItem: true,
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'student_online_classes',
        title: 'Live Classes',
        icon: Icons.video_camera_front,
        color: Colors.redAccent,
        allowedRoles: ['Student'],
        pageBuilder: (token) => OnlineClassScreen(token: token),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.lms,
      ),
      MenuItem(
        id: 'lms_student',
        title: 'Learning Hub',
        icon: Icons.school,
        color: Colors.blueAccent,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentLmsPortalScreen(token: token),
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.lms,
      ),
      MenuItem(
        id: 'ptm_parent',
        title: 'PTM Bookings',
        icon: Icons.event,
        color: Colors.deepOrange,
        allowedRoles: ['Parent'],
        pageBuilder: (token) => PtmScreen(token: token),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.ptm,
      ),
      MenuItem(
        id: 'fees',
        title: 'Fee Summary',
        icon: Icons.payment,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => FeesScreen(token: token, isAdmin: false),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredPermission: 'Fee.Read',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'student_fee_payment',
        title: 'Pay Fees',
        icon: Icons.credit_card,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentFeePaymentScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'canteen_wallet_student',
        title: 'Canteen Wallet',
        icon: Icons.account_balance_wallet,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => CanteenWalletScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Canteen',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'canteen_preorder',
        title: 'Pre-Order Lunch',
        icon: Icons.fastfood,
        color: Colors.orange,
        allowedRoles: ['Parent', 'Student'],
        pageBuilder: (token) => CanteenPreOrderScreen(token: token),
        category: '🍎 Canteen',
        requiredModule: 'Canteen',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'canteen_kitchen',
        title: 'Kitchen Display (KDS)',
        icon: Icons.restaurant_menu,
        color: Colors.orange,
        allowedRoles: const ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => CanteenKitchenScreen(token: token),
        category: '🍎 Canteen',
        requiredModule: 'Canteen',
        requiredPermission: 'Canteen.Manage',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'student_ledger',
        title: 'My Ledger',
        icon: Icons.account_balance_wallet,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentLedgerScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'student_course_prerequisites',
        title: 'Course Prerequisites',
        icon: Icons.playlist_add_check,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentCoursePrerequisitesScreen(),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.courseRegistration,
      ),
      MenuItem(
        id: 'student_holds',
        title: 'Academic Holds',
        icon: Icons.gavel,
        color: Colors.red,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentHoldsScreen(),
        isNavItem: true,
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.courseRegistration,
      ),
      MenuItem(
        id: 'student_financial_aid',
        title: 'Financial Aid',
        icon: Icons.volunteer_activism,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentFinancialAidScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'student_degree_audit',
        title: 'Degree Audit',
        icon: Icons.school,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentDegreeAuditScreen(),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.degreeAudit,
      ),
      MenuItem(
        id: 'student_progress_tracker',
        title: 'AI Progress & OBE',
        icon: Icons.trending_up,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentProgressTrackerScreen(),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.obe,
      ),
      MenuItem(
        id: 'student_course_registration',
        title: 'Course Registration',
        icon: Icons.app_registration,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentCourseRegistrationScreen(),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.courseRegistration,
      ),
      MenuItem(
        id: 'student_discipline',
        title: 'Conduct & Merit',
        icon: Icons.gavel,
        color: Colors.redAccent,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentDisciplineScreen(),
        isNavItem: true,
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
      ),
      MenuItem(
        id: 'new_admission',
        title: 'New Admission',
        icon: Icons.app_registration,
        color: Colors.deepOrange,
        allowedRoles: ['Student', 'Parent'],
        pageBuilder: (token) => PublicAdmissionFormScreen(),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredPermission: 'Admission.Read',
        requiredCapability: Capability.admissions,
      ),
      MenuItem(
        id: 'canteen_wallet_parent',
        title: 'Canteen Wallet',
        icon: Icons.account_balance_wallet,
        color: Colors.green,
        allowedRoles: ['Parent'],
        pageBuilder: (token) => CanteenWalletScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Canteen',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'verify_document',
        title: 'Verify Document',
        icon: Icons.verified_user_outlined,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Parent', 'Student'],
        pageBuilder: (token) => VerifyCertificateScannerScreen(),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'certificates',
        title: 'Certificates',
        icon: Icons.workspace_premium,
        color: Colors.brown,
        allowedRoles: ['Student'],
        pageBuilder: (token) => CertificateScreen(token: token),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'bus_tracker',
        title:
            ProductConfig.current.homeSpec.terminology['transport_tracker'] ??
            'Bus Tracker',
        icon: Icons.directions_bus,
        color: Colors.amber,
        allowedRoles: ['Student', 'Parent', 'Admin'],
        pageBuilder: (token) => BusTrackingScreen(token: token, isAdmin: false),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      MenuItem(
        id: 'laundry_student',
        title: 'Laundry',
        icon: Icons.dry_cleaning,
        color: Colors.blueAccent,
        allowedRoles: ['Student'],
        pageBuilder: (token) => LaundryScreen(),
        category: '🎓 Student Management',
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'gallery_user',
        title: 'Event Gallery',
        icon: Icons.photo_library,
        color: Colors.purpleAccent,
        allowedRoles: ['Student', 'Parent', 'Teacher'],
        pageBuilder: (token) => GalleryScreen(),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'attendance_history',
        title: 'Attendance',
        icon: Icons.history,
        color: Colors.grey,
        allowedRoles: ['Student'],
        pageBuilder: (token) => AttendanceHistoryScreen(token: token),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'qr_attendance_student',
        title: 'Scan Attendance QR',
        icon: Icons.qr_code_scanner,
        color: Colors.teal,
        allowedRoles: ['Student'],
        pageBuilder: (token) => QrAttendanceStudentScreen(token: token),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'student_selfie_attendance',
        title: 'Selfie Attendance',
        icon: Icons.camera_front,
        color: Colors.green,
        allowedRoles: ['Student'],
        pageBuilder: (token) => RoleSelfieAttendanceScreen(
          title: 'Student Selfie Attendance',
          subtitle:
              'Your school must enable student selfie attendance before this flow can be approved.',
        ),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'student_face_enrollment',
        title: 'Face Enrollment',
        icon: Icons.badge,
        color: Colors.blueGrey,
        allowedRoles: ['Student'],
        pageBuilder: (token) => AttendanceFaceEnrollmentScreen(),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'student_attendance_timeline',
        title: 'Attendance Timeline',
        icon: Icons.timeline,
        color: Colors.indigo,
        allowedRoles: ['Student'],
        pageBuilder: (token) =>
            AttendanceTimelineScreen(token: token, forStaff: false),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'student_placement_portal',
        title: 'Placement Portal',
        icon: Icons.work,
        color: Colors.blueAccent,
        allowedRoles: ['Student'],
        pageBuilder: (token) => StudentPlacementScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        requiredCapability: Capability.placements,
      ),

      // ========================================
      // TEACHER MENU ITEMS
      // ========================================
      MenuItem(
        id: 'teacher_home',
        title: 'Portal',
        icon: Icons.dashboard,
        color: Colors.orange,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => TeacherDashboardScreen(token: token),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
      ),
      MenuItem(
        id: 'student_risk_dashboard',
        title: 'At-Risk Students',
        icon: Icons.warning_amber_rounded,
        color: Colors.redAccent,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => TeacherRiskDashboardScreen(),
        isNavItem: false,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.ai,
      ),
      MenuItem(
        id: 'campus_bot',
        title: 'CampusBot',
        icon: Icons.smart_toy_outlined,
        color: Colors.indigo,
        allowedRoles: [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Parent',
          'Student',
        ],
        pageBuilder: (token) => CampusBotScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        requiredCapability: Capability.ai,
      ),
      MenuItem(
        id: 'my_students',
        title: 'My Students',
        icon: Icons.people,
        color: Colors.teal,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => TeacherStudentsScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'grades',
        title: 'Grades',
        icon: Icons.grade,
        color: Colors.red,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => TeacherGradingScreen(token: token),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.k12Grading,
      ),
      MenuItem(
        id: 'teacher_assignments',
        title: 'Assignments',
        icon: Icons.post_add,
        color: Colors.blue,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) =>
            AssignmentsScreen(token: token, isTeacher: true),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'teacher_timetable',
        title: 'Timetable',
        icon: Icons.calendar_today,
        color: Colors.deepPurple,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => TimetableScreen(token: token, isTeacher: true),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.timetable,
      ),
      MenuItem(
        id: 'teacher_exams',
        title: 'Exams',
        icon: Icons.timer,
        color: Colors.redAccent,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) =>
            ExamScheduleScreen(token: token, isTeacher: true),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'teacher_exam_reviews',
        title: 'Review Answers',
        icon: Icons.rate_review,
        color: Colors.deepPurple,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => TeacherReviewScreen(),
        isNavItem: true,
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'teacher_online_classes',
        title: 'Virtual Classroom',
        icon: Icons.video_call,
        color: Colors.redAccent,
        allowedRoles: ['Teacher', 'Staff', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => OnlineClassScreen(token: token),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.lms,
      ),
      MenuItem(
        id: 'lms_admin',
        title: 'LMS Studio',
        icon: Icons.upload_file,
        color: Colors.teal,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminLmsScreen(token: token),
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.lms,
      ),
      MenuItem(
        id: 'quiz',
        title: 'Quizzes',
        icon: Icons.quiz,
        color: Colors.indigo,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => QuizScreen(token: token, isTeacher: true),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'teacher_library',
        title: 'Library',
        icon: Icons.library_books,
        color: Colors.brown,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => LibraryCatalogScreen(token: token),
        category: '👨🏫 Staff & HR',
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'visual_checkin',
        title: 'Visual Check-In',
        icon: Icons.camera_front,
        color: Colors.indigo,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => AttendanceCameraScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'staff_selfie_checkin',
        title: 'Selfie Check-In',
        icon: Icons.camera_front,
        color: Colors.green,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => StaffSelfieScreen(),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'advanced_selfie_checkin',
        title: 'Advanced Selfie',
        icon: Icons.face_retouching_natural,
        color: Colors.lightBlue,
        allowedRoles: ['Teacher', 'Staff'],
        pageBuilder: (token) => RoleSelfieAttendanceScreen(
          title: 'Advanced Selfie Attendance',
          subtitle:
              'This flow uses policy, geofence, liveness, and face verification before attendance is written.',
        ),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'group_attendance',
        title: 'Group Attendance',
        icon: Icons.groups_2,
        color: Colors.deepOrange,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => GroupAttendanceScreen(),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      if (ProductConfig.current.variant == 'enterprise') ...[
        MenuItem(
          id: 'admin_ent_attendance',
          title: 'Enterprise Attendance',
          icon: Icons.co_present,
          color: Colors.teal,
          allowedRoles: ['Admin', 'SchoolAdmin'],
          pageBuilder: (token) => AdminEnterpriseAttendanceScreen(),
          category: '👨🏫 Staff & HR',
          allowedVariants: const ['Worklife'],
          requiredModule: 'Attendance',
          requiredCapability: Capability.shiftAttendance,
        ),
        MenuItem(
          id: 'parent_ent_attendance',
          title: 'Child Attendance (Ent)',
          icon: Icons.co_present,
          color: Colors.teal,
          allowedRoles: ['Parent'],
          pageBuilder: (token) => ParentEnterpriseAttendanceScreen(),
          category: '📅 Academic Management',
          allowedVariants: const ['eSiksha'],
          requiredModule: 'Attendance',
          requiredCapability: Capability.attendance,
        ),
        MenuItem(
          id: 'staff_ent_attendance',
          title: 'My Attendance (Ent)',
          icon: Icons.co_present,
          color: Colors.teal,
          allowedRoles: ['Staff', 'Teacher'],
          pageBuilder: (token) => StaffEnterpriseAttendanceScreen(),
          category: '👨🏫 Staff & HR',
          allowedVariants: const ['Worklife'],
          requiredModule: 'Attendance',
          requiredCapability: Capability.shiftAttendance,
        ),
      ],
      MenuItem(
        id: 'face_enrollment',
        title: 'Face Enrollment',
        icon: Icons.badge,
        color: Colors.blueGrey,
        allowedRoles: ['Teacher', 'Staff', 'Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AttendanceFaceEnrollmentScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'qr_attendance_teacher',
        title: 'QR Attendance',
        icon: Icons.qr_code_2,
        color: Colors.teal,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => QrAttendanceTeacherScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'teacher_attendance_session',
        title: 'Direct Attendance',
        icon: Icons.how_to_reg,
        color: Colors.deepPurple,
        allowedRoles: ['Teacher', 'Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => TeacherAttendanceSessionScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'staff_attendance_timeline',
        title: 'My Attendance Timeline',
        icon: Icons.timeline,
        color: Colors.indigo,
        allowedRoles: ['Teacher', 'Staff', 'Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) =>
            AttendanceTimelineScreen(token: token, forStaff: true),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'evaluation_entry',
        title: 'Evaluation Grid',
        icon: Icons.grid_on,
        color: Colors.deepOrange,
        allowedRoles: ['Teacher', 'Staff', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => MarksEntrySetupScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
      ),

      // 🔥 NEW: Timetable & Substitution Module
      MenuItem(
        id: 'timetable_schedule',
        title: 'Timetable',
        icon: Icons.schedule,
        color: Color(0xFF3B82F6),
        allowedRoles: ['Teacher', 'Staff', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => TimetableGridScreen(token: token),
        isNavItem: true,
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.timetable,
      ),
      MenuItem(
        id: 'timetable_setup',
        title: 'Timetable Setup',
        icon: Icons.settings_suggest,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => TimetableSetupScreen(token: token),
        category: '⚙️ Administration',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Timetable',
        requiredCapability: Capability.timetable,
      ),
      MenuItem(
        id: 'exam_analytics',
        title: 'Exam Analytics',
        icon: Icons.analytics,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher'],
        pageBuilder: (token) => ExamAnalyticsScreen(token: token),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'ptm_admin',
        title: 'PTM Scheduler',
        icon: Icons.event_available,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher'],
        pageBuilder: (token) => AdminPtmScreen(token: token),
        category: '⚙️ Administration',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.ptm,
      ),
      MenuItem(
        id: 'substitution_board',
        title: 'Substitution Board',
        icon: Icons.swap_horiz,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => SubstitutionBoardScreen(token: token),
        isNavItem: true,
        category: '📅 Academic Management',
        requiredModule: 'Timetable',
        requiredCapability: Capability.timetable,
      ),

      // ========================================
      // ADMIN MENU ITEMS
      // ========================================
      MenuItem(
        id: 'accreditation_dashboard',
        title: 'Accreditation Engine',
        icon: Icons.assignment_turned_in,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Staff'],
        pageBuilder: (token) => AccreditationDashboardScreen(),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        requiredModule: 'Accreditation',
        requiredCapability: Capability.accreditation,
      ),

      // 🔥 NEW HR & Payroll Module
      MenuItem(
        id: 'hr_staff_profiles',
        title: 'HR Profiles',
        icon: Icons.badge,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => HrStaffProfileScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'hr_extended_suite',
        title: 'Advanced HR Suite',
        icon: Icons.auto_graph_rounded,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => HrExtendedModuleScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'staff_appraisal',
        title: 'My Appraisals',
        icon: Icons.rate_review,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR', 'Teacher', 'Staff'],
        pageBuilder: (token) => StaffAppraisalScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.appraisalCycles,
      ),
      MenuItem(
        id: 'manager_appraisal_review',
        title: 'Team Appraisals',
        icon: Icons.groups,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR', 'Teacher'],
        pageBuilder: (token) => ManagerAppraisalReviewScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.appraisalCycles,
      ),
      MenuItem(
        id: 'hr_dashboard',
        title: 'HR Dashboard',
        icon: Icons.dashboard_customize_rounded,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => HrDashboardScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'payroll_processing',
        title: 'Payroll Processing',
        icon: Icons.payments_rounded,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => PayrollProcessingScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'hr_appraisal_dashboard',
        title: 'HR Appraisals',
        icon: Icons.approval,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => HrAppraisalDashboardScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.appraisalCycles,
      ),
      MenuItem(
        id: 'payroll_dashboard',
        title: 'Payroll Ledger',
        icon: Icons.request_quote,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR', 'Staff', 'Teacher'],
        pageBuilder: (token) => PayrollDashboardScreen(),
        category: '💰 Fee Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'payroll_ai_audit',
        title: 'AI Payroll Audit',
        icon: Icons.psychology_outlined,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => PayrollAiAuditScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.payroll,
      ),
      MenuItem(
        id: 'leave_management',
        title: 'My Leaves',
        icon: Icons.event_busy,
        color: Colors.redAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Staff', 'HR'],
        pageBuilder: (token) => LeaveManagementScreen(),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Payroll',
        requiredCapability: Capability.leaveManagement,
      ),
      MenuItem(
        id: 'hr_staff_self_service',
        title: 'My Self Service',
        icon: Icons.badge_outlined,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Staff', 'HR'],
        pageBuilder: (token) => HrStaffSelfServiceScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
      ),
      MenuItem(
        id: 'biometric_device_management',
        title: 'Biometric Devices',
        icon: Icons.fingerprint,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => BiometricDeviceManagementScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'attendance_review_queue',
        title: 'Attendance Review',
        icon: Icons.fact_check,
        color: Colors.amber,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AttendanceReviewQueueScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'attendance_policy_admin',
        title: 'Attendance Policies',
        icon: Icons.policy,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AttendancePolicyAdminScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'attendance_device_ops',
        title: 'Device Ops',
        icon: Icons.monitor_heart,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AttendanceDeviceOpsScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'attendance_outbox',
        title: 'Attendance Outbox',
        icon: Icons.outbox,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AttendanceOutboxScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'ai_attendance_analytics',
        title: 'AI Analytics',
        icon: Icons.analytics,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AiAttendanceAnalyticsScreen(token: token),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      MenuItem(
        id: 'school_app_console',
        title: 'School App Console',
        icon: Icons.phone_iphone,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => SchoolAppAdminConsoleScreen(token: token),
        category: '🎓 Student Management',
      ),
      if (ProductConfig.current.variant != 'worklife_connect')
        MenuItem(
          id: 'alumni_hub',
          title: 'Alumni Hub',
          icon: Icons.groups,
          color: Colors.teal,
          allowedRoles: ['Admin', 'SchoolAdmin'],
          pageBuilder: (token) => AdminAlumniHubScreen(token: token),
          category: '🎓 Student Management',
          requiredModule: 'Alumni',
          requiredCapability: Capability.alumni,
        ),
      MenuItem(
        id: 'advanced_cce_rules',
        title: 'Advanced CCE',
        icon: Icons.rule,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminCceRulesScreen(token: token),
        category: '📊 Examination & Result',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.cceRules,
      ),

      MenuItem(
        id: 'admin_home',
        title: 'Console',
        icon: Icons.admin_panel_settings,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminDashboardScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'trust_dashboard',
        title: 'Trust Overview',
        icon: Icons.account_balance,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => TrustDashboardScreen(token: token),
        category: '📈 Reports & Analytics',
      ),
      MenuItem(
        id: 'admin_ai_analytics_dashboard',
        title: 'AI Insights',
        icon: Icons.psychology,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminAiAnalyticsDashboardScreen(),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        requiredCapability: Capability.ai,
      ),
      MenuItem(
        id: 'manage_teachers',
        title: 'Teachers',
        icon: Icons.person_add,
        color: Colors.blue,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminTeachersScreen(token: token),
        category: '👨🏫 Staff & HR',
      ),
      MenuItem(
        id: 'class_groups',
        title: 'Classes',
        icon: Icons.group_work,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminGroupsScreen(token: token),
        isNavItem: true,
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
      ),
      MenuItem(
        id: 'admission_review',
        title: 'Admissions',
        icon: Icons.approval,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'AdmissionOfficer', 'Staff'],
        pageBuilder: (token) => AdminAdmissionsScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.admissions,
      ),
      MenuItem(
        id: 'counselor_crm',
        title: 'CRM Tasks',
        icon: Icons.assignment_ind,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'AdmissionOfficer', 'Staff'],
        pageBuilder: (token) => CounselorCrmScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.crm,
      ),
      MenuItem(
        id: 'enquiry_pipeline',
        title: 'Enquiry Pipeline',
        icon: Icons.manage_search,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'AdmissionOfficer', 'Staff'],
        pageBuilder: (token) => AdminEnquiryScreen(token: token),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.admissions,
      ),
      MenuItem(
        id: 'admissions_manager',
        title: 'Convert Leads',
        icon: Icons.handshake,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'], // Only High Clearance
        pageBuilder: (token) => AdmissionsManagerScreen(),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.admissions,
      ),
      MenuItem(
        id: 'crm_source_analytics',
        title: 'AI Source Analytics',
        icon: Icons.analytics,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => CrmSourceAnalyticsScreen(),
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'CRM',
        requiredCapability: Capability.crm,
      ),
      MenuItem(
        id: 'seat_management',
        title: 'Seat Management',
        icon: Icons.event_seat,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'AdmissionOfficer'],
        pageBuilder: (token) => AdminSeatManagementScreen(token: token),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.admissions,
      ),
      MenuItem(
        id: 'fee_setup',
        title: 'Fee Setup',
        icon: Icons.settings_applications,
        color: Colors.purple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminFeeSetupScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fee_dashboard',
        title: 'Fee Dashboard',
        icon: Icons.dashboard,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant', 'Staff'],
        pageBuilder: (token) => AdminFeeDashboardScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fee_analytics',
        title: 'Fee Analytics',
        icon: Icons.bar_chart,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => FeeAnalyticsScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'chart_of_accounts',
        title: 'Chart of Accounts',
        icon: Icons.account_tree_outlined,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => ChartOfAccountsScreen(),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Accounting',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'financial_dashboard',
        title: 'Financials',
        icon: Icons.analytics_outlined,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => AdminFinancialDashboardScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Accounting',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'finance_ai_audit',
        title: 'AI Forensic Audit',
        icon: Icons.security,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => FinanceAiAuditScreen(),
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Accounting',
        requiredCapability: Capability.ai,
      ),
      MenuItem(
        id: 'offline_payment',
        title: 'Payments',
        icon: Icons.storefront,
        color: Colors.brown,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant', 'Staff'],
        pageBuilder: (token) => AdminOfflinePaymentScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fee_concession_maker',
        title: 'Concession Requests',
        icon: Icons.percent,
        color: Colors.deepOrange,
        allowedRoles: [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Accountant',
        ],
        pageBuilder: (token) => FeeConcessionMakerScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fee_concession_checker',
        title: 'Concession Checker',
        icon: Icons.rule_folder,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => FeeConcessionCheckerScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'fee_defaulters',
        title: 'Fee Defaulters',
        icon: Icons.warning_amber,
        color: Colors.deepOrange,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => FeeDefaulterScreen(token: token),
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'billing_pos',
        title: 'POS Desk',
        icon: Icons.point_of_sale,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant', 'Staff'],
        pageBuilder: (token) => AdminBillingPosScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'smart_receipts',
        title: 'Smart Receipts',
        icon: Icons.receipt_long,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant', 'Staff'],
        pageBuilder: (token) => SmartReceiptBuilderScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        keywords: ['receipt', 'billing', 'gst', 'smart receipt'],
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'subscription_billing',
        title: 'Subscription Billing',
        icon: Icons.payments,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminSubscriptionBillingScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
      ),
      MenuItem(
        id: 'all_fees',
        title: 'Fee Reports',
        icon: Icons.attach_money,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant', 'Staff'],
        pageBuilder: (token) => FeesScreen(token: token, isAdmin: true),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Finance',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'notice_board',
        title: 'Broadcast Center',
        icon: Icons.campaign,
        color: Colors.redAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminNoticeBoardScreen(token: token),
        category: '🎓 Student Management',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'notification_settings',
        title: 'Notification Ops',
        icon: Icons.tune,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => NotificationSettingsScreen(token: token),
        category: '⚙️ Administration',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'security_settings',
        title: 'Security Settings',
        icon: Icons.security,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'Teacher', 'Parent', 'Student', 'Alumni'],
        pageBuilder: (token) => SecuritySettingsScreen(token: token),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'notification_preferences',
        title: 'Notification Preferences',
        icon: Icons.notifications_paused_outlined,
        color: Colors.indigo,
        allowedRoles: [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Student',
          'Parent',
          'Accountant',
          'Warden',
          'Librarian',
          'AdmissionOfficer',
          'Alumni',
        ],
        pageBuilder: (token) => NotificationPreferencesScreen(token: token),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'notice_board_feed',
        title: 'Notice Board',
        icon: Icons.article_outlined,
        color: Colors.blueAccent,
        allowedRoles: [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Student',
          'Parent',
          'Accountant',
          'Warden',
          'Librarian',
          'AdmissionOfficer',
        ],
        pageBuilder: (token) => NoticeBoardScreen(),
        category: '💰 Fee Management',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'holiday_calendar',
        title: 'Academic Calendar',
        icon: Icons.event_note,
        color: Colors.deepPurple,
        allowedRoles: [
          'Admin',
          'SchoolAdmin',
          'Teacher',
          'Staff',
          'Student',
          'Parent',
          'Accountant',
          'Warden',
          'Librarian',
          'AdmissionOfficer',
        ],
        pageBuilder: (token) => HolidayCalendarScreen(token: token),
        category: '📅 Academic Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'helpdesk',
        title: 'Helpdesk',
        icon: Icons.support_agent,
        color: Colors.blueGrey,
        allowedRoles: ['Parent', 'Admin', 'SchoolAdmin', 'Teacher', 'Staff'],
        pageBuilder: (token) => HelpdeskListScreen(token: token),
        category: '🎓 Student Management',
        requiredModule: 'Communication',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'whatsapp_campaigns',
        title: 'WA Campaigns',
        icon: Icons.campaign,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => WhatsAppCampaignScreen(token: token),
        category: '🎓 Student Management',
        requiredModule: 'Communication',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'selfie_review',
        title: 'Selfie Review',
        icon: Icons.fact_check,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AdminSelfieReviewScreen(),
        category: '👨🏫 Staff & HR',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Attendance',
        requiredCapability: Capability.attendance,
      ),
      if (ProductConfig.current.isWorklife || ProductConfig.current.isEsiksha)
        MenuItem(
          id: 'field_tracking',
          title: ProductConfig.current.isEsiksha
              ? 'Driver Tracking'
              : 'Field Tracking',
          icon: Icons.person_pin_circle,
          color: Colors.deepPurple,
          allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'HR', 'Driver'],
          pageBuilder: (token) => FieldTrackingScreen(),
          category: ProductConfig.current.isEsiksha
              ? 'Transport'
              : 'Staff & HR',
          requiredModule: ProductConfig.current.isEsiksha
              ? 'Transport'
              : 'FieldTracking',
          requiredCapability: ProductConfig.current.isEsiksha
              ? Capability.schoolTransport
              : Capability.fieldTracking,
          badgeType: MenuBadgeType.live,
        ),
      MenuItem(
        id: 'admin_bus',
        title: ProductConfig.current.isCampus
            ? 'Shuttle Tracking'
            : 'Transport',
        icon: Icons.directions_bus,
        color: Colors.amber,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'TransportManager'],
        pageBuilder: (token) => BusTrackingScreen(token: token, isAdmin: true),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      MenuItem(
        id: 'bus_fleet_management',
        title:
            ProductConfig.current.homeSpec.terminology['transport_fleet'] ??
            'Fleet Ops',
        icon: Icons.build_circle,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'TransportManager'],
        pageBuilder: (token) => BusFleetManagementScreen(token: token),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      if (!ProductConfig.current.isWorklife)
        MenuItem(
          id: 'gps_device_management',
          title: 'GPS Devices',
          icon: Icons.sensors,
          color: Colors.indigo,
          allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'TransportManager'],
          pageBuilder: (token) => GpsDeviceManagementScreen(),
          category: '📍 GPS & Biometric',
          allowedVariants: const ['eSiksha'],
          requiredModule: 'Transport',
          requiredCapability: Capability.schoolTransport,
          badgeType: MenuBadgeType.live,
        ),
      MenuItem(
        id: 'transport_assignment',
        title: 'Route Assignment',
        icon: Icons.alt_route,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminTransportAssignmentScreen(token: token),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      MenuItem(
        id: 'transport_playback',
        title: 'Route Playback',
        icon: Icons.history_toggle_off,
        color: Colors.purple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'TransportManager'],
        pageBuilder: (token) => TransportPlaybackScreen(token: token),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      MenuItem(
        id: 'transport_ai_optimizer',
        title: 'Smart Routes',
        icon: Icons.auto_awesome,
        color: Colors.orange.shade800,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'TransportManager'],
        pageBuilder: (token) => TransportAiOptimizerScreen(),
        category: '📍 GPS & Biometric',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Transport',
        requiredCapability: Capability.schoolTransport,
      ),
      MenuItem(
        id: 'admin_audit_logs',
        title: 'Audit Logs',
        icon: Icons.security,
        color: Colors.redAccent,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminAuditLogScreen(token: token),
        category: '📈 Reports & Analytics',
      ),
      MenuItem(
        id: 'notifications',
        title: 'Alerts',
        icon: Icons.notifications_active,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Teacher', 'Student'],
        pageBuilder: (token) => NotificationScreen(token: token),
        category: '🎓 Student Management',
        requiredCapability: Capability.communication,
      ),
      MenuItem(
        id: 'canteen_pos',
        title: 'Canteen POS',
        icon: Icons.fastfood,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminCanteenPosScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Canteen',
        requiredCapability: Capability.canteen,
      ),
      MenuItem(
        id: 'bulk_import',
        title: 'Bulk Upload',
        icon: Icons.cloud_upload,
        color: Colors.cyan,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminBulkUploadScreen(token: token),
        category: '📥 Import & Export Center',
      ),
      MenuItem(
        id: 'visitor_entry',
        title: 'Visitor Entry',
        icon: Icons.how_to_reg,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => VisitorEntryScreen(),
        isNavItem: true,
        category: '📍 GPS & Biometric',
      ),
      MenuItem(
        id: 'laundry_admin',
        title: 'Laundry Ops',
        icon: Icons.dry_cleaning,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => LaundryScreen(),
        category: '⚙️ Administration',
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'gallery_admin',
        title: 'Gallery Mgmt',
        icon: Icons.photo_library,
        color: Colors.purpleAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminGalleryScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'visitor_book',
        title: 'Visitor Book',
        icon: Icons.menu_book,
        color: Colors.brown,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => VisitorBookScreen(),
        category: '📍 GPS & Biometric',
      ),
      MenuItem(
        id: 'hostel_rooms',
        title: 'Hostel Rooms',
        icon: Icons.apartment,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Warden', 'Staff'],
        pageBuilder: (token) => HostelRoomManagementScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'hostel_occupancy',
        title: 'Hostel Occupancy',
        icon: Icons.bed,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Warden', 'Staff'],
        pageBuilder: (token) => HostelOccupancyScreen(token: token),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'hostel_ai_allotment',
        title: 'AI Room Allotment',
        icon: Icons.psychology,
        color: Colors.brown,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Warden'],
        pageBuilder: (token) => HostelAiAllotmentScreen(),
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'branches',
        title: 'Branches',
        icon: Icons.business,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => AdminBranchScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'subadmins',
        title: 'Staff Access',
        icon: Icons.settings,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminSubAdminScreen(token: token),
        isNavItem: true,
        category: '📊 Examination & Result',
      ),
      MenuItem(
        id: 'admin_rbac',
        title: 'Role Permissions',
        icon: Icons.shield,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminRbacPanelScreen(token: token),
        isNavItem: true,
        category: '👨🏫 Staff & HR',
      ),
      MenuItem(
        id: 'master_setup',
        title: 'Master Setup',
        icon: Icons.admin_panel_settings,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminMasterSetupScreen(token: token),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'webhooks_settings',
        title: 'Webhooks',
        icon: Icons.webhook,
        color: Colors.greenAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminWebhooksScreen(token: token),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'biometric_integration',
        title: 'Biometrics',
        icon: Icons.fingerprint,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminBiometricScreen(token: token),
        category: '📍 GPS & Biometric',
      ),
      MenuItem(
        id: 'whitelabel_branding',
        title: 'Theme & Branding',
        icon: Icons.palette,
        color: Colors.pinkAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminWhitelabelScreen(token: token),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'design_system_gallery',
        title: 'Design System Gallery',
        icon: Icons.auto_awesome_mosaic_rounded,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'SuperAdmin', 'Developer'],
        pageBuilder: (token) => const DesignSystemGalleryScreen(),
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'report_template',
        title: 'Report Templates (Legacy)',
        icon: Icons.design_services,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminReportTemplateScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'report_studio',
        title: 'Report Studio V2',
        icon: Icons.architecture,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => ReportStudioScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'report_delivery_jobs',
        title: 'Report Delivery',
        icon: Icons.send_and_archive,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminReportJobsScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Academic',
        requiredCapability: Capability.k12Academic,
      ),
      MenuItem(
        id: 'admin_profile',
        title: 'My Profile',
        icon: Icons.account_circle,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminProfileScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      if (ProductConfig.current.variant == 'worklife_connect')
        MenuItem(
          id: 'timezone_settings',
          title: 'Timezone Settings',
          icon: Icons.schedule,
          color: Colors.teal,
          allowedRoles: ['Admin', 'SchoolAdmin'],
          pageBuilder: (token) => WorklifeTimezoneSettingsScreen(),
          isNavItem: true,
          category: '⚙️ Administration',
        ),
      MenuItem(
        id: 'student_credentials',
        title: 'User Credentials',
        icon: Icons.vpn_key,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => AdminUserCredentialsScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'student_profile_history',
        title: 'Student Profile Audits',
        icon: Icons.history_edu_rounded,
        color: Colors.blueAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'AdmissionOfficer'],
        pageBuilder: (token) => StudentProfileHistoryScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
      ),

      // ========================================
      // ADMISSION OFFICER SPECIFIC
      // ========================================
      MenuItem(
        id: 'officer_admissions',
        title: 'Review Apps',
        icon: Icons.fact_check,
        color: Colors.teal,
        allowedRoles: ['AdmissionOfficer', 'Staff'],
        pageBuilder: (token) => AdminAdmissionsScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Admissions',
        requiredCapability: Capability.admissions,
      ),

      // ========================================
      // VOUCHERS, EXPENSES & DAYBOOK
      // ========================================
      MenuItem(
        id: 'voucher_entry',
        title: 'Voucher Entry',
        icon: Icons.receipt_long,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'Accountant'],
        pageBuilder: (token) => VoucherEntryScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Accounting', // specifically for vouchers/accounting
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'daybook_report',
        title: 'Daybook Report',
        icon: Icons.book,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => DaybookReportScreen(),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Accounting',
        requiredCapability: Capability.fees,
      ),
      MenuItem(
        id: 'expense_claims',
        title: 'Expense Claims',
        icon: Icons.receipt_long,
        color: Colors.deepPurple,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'HR', 'Accountant'],
        pageBuilder: (token) => VoucherEntryScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Accounting',
        requiredCapability: Capability.expenseClaims,
      ),

      // ========================================
      // LIBRARY / LMS ENGINE
      // ========================================
      MenuItem(
        id: 'library_checkout',
        title: 'Checkout Desk',
        icon: Icons.sync_alt,
        color: Colors.indigo,
        allowedRoles: ['Librarian', 'Admin', 'Staff'],
        pageBuilder: (token) => LibraryCheckoutScreen(),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'library_catalog',
        title: 'Book Catalog',
        icon: Icons.book,
        color: Colors.brown,
        allowedRoles: ['Librarian', 'Admin', 'Staff'],
        pageBuilder: (token) => LibraryCatalogScreen(token: token),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'library_footfall',
        title: 'Library Footfall',
        icon: Icons.people,
        color: Colors.teal,
        allowedRoles: ['Librarian', 'Admin', 'Staff'],
        pageBuilder: (token) => LibraryFootfallScreen(),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),
      MenuItem(
        id: 'library_fines',
        title: 'Fines Desk',
        icon: Icons.receipt_long,
        color: Colors.redAccent,
        allowedRoles: ['Librarian', 'Admin', 'Staff'],
        pageBuilder: (token) => LibraryFinesDeskScreen(token: token),
        isNavItem: true,
        category: '🌐 Online Learning',
        allowedVariants: const ['eSiksha'],
        requiredModule: 'Library',
        requiredCapability: Capability.library,
      ),

      // ========================================
      // 🔥 PHASE 13: INVENTORY, POS & STOCK MODULE
      // ========================================
      MenuItem(
        id: 'inventory_pos',
        title: 'Inventory POS',
        icon: Icons.point_of_sale,
        color: Colors.teal,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'Accountant'],
        pageBuilder: (token) => PosScreen(),
        isNavItem: true,
        category: '💰 Fee Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'item_master',
        title: 'Item Catalog',
        icon: Icons.inventory_2,
        color: Colors.indigo,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => ItemMasterScreen(),
        isNavItem: true,
        category: '⚙️ Administration',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'inventory_prediction',
        title: 'AI Stock Prediction',
        icon: Icons.online_prediction,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => InventoryStockPredictionScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'stock_receive',
        title: 'Receive Stock',
        icon: Icons.add_shopping_cart,
        color: Colors.green,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff'],
        pageBuilder: (token) => StockReceiptScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'purchase_orders',
        title: 'Purchase Orders',
        icon: Icons.request_page,
        color: Colors.orange,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Staff', 'Accountant'],
        pageBuilder: (token) => PurchaseOrderScreen(),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'purchase_returns',
        title: 'Purchase Returns (RTV)',
        icon: Icons.assignment_return,
        color: Colors.redAccent,
        allowedRoles: ['Admin', 'SchoolAdmin', 'Accountant'],
        pageBuilder: (token) => InventoryPurchaseReturnScreen(token: token),
        isNavItem: true,
        category: '🎓 Student Management',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),
      MenuItem(
        id: 'stock_audit',
        title: 'Physical Stock Audit',
        icon: Icons.fact_check,
        color: Colors.blueGrey,
        allowedRoles: ['Admin', 'SchoolAdmin'],
        pageBuilder: (token) => InventoryStockAuditScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
        allowedVariants: const ['Worklife'],
        requiredModule: 'Inventory',
        requiredCapability: Capability.inventory,
      ),

      // ========================================
      // SUPERADMIN MENU ITEMS (SaaS Management)
      // ========================================
      MenuItem(
        id: 'saas_dashboard',
        title: 'SaaS Overview',
        icon: Icons.analytics,
        color: Colors.deepPurple,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminDashboardScreen(token: token),
        isNavItem: true,
        category: '📈 Reports & Analytics',
      ),
      MenuItem(
        id: 'saas_schools',
        title: 'Manage Schools',
        icon: Icons.domain,
        color: Colors.indigo,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminSchoolListScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'saas_plans',
        title: 'Plan Management',
        icon: Icons.card_membership,
        color: Colors.teal,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminPlanManagerScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'saas_billing_console',
        title: 'Billing Console',
        icon: Icons.account_balance_wallet,
        color: Colors.green,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminBillingConsoleScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
      ),
      MenuItem(
        id: 'saas_school_credentials',
        title: 'School Credentials',
        icon: Icons.key,
        color: Colors.amber,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminSchoolCredentialsScreen(token: token),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'saas_metering_wallet',
        title: 'Prepaid Wallet & Metering',
        icon: Icons.speed_rounded,
        color: Colors.deepOrange,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => SuperAdminMeteringWalletScreen(token: token),
        isNavItem: true,
        category: '💰 Fee Management',
      ),
      MenuItem(
        id: 'saas_impersonation',
        title: 'Break-Glass Impersonation',
        icon: Icons.shield_outlined,
        color: Colors.red,
        allowedRoles: ['SuperAdmin'],
        pageBuilder: (token) => const ImpersonationSessionCenterScreen(),
        isNavItem: true,
        category: '⚙️ Administration',
      ),
      MenuItem(
        id: 'ats_recruitment',
        title: 'ATS Recruitment & Hiring',
        icon: Icons.work_outline,
        color: Colors.teal,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin', 'HR'],
        pageBuilder: (token) => AtsRecruitmentScreen(token: token),
        category: '👨‍🏫 Staff & HR',
        requiredCapability: Capability.ats,
      ),
      MenuItem(
        id: 'student_identity_cards',
        title: 'Student ID Card Studio',
        icon: Icons.badge_outlined,
        color: Colors.indigo,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin', 'Teacher'],
        pageBuilder: (token) => const StudentIdentityCardScreen(tenantId: ''),
        category: '🎓 Student Management',
      ),
      MenuItem(
        id: 'elective_selection',
        title: 'CBCS Elective Selection',
        icon: Icons.how_to_reg_outlined,
        color: Colors.blue,
        allowedRoles: ['Student'],
        pageBuilder: (token) => const ElectiveSelectionScreen(studentId: 0),
        category: '📅 Academic Management',
        requiredCapability: Capability.cbcs,
      ),
      MenuItem(
        id: 'student_outpass',
        title: 'Digital Hostel Outpass',
        icon: Icons.qr_code_scanner,
        color: Colors.deepOrange,
        allowedRoles: ['Student'],
        pageBuilder: (token) => const StudentOutpassScreen(),
        category: '🎓 Student Management',
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
      MenuItem(
        id: 'warden_outpass_approval',
        title: 'Hostel Outpass Approval',
        icon: Icons.verified_user_outlined,
        color: Colors.purple,
        allowedRoles: ['SuperAdmin', 'Admin', 'SchoolAdmin', 'Teacher', 'Warden'],
        pageBuilder: (token) => const WardenOutpassDashboard(),
        category: '🎓 Student Management',
        requiredModule: 'Hostel',
        requiredCapability: Capability.k12Hostel,
      ),
    ];
  }

  /// Get menu items for a specific role, allowed modules limit, and product variant
  static List<MenuItem> getMenuItemsForRole(
    String role,
    List<String>? allowedModules, {
    bool isAdmin = false,
    String? productVariant,
    CapabilityRegistry? registry,
    List<String> permissions = const [],
  }) {
    final variant = (productVariant ?? ProductConfig.current.variant).toLowerCase();
    final effectiveRegistry = registry ??
        CapabilityRegistry.fallbackFor(
          variant,
          enabledModules: allowedModules,
        );

    final resolver = NavigationResolver(
      registry: effectiveRegistry,
      userRole: role,
      isAdmin: isAdmin,
      permissions: permissions,
    );

    final candidateItems = _applyProductMenuGating(getAllMenuItems());
    return resolver.resolve(candidateItems);
  }

  static List<MenuItem> _applyProductMenuGating(List<MenuItem> items) {
    final hiddenIds = ProductConfig.current.homeSpec.hiddenMenuItemIds;
    if (hiddenIds.isEmpty) {
      return items;
    }

    return items.where((item) => !hiddenIds.contains(item.id)).toList();
  }

  /// Get primary navigation items for a role (bottom/side nav)
  static List<MenuItem> getNavItemsForRole(
    String role,
    List<String>? allowedModules, {
    bool isAdmin = false,
    String? productVariant,
    CapabilityRegistry? registry,
    List<String> permissions = const [],
  }) {
    return getMenuItemsForRole(
      role,
      allowedModules,
      isAdmin: isAdmin,
      productVariant: productVariant,
      registry: registry,
      permissions: permissions,
    ).where((item) => item.isNavItem).toList();
  }

  /// Get all items grouped by category for a role
  static Map<String, List<MenuItem>> getGroupedMenuItems(
    String role,
    List<String>? allowedModules, {
    bool isAdmin = false,
    String? productVariant,
    CapabilityRegistry? registry,
    List<String> permissions = const [],
  }) {
    final items = getMenuItemsForRole(
      role,
      allowedModules,
      isAdmin: isAdmin,
      productVariant: productVariant,
      registry: registry,
      permissions: permissions,
    );
    final Map<String, List<MenuItem>> grouped = {};

    for (var item in items) {
      grouped.putIfAbsent(item.category, () => []);
      grouped[item.category]!.add(item);
    }

    return grouped;
  }

  static MenuItem? getMenuItemById(
    String role,
    String itemId,
    List<String>? allowedModules, {
    bool isAdmin = false,
    String? productVariant,
    CapabilityRegistry? registry,
    List<String> permissions = const [],
  }) {
    try {
      return getMenuItemsForRole(
        role,
        allowedModules,
        isAdmin: isAdmin,
        productVariant: productVariant,
        registry: registry,
        permissions: permissions,
      ).firstWhere((item) => item.id == itemId);
    } catch (_) {
      return null;
    }
  }

  static List<MenuItem> getMenuItemsByIds(
    String role,
    Iterable<String> itemIds,
    List<String>? allowedModules, {
    bool isAdmin = false,
    String? productVariant,
    CapabilityRegistry? registry,
    List<String> permissions = const [],
  }) {
    final available = getMenuItemsForRole(
      role,
      allowedModules,
      isAdmin: isAdmin,
      productVariant: productVariant,
      registry: registry,
      permissions: permissions,
    );
    final byId = <String, MenuItem>{
      for (final item in available) item.id: item,
    };
    return itemIds.map((id) => byId[id]).whereType<MenuItem>().toList();
  }

  static RoleShellConfig getShellConfigForRole(String role) {
    switch (role.toLowerCase()) {
      case 'subadmin':
      case 'hr':
      case 'hrmanager':
      case 'employee':
        return getShellConfigForRole('Staff');
      case 'orgadmin':
      case 'manager':
        return getShellConfigForRole('Admin');
      case 'admin':
        return RoleShellConfig(
          role: 'Admin',
          homeItemId: 'admin_home',
          homeTitle: 'Operations Console',
          homeIcon: Icons.admin_panel_settings,
          workbenchItemIds: [
            'admin_home',
            'admin_ai_analytics_dashboard',
            'finance_ai_audit',
            'payroll_ai_audit',
            'hostel_ai_allotment',
            'transport_ai_optimizer',
            'gps_device_management',
            'crm_source_analytics',
            'admission_review',
            'fee_dashboard',
            'manage_teachers',
            'hr_extended_suite',
            'field_tracking',
            'subadmins',
            'report_studio',
          ],
          mobilePrimaryItemIds: [
            'admin_home',
            'admin_ai_analytics_dashboard',
            'admission_review',
            'fee_dashboard',
            'gps_device_management',
            'field_tracking',
            'report_studio',
          ],
          defaultFavoriteItemIds: [
            'enquiry_pipeline',
            'seat_management',
            'branches',
            'master_setup',
            'holiday_calendar',
          ],
          focusItemIds: [
            'admission_review',
            'enquiry_pipeline',
            'fee_dashboard',
            'manage_teachers',
            'report_studio',
            'transport_assignment',
            'gps_device_management',
            'field_tracking',
          ],
          quickAccessItemIds: [
            'subadmins',
            'branches',
            'master_setup',
            'holiday_calendar',
            'notice_board',
            'gps_device_management',
            'field_tracking',
          ],
          welcomeTitle: 'School command center',
          welcomeSubtitle:
              'Run admissions, finance, people, and academic operations from one focused workspace.',
          dashboardTemplate: RoleDashboardTemplate.schoolOps,
          accentColor: Colors.blueGrey,
        );
      case 'schooladmin':
        return RoleShellConfig(
          role: 'SchoolAdmin',
          homeItemId: 'admin_home',
          homeTitle: 'School Console',
          homeIcon: Icons.account_balance,
          workbenchItemIds: [
            'admin_home',
            'admin_ai_analytics_dashboard',
            'finance_ai_audit',
            'payroll_ai_audit',
            'hostel_ai_allotment',
            'transport_ai_optimizer',
            'gps_device_management',
            'crm_source_analytics',
            'admission_review',
            'fee_dashboard',
            'manage_teachers',
            'hr_extended_suite',
            'field_tracking',
            'subadmins',
            'report_studio',
          ],
          mobilePrimaryItemIds: [
            'admin_home',
            'admin_ai_analytics_dashboard',
            'admission_review',
            'fee_dashboard',
            'gps_device_management',
            'field_tracking',
            'report_studio',
          ],
          defaultFavoriteItemIds: [
            'enquiry_pipeline',
            'seat_management',
            'branches',
            'master_setup',
            'holiday_calendar',
          ],
          focusItemIds: [
            'admission_review',
            'enquiry_pipeline',
            'fee_dashboard',
            'manage_teachers',
            'report_studio',
            'transport_assignment',
            'gps_device_management',
            'field_tracking',
          ],
          quickAccessItemIds: [
            'subadmins',
            'branches',
            'master_setup',
            'holiday_calendar',
            'notice_board',
            'gps_device_management',
            'field_tracking',
          ],
          welcomeTitle: 'Campus operations desk',
          welcomeSubtitle:
              'Stay on top of academic planning, fee operations, staffing, and branch-ready tasks.',
          dashboardTemplate: RoleDashboardTemplate.schoolOps,
          accentColor: Colors.blueGrey,
        );
      case 'teacher':
        return RoleShellConfig(
          role: 'Teacher',
          homeItemId: 'teacher_home',
          homeTitle: 'Teaching Desk',
          homeIcon: Icons.school,
          workbenchItemIds: [
            'teacher_home',
            'my_students',
            'evaluation_entry',
            'ai_exam_grader',
            'teacher_assignments',
            'teacher_exam_reviews',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'teacher_home',
            'my_students',
            'evaluation_entry',
            'ai_exam_grader',
            'teacher_assignments',
          ],
          defaultFavoriteItemIds: [
            'teacher_online_classes',
            'teacher_timetable',
            'leave_management',
            'holiday_calendar',
          ],
          focusItemIds: [
            'evaluation_entry',
            'my_students',
            'teacher_assignments',
            'teacher_exam_reviews',
            'teacher_online_classes',
          ],
          quickAccessItemIds: [
            'teacher_timetable',
            'timetable_schedule',
            'leave_management',
            'holiday_calendar',
            'teacher_library',
          ],
          welcomeTitle: 'Teach with less friction',
          welcomeSubtitle:
              'Start from today’s class tasks, then move into grading, reviews, and student support.',
          dashboardTemplate: RoleDashboardTemplate.teaching,
          accentColor: Colors.orange,
        );
      case 'staff':
        return RoleShellConfig(
          role: 'Staff',
          homeItemId: 'staff_home',
          homeTitle: 'Operations Desk',
          homeIcon: Icons.work_outline,
          workbenchItemIds: [
            'staff_home',
            'officer_admissions',
            'billing_pos',
            'visitor_entry',
            'leave_management',
            'transport_ai_optimizer',
            'field_tracking',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'staff_home',
            'officer_admissions',
            'billing_pos',
            'visitor_entry',
            'field_tracking',
          ],
          defaultFavoriteItemIds: [
            'enquiry_pipeline',
            'visitor_book',
            'helpdesk',
            'notice_board',
            'field_tracking',
          ],
          focusItemIds: [
            'officer_admissions',
            'enquiry_pipeline',
            'billing_pos',
            'visitor_entry',
            'visitor_book',
            'field_tracking',
          ],
          quickAccessItemIds: [
            'leave_management',
            'helpdesk',
            'holiday_calendar',
            'notice_board',
            'field_tracking',
            'branches',
          ],
          welcomeTitle: 'Operational workbench',
          welcomeSubtitle:
              'Your workspace stays permission-aware and focused on the tasks you can act on today.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.blueGrey,
        );
      case 'transportmanager':
        return RoleShellConfig(
          role: 'TransportManager',
          homeItemId: 'admin_bus',
          homeTitle: 'Transport Desk',
          homeIcon: Icons.directions_bus,
          workbenchItemIds: [
            'admin_bus',
            'bus_fleet_management',
            'gps_device_management',
            'transport_ai_optimizer',
            'field_tracking',
            'notice_board',
          ],
          mobilePrimaryItemIds: [
            'admin_bus',
            'bus_fleet_management',
            'gps_device_management',
            'field_tracking',
          ],
          defaultFavoriteItemIds: [
            'admin_bus',
            'bus_fleet_management',
            'gps_device_management',
          ],
          focusItemIds: [
            'admin_bus',
            'bus_fleet_management',
            'gps_device_management',
          ],
          quickAccessItemIds: [
            'admin_bus',
            'bus_fleet_management',
            'gps_device_management',
          ],
          welcomeTitle: 'Transport operations',
          welcomeSubtitle:
              'Track vehicles, maintain fleet health, and keep GPS devices provisioned.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.amber,
        );
      case 'driver':
        return RoleShellConfig(
          role: 'Driver',
          homeItemId: 'field_tracking',
          homeTitle: 'Driver Tracking',
          homeIcon: Icons.person_pin_circle,
          workbenchItemIds: ['field_tracking', 'notice_board'],
          mobilePrimaryItemIds: ['field_tracking', 'notice_board'],
          defaultFavoriteItemIds: ['field_tracking'],
          focusItemIds: ['field_tracking'],
          quickAccessItemIds: ['field_tracking'],
          welcomeTitle: 'Driver tracking',
          welcomeSubtitle:
              'Start your duty session and share live route location from the mobile app.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.deepPurple,
        );
      case 'admissionofficer':
        return RoleShellConfig(
          role: 'AdmissionOfficer',
          homeItemId: 'admission_home',
          homeTitle: 'Admissions Desk',
          homeIcon: Icons.assignment_ind,
          workbenchItemIds: [
            'admission_home',
            'officer_admissions',
            'enquiry_pipeline',
            'seat_management',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'admission_home',
            'officer_admissions',
            'enquiry_pipeline',
            'seat_management',
          ],
          defaultFavoriteItemIds: [
            'helpdesk',
            'notice_board',
            'holiday_calendar',
          ],
          focusItemIds: [
            'officer_admissions',
            'enquiry_pipeline',
            'seat_management',
            'holiday_calendar',
          ],
          quickAccessItemIds: [
            'helpdesk',
            'notice_board',
            'notification_preferences',
          ],
          welcomeTitle: 'Manage the admissions funnel',
          welcomeSubtitle:
              'Move from enquiry to application to seat confirmation without hunting through modules.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.teal,
        );
      case 'accountant':
        return RoleShellConfig(
          role: 'Accountant',
          homeItemId: 'accountant_home',
          homeTitle: 'Finance Desk',
          homeIcon: Icons.account_balance_wallet,
          workbenchItemIds: [
            'accountant_home',
            'fee_dashboard',
            'billing_pos',
            'finance_ai_audit',
            'payroll_ai_audit',
            'voucher_entry',
            'daybook_report',
          ],
          mobilePrimaryItemIds: [
            'accountant_home',
            'fee_dashboard',
            'billing_pos',
            'voucher_entry',
          ],
          defaultFavoriteItemIds: [
            'fee_defaulters',
            'holiday_calendar',
            'notice_board',
          ],
          focusItemIds: [
            'fee_dashboard',
            'billing_pos',
            'voucher_entry',
            'daybook_report',
            'fee_defaulters',
          ],
          quickAccessItemIds: [
            'purchase_orders',
            'holiday_calendar',
            'notice_board',
          ],
          welcomeTitle: 'Track money movement clearly',
          welcomeSubtitle:
              'Collections, posting, and pending dues should feel like one connected finance flow.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.green,
        );
      case 'warden':
        return RoleShellConfig(
          role: 'Warden',
          homeItemId: 'warden_home',
          homeTitle: 'Hostel Desk',
          homeIcon: Icons.bedtime,
          workbenchItemIds: [
            'warden_home',
            'hostel_rooms',
            'hostel_occupancy',
            'hostel_ai_allotment',
            'laundry_admin',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'warden_home',
            'hostel_rooms',
            'hostel_occupancy',
            'laundry_admin',
          ],
          defaultFavoriteItemIds: ['notice_board', 'visitor_book', 'helpdesk'],
          focusItemIds: [
            'hostel_rooms',
            'hostel_occupancy',
            'laundry_admin',
            'notice_board',
          ],
          quickAccessItemIds: ['visitor_book', 'helpdesk', 'holiday_calendar'],
          welcomeTitle: 'Keep hostel operations steady',
          welcomeSubtitle:
              'Rooms, residents, notices, and support requests stay visible without switching contexts.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.brown,
        );
      case 'librarian':
        return RoleShellConfig(
          role: 'Librarian',
          homeItemId: 'librarian_home',
          homeTitle: 'Library Desk',
          homeIcon: Icons.local_library,
          workbenchItemIds: [
            'librarian_home',
            'library_checkout',
            'library_catalog',
            'library_footfall',
            'library_fines',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'librarian_home',
            'library_checkout',
            'library_catalog',
            'library_footfall',
            'library_fines',
          ],
          defaultFavoriteItemIds: [
            'notice_board',
            'helpdesk',
            'holiday_calendar',
          ],
          focusItemIds: [
            'library_checkout',
            'library_catalog',
            'library_footfall',
            'library_fines',
            'notice_board',
          ],
          quickAccessItemIds: [
            'helpdesk',
            'holiday_calendar',
            'notification_preferences',
          ],
          welcomeTitle: 'Run the library from one place',
          welcomeSubtitle:
              'Checkout, catalog maintenance, and visitor patterns stay grouped under one operational desk.',
          dashboardTemplate: RoleDashboardTemplate.specialistOps,
          accentColor: Colors.brown,
        );
      case 'superadmin':
        return RoleShellConfig(
          role: 'SuperAdmin',
          homeItemId: 'saas_dashboard',
          homeTitle: 'SaaS Command',
          homeIcon: Icons.rocket_launch,
          workbenchItemIds: [
            'saas_dashboard',
            'saas_schools',
            'saas_plans',
            'saas_billing_console',
            'saas_school_credentials',
            'super_admin_analytics',
            'report_studio_v2',
            'scheduled_bi_reports',
            'admin_audit_logs',
          ],
          mobilePrimaryItemIds: [
            'saas_dashboard',
            'saas_schools',
            'saas_plans',
            'saas_billing_console',
          ],
          defaultFavoriteItemIds: [
            'super_admin_analytics',
            'saas_billing_console',
            'admin_audit_logs',
          ],
          focusItemIds: [
            'saas_schools',
            'saas_plans',
            'saas_school_credentials',
            'saas_billing_console',
          ],
          quickAccessItemIds: [
            'super_admin_analytics',
            'report_studio_v2',
            'scheduled_bi_reports',
            'admin_audit_logs',
          ],
          welcomeTitle: 'Operate the platform at executive level',
          welcomeSubtitle:
              'School health, subscription control, and delivery operations live in one premium command surface.',
          dashboardTemplate: RoleDashboardTemplate.executive,
          accentColor: Colors.deepPurple,
        );
      case 'parent':
        return RoleShellConfig(
          role: 'Parent',
          homeItemId: 'parent_home',
          homeTitle: 'Family Desk',
          homeIcon: Icons.family_restroom,
          workbenchItemIds: [
            'parent_home',
            'ptm_parent',
            'helpdesk',
            'holiday_calendar',
            'notice_board',
          ],
          mobilePrimaryItemIds: [
            'parent_home',
            'ptm_parent',
            'holiday_calendar',
            'helpdesk',
          ],
          defaultFavoriteItemIds: [
            'gallery_user',
            'canteen_wallet_parent',
            'notification_preferences',
          ],
          focusItemIds: [
            'ptm_parent',
            'helpdesk',
            'holiday_calendar',
            'notice_board',
          ],
          quickAccessItemIds: [
            'gallery_user',
            'canteen_wallet_parent',
            'notification_preferences',
          ],
          welcomeTitle: 'Everything for your family in one place',
          welcomeSubtitle:
              'Stay close to children, calendar updates, and support actions without digging through menus.',
          dashboardTemplate: RoleDashboardTemplate.endUser,
          accentColor: Colors.indigo,
        );
      case 'alumni':
        return RoleShellConfig(
          role: 'Alumni',
          homeItemId: 'alumni_portal',
          homeTitle: 'Alumni Hub',
          homeIcon: Icons.groups,
          workbenchItemIds: ['alumni_portal', 'notification_preferences'],
          mobilePrimaryItemIds: ['alumni_portal', 'notification_preferences'],
          defaultFavoriteItemIds: ['notification_preferences'],
          focusItemIds: ['alumni_portal'],
          quickAccessItemIds: ['notification_preferences'],
          welcomeTitle: 'Reconnect with the institution',
          welcomeSubtitle:
              'Community updates and alumni actions should feel curated, not buried in a generic portal.',
          dashboardTemplate: RoleDashboardTemplate.endUser,
          accentColor: Colors.blue,
        );
      default:
        return RoleShellConfig(
          role: 'Student',
          homeItemId: 'student_home',
          homeTitle: 'Learning Home',
          homeIcon: Icons.home_rounded,
          workbenchItemIds: [
            'student_home',
            'timetable',
            'digital_locker',
            'assignments',
            'fees',
            'holiday_calendar',
          ],
          mobilePrimaryItemIds: [
            'student_home',
            'timetable',
            'digital_locker',
            'assignments',
            'fees',
          ],
          defaultFavoriteItemIds: [
            'digital_locker',
            'report_card',
            'attendance_history',
            'notice_board',
            'student_teachers',
          ],
          focusItemIds: [
            'assignments',
            'timetable',
            'report_card',
            'attendance_history',
            'fees',
          ],
          quickAccessItemIds: [
            'digital_locker',
            'holiday_calendar',
            'notice_board',
            'student_teachers',
            'chat',
          ],
          welcomeTitle: 'Start with what matters today',
          welcomeSubtitle:
              'Classes, assignments, attendance, and school updates stay visible from the first screen.',
          dashboardTemplate: RoleDashboardTemplate.endUser,
          accentColor: Colors.indigo,
        );
    }
  }

  /// Get theme color for a role
  static Color getRoleThemeColor(String role) {
    return getShellConfigForRole(role).accentColor;
  }

  /// Get role display name
  static String getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'staff':
        return 'Staff';
      case 'subadmin':
        return 'Sub-Admin';
      case 'admin':
        return 'Administrator';
      case 'schooladmin':
        return 'School Admin';
      case 'superadmin':
        return 'SaaS SuperAdmin';
      case 'teacher':
        return 'Teacher';
      case 'admissionofficer':
        return 'Admission Officer';
      case 'accountant':
        return 'Accountant';
      case 'warden':
        return 'Warden';
      case 'librarian':
        return 'Librarian';
      case 'hr':
        return 'HR';
      case 'transportmanager':
        return 'Transport Manager';
      case 'driver':
        return 'Driver';
      case 'parent':
        return 'Parent';
      case 'alumni':
        return 'Alumni';
      default:
        return 'Student';
    }
  }
}
