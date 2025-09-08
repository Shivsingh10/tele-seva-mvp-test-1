import 'package:flutter/material.dart';
import '../../patient/pages/patient_home_page.dart';
import '../../doctor/pages/doctor_home_page.dart';
import '../../hospital_staff/pages/hospital_staff_home_page.dart';
import '../../pharmacist/pages/pharmacist_home_page.dart';

class CommonLoginPage extends StatefulWidget {
  const CommonLoginPage({super.key});

  @override
  State<CommonLoginPage> createState() => _CommonLoginPageState();
}

class _CommonLoginPageState extends State<CommonLoginPage> {
  String? selectedRole;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> roles = [
    {
      'id': 'patient',
      'title': 'Patient',
      'subtitle': 'Medical care for individuals',
      'icon': Icons.person,
      'image':
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=300&fit=crop',
    },
    {
      'id': 'doctor',
      'title': 'Doctor',
      'subtitle': 'Licensed medical professionals',
      'icon': Icons.medical_services,
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=300&fit=crop',
    },
    {
      'id': 'hospital_staff',
      'title': 'Hospital Staff',
      'subtitle': 'Admin & support staff',
      'icon': Icons.local_hospital,
      'image':
          'https://images.unsplash.com/photo-1631815589968-fdb09a223b1e?w=400&h=300&fit=crop',
    },
    {
      'id': 'pharmacist',
      'title': 'Pharmacist',
      'subtitle': 'Dispensing medications',
      'icon': Icons.medication,
      'image':
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=300&fit=crop',
    },
  ];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Subtitle
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please select your role to continue.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 32),

                    // Role Selection Grid
                    _buildRoleGrid(),
                    const SizedBox(height: 32),

                    // Login Form
                    _buildLoginForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFEA2A33),
                  size: 24,
                ),
              ),
              const Text(
                'TeleHealth',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          // Language Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language, size: 16, color: Color(0xFF6B7280)),
                SizedBox(width: 4),
                Text(
                  'EN',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio:
            0.75, // Changed from 0.85 to 0.75 (makes cards taller)
      ),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        final isSelected = selectedRole == role['id'];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedRole = role['id'];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFEA2A33)
                    : const Color(0xFFE5E7EB),
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12), // Reduced from 16 to 12
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center content
                    children: [
                      // Role Image/Icon
                      Container(
                        height: 70, // Reduced from 80 to 70
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF3F4F6),
                        ),
                        child: Icon(
                          role['icon'],
                          size: 36, // Reduced from 40 to 36
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced from 12 to 8
                      // Role Title
                      Text(
                        role['title'],
                        style: const TextStyle(
                          fontSize: 14, // Reduced from 16 to 14
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1, // Prevent text overflow
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2), // Reduced from 4 to 2
                      // Role Subtitle
                      Flexible(
                        // Wrap with Flexible to prevent overflow
                        child: Text(
                          role['subtitle'],
                          style: const TextStyle(
                            fontSize: 11, // Reduced from 12 to 11
                            color: Color(0xFF6B7280),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2, // Allow 2 lines for subtitle
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection Indicator
                if (isSelected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEA2A33),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email/Phone Field
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email or Phone',
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFEA2A33)),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email or phone';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFEA2A33)),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Handle forgot password
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFFEA2A33),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA2A33),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Sign Up Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to sign up
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xFFEA2A33),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your role'),
          backgroundColor: Color(0xFFEA2A33),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual login logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logging in as $selectedRole...'),
          backgroundColor: const Color(0xFFEA2A33),
        ),
      );

      // Navigate to appropriate home page based on role
      _navigateToRoleHomePage();
    }
  }

  void _navigateToRoleHomePage() {
    // Extract user name from email/phone for demo purposes
    String userName = emailController.text.split('@')[0];
    if (userName.isEmpty) {
      userName = 'User';
    }

    String userEmail = emailController.text.isEmpty
        ? 'user@example.com'
        : emailController.text;

    // Navigate to role-specific home pages
    switch (selectedRole) {
      case 'patient':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PatientHomePage(userName: userName, userEmail: userEmail),
          ),
        );
        break;
      case 'doctor':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DoctorHomePage(userName: 'Dr. $userName', userEmail: userEmail),
          ),
        );
        break;
      case 'hospital_staff':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HospitalStaffHomePage(userName: userName, userEmail: userEmail),
          ),
        );
        break;
      case 'pharmacist':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PharmacistHomePage(userName: userName, userEmail: userEmail),
          ),
        );
        break;
    }
  }
}
