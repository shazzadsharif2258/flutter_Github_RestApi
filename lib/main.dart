import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/theme/app_theme.dart';
import 'package:github_restapi/viewModel/theme_controller.dart';
import 'package:github_restapi/views/auth/login_view.dart';
import 'package:github_restapi/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: LoginView(),
    );
  }
}
