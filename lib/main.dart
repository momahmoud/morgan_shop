import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:morgan_shop/languages/localiztion.dart';

import 'package:morgan_shop/logic/controllers/theme_controller.dart';
import 'package:morgan_shop/routes/routes.dart';
import 'package:morgan_shop/utils/my_string.dart';
import 'package:morgan_shop/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(ene),
      fallbackLocale: Locale(GetStorage().read<String>('lang').toString()),
      translations: LocaliztionApp(),
      title: 'Morgan Shop',
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      themeMode: ThemeController().getThemeMode,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? Routes.welcomeScreen
          : Routes.mainScreen,
      getPages: AppRoute.routes,

      // themeMode: Get.,
    );
  }
}
