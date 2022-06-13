import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/view/screens/category_screen.dart';
import 'package:morgan_shop/view/screens/favourite_screen.dart';
import 'package:morgan_shop/view/screens/home_screen.dart';
import 'package:morgan_shop/view/screens/setting_screen.dart';

class MainController {
  RxInt currentIndex = 0.obs;
  RxList<Widget> tabs = <Widget>[
    HomeScreen(),
    const CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ].obs;
  RxList<String> appBarTitle = const <String>[
    "Morgan Shop",
    "Categories",
    "Favorites",
    "Settings",
  ].obs;
}
