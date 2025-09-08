import 'package:flutter/material.dart';

class PatientHomePage extends StatelessWidget {
  final String userName;
  final String userProfileImage;

  const PatientHomePage({
    super.key,
    this.userName = 'Sarah',
    this.userProfileImage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50
      body: Column(
        children: [
          // Header
          _buildHeader(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildServiceGrid(),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        50,
        16,
        16,
      ), // Added top padding for status bar
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
          // Profile section
          Row(
            children: [
              // Profile Image
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE5E7EB),
                  image: userProfileImage.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(userProfileImage),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: userProfileImage.isEmpty
                    ? const Icon(
                        Icons.person,
                        color: Color(0xFF6B7280),
                        size: 24,
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Welcome text
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

          // Menu button
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Color(0xFF6B7280),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid() {
    final services = [
      {
        'title': 'Video Consultation',
        'subtitle': 'Connect with a doctor',
        'icon': Icons.video_call,
        'color': const Color(0x1A22C55E), // primary-100 equivalent
        'iconColor': const Color(0xFF16A34A), // primary-600 equivalent
        'span': 1,
      },
      {
        'title': 'AI Chatbot',
        'subtitle': 'Check your symptoms',
        'icon': Icons.chat_bubble_outline,
        'color': const Color(0x1A22C55E),
        'iconColor': const Color(0xFF16A34A),
        'span': 1,
      },
      {
        'title': 'Doctors',
        'subtitle': 'Browse profiles',
        'icon': Icons.person_outline,
        'color': const Color(0x1A22C55E),
        'iconColor': const Color(0xFF16A34A),
        'span': 1,
      },
      {
        'title': 'Pharmacy Info',
        'subtitle': 'Find local pharmacies',
        'icon': Icons.local_pharmacy_outlined,
        'color': const Color(0x1A22C55E),
        'iconColor': const Color(0xFF16A34A),
        'span': 1,
      },
      {
        'title': 'Hospital Info',
        'subtitle': 'Available beds & emergency',
        'icon': Icons.local_hospital_outlined,
        'color': const Color(0x1AEFF6FF), // red-100 equivalent
        'iconColor': const Color(0xFFDC2626), // red-600
        'span': 2,
      },
    ];

    return Column(
      children: [
        // First row - 2x2 grid
        Row(
          children: [
            Expanded(child: _buildServiceCard(services[0])),
            const SizedBox(width: 16),
            Expanded(child: _buildServiceCard(services[1])),
          ],
        ),
        const SizedBox(height: 16),

        // Second row - 2x2 grid
        Row(
          children: [
            Expanded(child: _buildServiceCard(services[2])),
            const SizedBox(width: 16),
            Expanded(child: _buildServiceCard(services[3])),
          ],
        ),
        const SizedBox(height: 16),

        // Third row - full width
        _buildServiceCard(services[4]),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to respective service
        print('Tapped on ${service['title']}');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            const BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: service['color'],
                shape: BoxShape.circle,
              ),
              child: Icon(
                service['icon'],
                size: 32,
                color: service['iconColor'],
              ),
            ),

            // Title
            Text(
              service['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              service['subtitle'],
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
              _buildNavItem(icon: Icons.home, label: 'Home', isActive: true),
              _buildNavItem(
                icon: Icons.description_outlined,
                label: 'Records',
                isActive: false,
              ),
              _buildNavItem(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                isActive: false,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle navigation
        print('Tapped on $label');
      },
      child: Column(
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
              color: isActive
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
