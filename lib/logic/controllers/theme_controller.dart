import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  final GetStorage boxStorage = GetStorage();
  final themeKey = 'isDarkMode';

  Future<void> saveThemeDataInBoxStorage(bool isDark) async {
    return await boxStorage.write(themeKey, isDark);
  }

  bool getThemeDataFromBoxStorage() {
    return boxStorage.read<bool>(themeKey) ?? false;
  }

  ThemeMode get getThemeMode =>
      getThemeDataFromBoxStorage() ? ThemeMode.dark : ThemeMode.light;

  changeThemeMode() async {
    Get.changeThemeMode(
        getThemeDataFromBoxStorage() ? ThemeMode.light : ThemeMode.dark);
    saveThemeDataInBoxStorage(!getThemeDataFromBoxStorage());
  }
}
