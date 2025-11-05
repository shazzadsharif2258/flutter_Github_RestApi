import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/resources/components/custom_button.dart';
import 'package:github_restapi/resources/components/label_field.dart';
import 'package:github_restapi/resources/utils/responsive.dart';
import 'package:github_restapi/theme/app_colors.dart';
import 'package:github_restapi/viewModel/login_controller.dart';
import 'package:github_restapi/viewModel/theme_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final userName = TextEditingController();
  final focusNode = FocusNode();
  final _c = Get.find<ThemeController>();
  final auth = Get.put(LoginController());

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final horizontalPadding = Responsive.isTablet
        ? 32.0
        : 24.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Github Expolrer'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                _c.toggleTheme();
              },
              icon: _c.isDarkMode.value
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.brightness_6),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            Responsive.h(0.2),
            horizontalPadding,
            Responsive.h(20),
          ),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: AppColors.primaryDeep,
                ),
                SizedBox(height: Responsive.h(0.5)),
                Text(
                  'Enter Github Username',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.h(3)),

                LabeledField(
                  controller: userName,
                  hint: 'username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.h(3)),
                CustomButton(
                  loading: false,
                  title: 'Serach',
                  height: 56,
                  width: double.infinity,
                  textColor: Colors.white,
                  filled: true,
                  onPress: () {
                    if (!_formkey.currentState!
                        .validate()) {
                      return;
                    }
                    auth.getUser(userName.text.trim());
                    print(userName.text.trim());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
