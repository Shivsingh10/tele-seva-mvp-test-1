import 'package:flutter/material.dart';
import 'patient_profile_page.dart';
import '../../auth/pages/common_login.dart';
import '../../../core/widgets/user_count_widget.dart';
import '../../health_services/pages/emergency_call_page.dart';
import '../../health_services/pages/book_appointment_page.dart';
import '../../health_services/pages/video_consultation_page.dart';
import '../../health_services/pages/ai_health_assistant_page.dart';
import '../../health_services/pages/find_doctors_page.dart';
import '../../health_services/pages/pharmacy_locator_page.dart';
import '../../health_services/pages/health_records_page.dart';
import '../../health_services/pages/hospital_info_page.dart';

class PatientHomePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const PatientHomePage({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Statistics Dashboard
                  const UserCountDashboard(showTotal: true),
                  const SizedBox(height: 24),
                  _buildQuickActions(),
                  const SizedBox(height: 24),
                  _buildHealthServices(),
                  const SizedBox(height: 24),
                  _buildRecentActivity(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE5E7EB),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF6B7280),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientProfilePage(
                        userName: userName,
                        userEmail: userEmail,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF6B7280),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF6B7280),
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showLogoutDialog(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA2A33).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Color(0xFFEA2A33),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Emergency Call',
                '🚨',
                const Color(0xFFDC2626),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyCallPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'Book Appointment',
                '📅',
                const Color(0xFF16A34A),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookAppointmentPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthServices() {
    final services = [
      {
        'title': 'Video Consultation',
        'subtitle': 'Connect with doctors',
        'icon': Icons.video_call,
        'color': const Color(0xFF16A34A),
      },
      {
        'title': 'AI Health Assistant',
        'subtitle': 'Check your symptoms',
        'icon': Icons.chat_bubble_outline,
        'color': const Color(0xFF2563EB),
      },
      {
        'title': 'Find Doctors',
        'subtitle': 'Browse specialists',
        'icon': Icons.person_search,
        'color': const Color(0xFF7C3AED),
      },
      {
        'title': 'Pharmacy Locator',
        'subtitle': 'Find medicines nearby',
        'icon': Icons.local_pharmacy,
        'color': const Color(0xFFEA580C),
      },
      {
        'title': 'Health Records',
        'subtitle': 'Your medical history',
        'icon': Icons.folder_outlined,
        'color': const Color(0xFF0891B2),
      },
      {
        'title': 'Hospital Info',
        'subtitle': 'Beds & emergency services',
        'icon': Icons.local_hospital,
        'color': const Color(0xFFDC2626),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Health Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return _buildServiceCard(
              service['title'] as String,
              service['subtitle'] as String,
              service['icon'] as IconData,
              service['color'] as Color,
              () {
                switch (service['title']) {
                  case 'Video Consultation':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideoConsultationPage(),
                      ),
                    );
                    break;
                  case 'AI Health Assistant':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AIHealthAssistantPage(),
                      ),
                    );
                    break;
                  case 'Find Doctors':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FindDoctorsPage(),
                      ),
                    );
                    break;
                  case 'Pharmacy Locator':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PharmacyLocatorPage(),
                      ),
                    );
                    break;
                  case 'Health Records':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthRecordsPage(),
                      ),
                    );
                    break;
                  case 'Hospital Info':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HospitalInfoPage(),
                      ),
                    );
                    break;
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          'Video consultation with Dr. Sharma',
          'Yesterday, 3:30 PM',
          Icons.video_call,
          const Color(0xFF16A34A),
        ),
        _buildActivityItem(
          'Prescription uploaded',
          '2 days ago',
          Icons.receipt_long,
          const Color(0xFF2563EB),
        ),
        _buildActivityItem(
          'Health checkup reminder',
          '1 week ago',
          Icons.schedule,
          const Color(0xFFEA580C),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String emoji,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', true),
              _buildNavItem(
                Icons.calendar_today_outlined,
                'Appointments',
                false,
              ),
              _buildNavItem(Icons.folder_outlined, 'Records', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? const Color(0xFF16A34A) : const Color(0xFF6B7280),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFF16A34A) : const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CommonLoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA2A33),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
