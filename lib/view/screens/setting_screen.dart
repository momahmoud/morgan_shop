import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/theme_controller.dart';
import 'package:morgan_shop/utils/themes.dart';

import '../widgets/text_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget(
                text: 'Dark Mode',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              Switch(
                activeColor: Get.isDarkMode ? pinkClr : mainColor,
                value: Get.isDarkMode ? true : false,
                onChanged: (_) {
                  ThemeController().changeThemeMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
