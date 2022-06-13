import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/auth_controller.dart';

import 'package:morgan_shop/logic/controllers/main_controller.dart';
import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/screens/cart_screen.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../logic/controllers/cart_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final authController = Get.find<AuthController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          actions: [
            if (mainController.currentIndex.value != 3) _shoppingCartBadge(),
          ],
          title: TextWidget(
            text: mainController.appBarTitle[mainController.currentIndex.value],
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          centerTitle: true,
          backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:
              Get.isDarkMode ? Colors.grey[300] : Colors.grey[700],
          selectedItemColor: Get.isDarkMode ? pinkClr : mainColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart_fill,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: '',
            ),
          ],
          currentIndex: mainController.currentIndex.value,
          onTap: (index) {
            mainController.currentIndex.value = index;
          },
        ),
        body: IndexedStack(
          index: mainController.currentIndex.value,
          children: mainController.tabs,
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        cartController.productMap.isEmpty
            ? "0"
            : cartController.quantity().toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Get.isDarkMode ? pinkClr : Colors.white,
            size: 35,
          ),
          onPressed: () {
            Get.to(() => CartScreen());
          }),
    );
  }
}
