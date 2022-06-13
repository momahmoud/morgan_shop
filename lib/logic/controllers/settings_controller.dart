import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/my_string.dart';

class SettingsController extends GetxController {
  var storage = GetStorage();
  var langLocal = ene;

  @override
  void onInit() async {
    langLocal = await getLanguageFromLocalStorage;
    super.onInit();
  }

  String capitalizeFirstChar(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  void saveLanguageToLocalStorage(String lang) async {
    await storage.write('lang', lang);
  }

  Future<String> get getLanguageFromLocalStorage async {
    return await storage.read('lang');
  }

  void changeLanguage(String language) {
    saveLanguageToLocalStorage(language);
    if (langLocal == language) {
      return;
    }
    if (language == fre) {
      langLocal = fre;
      saveLanguageToLocalStorage(fre);
    } else if (language == ara) {
      langLocal = ara;
      saveLanguageToLocalStorage(ara);
    } else {
      langLocal = ene;
      saveLanguageToLocalStorage(ene);
    }

    update();
  }
}
