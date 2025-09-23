import 'package:flutter/material.dart';
import '../../patient/pages/patient_home_page.dart';
import '../../doctor/pages/doctor_home_page.dart';
import '../../hospital_staff/pages/hospital_staff_home_page.dart';
import '../../pharmacist/pages/pharmacist_home_page.dart';
import '../../../core/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedRole;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _formSectionKey = GlobalKey();

  final List<Map<String, dynamic>> roles = [
    {
      'id': 'patient',
      'title': 'Patient',
      'subtitle': 'Medical care for individuals',
      'icon': Icons.person,
    },
    {
      'id': 'doctor',
      'title': 'Doctor',
      'subtitle': 'Licensed medical professionals',
      'icon': Icons.medical_services,
    },
    {
      'id': 'hospital_staff',
      'title': 'Hospital Staff',
      'subtitle': 'Admin & support staff',
      'icon': Icons.business_center, // Better icon for hospital staff
    },
    {
      'id': 'pharmacist',
      'title': 'Pharmacist',
      'subtitle': 'Dispensing medications',
      'icon': Icons.local_pharmacy, // Better icon for pharmacist
    },
  ];

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _scrollController.dispose();
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
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Subtitle
                    const Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join Sehat Sathi to access healthcare services.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 24),

                    // Role Selection Grid
                    _buildRoleGrid(),
                    const SizedBox(height: 24),

                    // Registration Form
                    Container(
                      key: _formSectionKey,
                      child: _buildRegistrationForm(),
                    ),
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
        children: [
          // Back Button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          ),
          const SizedBox(width: 8),

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
                'Sehat Sathi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your role',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0, // Make cards more square
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
                // Add auto-scroll functionality
                Future.delayed(const Duration(milliseconds: 200), () {
                  _scrollToRegistrationForm();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFEA2A33)
                        : const Color(0xFFE5E7EB),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: isSelected
                      ? const Color(0xFFEA2A33).withOpacity(0.05)
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? const Color(0xFFEA2A33).withOpacity(0.15)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isSelected ? 8 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon Background Container
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEA2A33).withOpacity(0.1)
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              role['icon'],
                              size: 24,
                              color: isSelected
                                  ? const Color(0xFFEA2A33)
                                  : const Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            role['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFFEA2A33)
                                  : const Color(0xFF111827),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            role['subtitle'],
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? const Color(0xFFEA2A33).withOpacity(0.8)
                                  : const Color(0xFF6B7280),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: 'Full Name',
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF6B7280),
              ),
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
                return 'Please enter your full name';
              }
              if (value.length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email Field
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email Address',
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF6B7280),
              ),
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
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone Field
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: Color(0xFF6B7280),
              ),
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
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Phone number must be at least 10 digits';
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
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF6B7280),
              ),
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
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password Field
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF6B7280),
              ),
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
                return 'Please confirm your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Register Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA2A33),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Login Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Login',
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

  void _scrollToRegistrationForm() {
    Future.delayed(const Duration(milliseconds: 100), () {
      // Try ensureVisible approach first
      if (_formSectionKey.currentContext != null) {
        try {
          Scrollable.ensureVisible(
            _formSectionKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            alignment: 0.3, // Show form in lower part of screen
          );
          return;
        } catch (e) {
          // Fallback to scroll controller if ensureVisible fails
        }
      }

      // Fallback approach using scroll controller
      if (_scrollController.hasClients) {
        try {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent * 0.7,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } catch (e) {
          // Ignore scroll errors
        }
      }
    });
  }

  Future<void> _handleRegister() async {
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
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFFEA2A33)),
        ),
      );

      try {
        // Save user to local storage
        bool success = await UserService.registerUser(
          name: fullNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          role: selectedRole!,
        );

        // Dismiss loading dialog
        if (mounted) Navigator.pop(context);

        if (success) {
          // Show success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Account created successfully as ${selectedRole!.replaceAll('_', ' ')}!',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }

          // Navigate to appropriate home page based on role
          _navigateToRoleHomePage();
        } else {
          // User already exists
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'User with this email already exists. Please use a different email.',
                ),
                backgroundColor: Color(0xFFEA2A33),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      } catch (e) {
        // Dismiss loading dialog
        if (mounted) Navigator.pop(context);

        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${e.toString()}'),
              backgroundColor: Color(0xFFEA2A33),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  void _navigateToRoleHomePage() {
    String userName = fullNameController.text;
    String userEmail = emailController.text;

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
