import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/auth_controller.dart';
import 'package:morgan_shop/logic/controllers/settings_controller.dart';
import 'package:morgan_shop/logic/controllers/theme_controller.dart';
import 'package:morgan_shop/utils/my_string.dart';
import 'package:morgan_shop/utils/themes.dart';

import '../widgets/text_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  final settingsController = Get.find<SettingsController>();

  final String dropdownValue = 'Arabic 🇸🇦';

  // List of items in our dropdown menu
  final items = [
    'Arabic 🇸🇦',
    'English 🇺🇸',
    'French 🇫🇷',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: <Widget>[
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      // backgroundColor: Colors.deepPurple[500],
                      child: Image.asset(
                        authController.userPhoto.isEmpty
                            ? 'assets/images/user.png'
                            : authController.userPhoto.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextWidget(
                            text: settingsController.capitalizeFirstChar(
                                authController.currentUserName.value),
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextWidget(
                            text: authController.email.value,
                            color: Get.isDarkMode ? Colors.grey : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
          const SizedBox(
            height: 30,
          ),
          TextWidget(
            text: 'GENERAL'.tr,
            color: Get.isDarkMode ? pinkClr : mainColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 30,
          ),
          _buildListItems(
            color: darkSettings,
            title: 'Dark Mode'.tr,
            prefixIcon: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
            suffixIcon: Switch(
              activeColor: Get.isDarkMode ? pinkClr : mainColor,
              value: Get.isDarkMode ? true : false,
              onChanged: (_) {
                ThemeController().changeThemeMode();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _buildListItems(
              color: languageSettings,
              title: 'Language'.tr,
              prefixIcon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              suffixIcon: _languageDropdawnMenu()),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            customBorder: const StadiumBorder(),
            splashColor: Get.isDarkMode
                ? pinkClr.withOpacity(.3)
                : mainColor.withOpacity(.4),
            onTap: () {
              Get.defaultDialog(
                middleText: 'Are you sure?'.tr,
                title: 'Log Out'.tr,
                buttonColor: Get.isDarkMode ? pinkClr : mainColor,
                textCancel: 'No'.tr,
                textConfirm: 'Ok'.tr,
                cancelTextColor: Get.isDarkMode ? Colors.white : mainColor,
                barrierDismissible: true,
                onConfirm: () => authController.signOut(),
                onCancel: () => Get.back(),
              );
            },
            child: _buildListItems(
              color: logOutSettings,
              title: 'Logout'.tr,
              prefixIcon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              suffixIcon: Container(),
            ),
          ),
        ],
      ),
    );
  }

  _buildListItems({
    String? title,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color,
              child: prefixIcon,
            ),
            const SizedBox(
              width: 20,
            ),
            TextWidget(
              text: title!,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        suffixIcon!
      ],
    );
  }

  Widget _languageDropdawnMenu() {
    return GetBuilder<SettingsController>(
      builder: (_) {
        return Container(
          // width: 80,
          padding: const EdgeInsets.only(left: 15),
          height: 35,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
            color: Get.isDarkMode ? pinkClr : Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton(
            underline: Container(),
            borderRadius: BorderRadius.circular(20),
            elevation: 2,
            items: [
              DropdownMenuItem(
                child: Text(
                  english,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: ene,
              ),
              DropdownMenuItem(
                child: Text(
                  frence,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: fre,
              ),
              DropdownMenuItem(
                child: Text(
                  arabic,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: ara,
              ),
            ],
            value: settingsController.langLocal,
            onChanged: (String? value) {
              settingsController.changeLanguage(value!);
              Get.updateLocale(Locale(value));
            },
          ),
        );
      },
    );
  }
}
