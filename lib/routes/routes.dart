import 'package:get/get.dart';
import 'package:morgan_shop/logic/bindings/auth_binding.dart';
import 'package:morgan_shop/logic/bindings/cart_binding.dart';
import 'package:morgan_shop/logic/bindings/main_binding.dart';
import 'package:morgan_shop/logic/bindings/product_binding.dart';

import 'package:morgan_shop/view/screens/auth/forget_password_screen.dart';
import 'package:morgan_shop/view/screens/auth/login_screen.dart';
import 'package:morgan_shop/view/screens/auth/signup_screen.dart';
import 'package:morgan_shop/view/screens/cart_screen.dart';
import 'package:morgan_shop/view/screens/main_screen.dart';

import '../view/screens/welcome_screen.dart';

class AppRoute {
  static final routes = [
    GetPage(
      name: '/welcomeScreen',
      page: () => const WelcomeScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: '/loginScreen',
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: '/signUpScreen',
      page: () => SignUpScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: '/forgetPasswordScreen',
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        ProductBinding(),
        AuthBinding(),
        MainBinding(),
      ],
      transition: Transition.leftToRight,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => CartScreen(),
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      transition: Transition.leftToRight,
      transitionDuration: const Duration(seconds: 2),
    ),
  ];
}

class Routes {
  static const welcomeScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static const mainScreen = '/mainScreen';
  static const cartScreen = '/cartScreen';
}
