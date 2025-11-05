import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/resources/assets/images/images.dart';
import 'package:github_restapi/resources/utils/responsive.dart';
import 'package:github_restapi/theme/app_colors.dart';
import 'package:github_restapi/theme/app_text_style.dart';
import 'package:github_restapi/views/auth/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.off(() => const LoginView());
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Responsive.h(15)),
            Icon(
              Icons.code,
              size: 80,
              color: AppColors.primary,
            ),
            SizedBox(height: Responsive.h(0.3)),
            Text(
              'Github Explorer',
              style: AppTextStyles.h2,
            ),
            SizedBox(height: Responsive.h(20)),
            AnimatedBuilder(
              animation: _c,
              child: Image.asset(Images.loadingImage),
              builder:
                  (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _c.value * 2 * math.pi,
                      child: child,
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
