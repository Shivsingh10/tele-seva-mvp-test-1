import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserCountWidget extends StatefulWidget {
  final String? specificRole; // If null, shows total count
  final String? title; // Custom title for the widget
  final IconData? icon; // Custom icon
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final bool showIcon;
  final bool showTitle;
  final double? width;
  final double? height;

  const UserCountWidget({
    super.key,
    this.specificRole,
    this.title,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.showIcon = true,
    this.showTitle = true,
    this.width,
    this.height,
  });

  @override
  State<UserCountWidget> createState() => _UserCountWidgetState();
}

class _UserCountWidgetState extends State<UserCountWidget> {
  Map<String, int> userCounts = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserCounts();
  }

  Future<void> _loadUserCounts() async {
    try {
      final counts = await UserService.getUserCounts();
      if (mounted) {
        setState(() {
          userCounts = counts;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user counts: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Refresh counts - can be called from parent widgets
  Future<void> refresh() async {
    await UserService.refreshUserCounts();
    await _loadUserCounts();
  }

  String _getTitle() {
    if (widget.title != null) return widget.title!;

    if (widget.specificRole != null) {
      switch (widget.specificRole) {
        case 'patient':
          return 'Patients';
        case 'doctor':
          return 'Doctors';
        case 'hospital_staff':
          return 'Staff Members';
        case 'pharmacist':
          return 'Pharmacists';
        default:
          return 'Users';
      }
    }
    return 'Total Users';
  }

  IconData _getIcon() {
    if (widget.icon != null) return widget.icon!;

    if (widget.specificRole != null) {
      switch (widget.specificRole) {
        case 'patient':
          return Icons.people;
        case 'doctor':
          return Icons.medical_services;
        case 'hospital_staff':
          return Icons.business_center;
        case 'pharmacist':
          return Icons.local_pharmacy;
        default:
          return Icons.group;
      }
    }
    return Icons.groups;
  }

  int _getCount() {
    if (widget.specificRole != null) {
      return userCounts[widget.specificRole] ?? 0;
    }
    return userCounts['total'] ?? 0;
  }

  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    if (widget.specificRole != null) {
      switch (widget.specificRole) {
        case 'patient':
          return Colors.blue.shade50;
        case 'doctor':
          return Colors.green.shade50;
        case 'hospital_staff':
          return Colors.purple.shade50;
        case 'pharmacist':
          return Colors.orange.shade50;
        default:
          return Colors.grey.shade50;
      }
    }
    return Colors.red.shade50; // Healthcare theme
  }

  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    if (widget.specificRole != null) {
      switch (widget.specificRole) {
        case 'patient':
          return Colors.blue.shade600;
        case 'doctor':
          return Colors.green.shade600;
        case 'hospital_staff':
          return Colors.purple.shade600;
        case 'pharmacist':
          return Colors.orange.shade600;
        default:
          return Colors.grey.shade600;
      }
    }
    return const Color(0xFFEA2A33); // Healthcare red
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;
    return Colors.grey.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 160,
      height: widget.height ?? 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getIconColor().withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_getIconColor()),
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showIcon)
                  Icon(_getIcon(), size: 32, color: _getIconColor()),
                if (widget.showIcon) const SizedBox(height: 8),
                Text(
                  _getCount().toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                  ),
                ),
                if (widget.showTitle) const SizedBox(height: 4),
                if (widget.showTitle)
                  Text(
                    _getTitle(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTextColor().withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
    );
  }
}

// Predefined widgets for common use cases
class PatientCountWidget extends StatelessWidget {
  const PatientCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserCountWidget(specificRole: 'patient');
  }
}

class DoctorCountWidget extends StatelessWidget {
  const DoctorCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserCountWidget(specificRole: 'doctor');
  }
}

class HospitalStaffCountWidget extends StatelessWidget {
  const HospitalStaffCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserCountWidget(specificRole: 'hospital_staff');
  }
}

class PharmacistCountWidget extends StatelessWidget {
  const PharmacistCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserCountWidget(specificRole: 'pharmacist');
  }
}

class TotalUserCountWidget extends StatelessWidget {
  const TotalUserCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserCountWidget(); // Shows total count
  }
}

// Dashboard row widget showing all user types
class UserCountDashboard extends StatefulWidget {
  final double spacing;
  final bool showTotal;

  const UserCountDashboard({
    super.key,
    this.spacing = 12,
    this.showTotal = true,
  });

  @override
  State<UserCountDashboard> createState() => _UserCountDashboardState();
}

class _UserCountDashboardState extends State<UserCountDashboard> {
  final List<GlobalKey<_UserCountWidgetState>> _widgetKeys = [
    GlobalKey<_UserCountWidgetState>(),
    GlobalKey<_UserCountWidgetState>(),
    GlobalKey<_UserCountWidgetState>(),
    GlobalKey<_UserCountWidgetState>(),
    GlobalKey<_UserCountWidgetState>(),
  ];

  Future<void> refreshAllCounts() async {
    for (var key in _widgetKeys) {
      key.currentState?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with refresh button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            IconButton(
              onPressed: refreshAllCounts,
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh Counts',
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Count widgets grid
        Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          children: [
            UserCountWidget(key: _widgetKeys[0], specificRole: 'patient'),
            UserCountWidget(key: _widgetKeys[1], specificRole: 'doctor'),
            UserCountWidget(
              key: _widgetKeys[2],
              specificRole: 'hospital_staff',
            ),
            UserCountWidget(key: _widgetKeys[3], specificRole: 'pharmacist'),
            if (widget.showTotal) UserCountWidget(key: _widgetKeys[4]),
          ],
        ),
      ],
    );
  }
}
