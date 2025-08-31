import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _dotsController;
  late Animation<double> _fadeAnimation;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation for main content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Dots animation
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _dotsAnimation = IntTween(
      begin: 0,
      end: 2,
    ).animate(CurvedAnimation(parent: _dotsController, curve: Curves.linear));

    // Start animations
    _fadeController.forward();
    _dotsController.repeat();

    // Navigate to next screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // TODO: Navigate to login page
        // Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Icon
                    Container(
                      width: 96,
                      height: 96,
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 77, 42, 234), // Primary red color
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),

                    // App Title
                    const Text(
                      'NABHA-SEVA',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827), // text-gray-900
                        letterSpacing: -0.5,
                      ),
                    ),

                    // Subtitle
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                      child: Text(
                        'Connecting you to care, anytime, anywhere.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280), // text-gray-600
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom indicator dots
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 16),
              child: AnimatedBuilder(
                animation: _dotsAnimation,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _dotsAnimation.value == index
                              ? const Color(0xFFEA2A33) // Primary red
                              : const Color(0xFFD1D5DB), // gray-300
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
