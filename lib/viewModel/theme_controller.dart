import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  final _box = GetStorage();
  @override
  void onInit() {
    isDarkMode.value = _box.read('isDark') ?? false;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
    super.onInit();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
