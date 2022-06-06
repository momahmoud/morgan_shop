import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/widgets/bottom_sheet_widget.dart';
import 'package:morgan_shop/view/widgets/button_widget.dart';
import 'package:morgan_shop/view/widgets/text_form_field_widget.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/my_string.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      authController.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        elevation: 0,
      ),
      bottomSheet: Container(
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: const BottomSheetWidget(
          text: 'Sign up',
          hint: 'Don\'t have an Account?',
          icon: Icons.arrow_forward,
          route: Routes.signUpScreen,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 20, bottom: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextWidget(
                  text: 'LOG ',
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? pinkClr : mainColor,
                  fontSize: 40,
                ),
                const SizedBox(
                  width: 1,
                ),
                TextWidget(
                  text: 'IN',
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormFieldWidget(
                    textInputType: TextInputType.emailAddress,
                    imageIcon: 'assets/images/email.png',
                    hint: 'Email',
                    validator: (value) {
                      if (!RegExp(validationEmail).hasMatch(value)) {
                        return 'Please, Enter valid email';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<AuthController>(
                    builder: (_) => TextFormFieldWidget(
                      suffixIcon: IconButton(
                          onPressed: () {
                            authController.toggleVisibility();
                          },
                          icon: Icon(
                            authController.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          )),
                      secureText: authController.isVisible ? false : true,
                      imageIcon: 'assets/images/lock.png',
                      hint: 'Password',
                      validator: (value) {
                        if (value.toString().length <= 6) {
                          return 'Password should be longer or equal to 6 characters';
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.forgetPasswordScreen);
                        },
                        child: TextWidget(
                          text: 'Forget Password?',
                          color: Get.isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Get.isDarkMode ? pinkClr : mainColor,
                          ),
                        ),
                        child: ImageIcon(
                          const AssetImage('assets/images/check.png'),
                          color: Get.isDarkMode ? pinkClr : mainColor,
                          size: 28,
                        ),
                      ),
                      TextWidget(
                        text: 'Remember me',
                        color: Get.isDarkMode ? Colors.white : Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<AuthController>(
                    builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          btnColor: Get.isDarkMode ? pinkClr : mainColor,
                          text: 'SIGN IN',
                          onPressed: _login,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: 'OR',
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GetBuilder<AuthController>(
                  builder: (_) => InkWell(
                    onTap: () {
                      authController.signInWithFacebook();
                    },
                    child: Image.asset(
                      'assets/images/facebook.png',
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GetBuilder<AuthController>(
                  builder: (_) => InkWell(
                    onTap: () {
                      authController.signInWithGoogle();
                    },
                    child: Image.asset(
                      'assets/images/google.png',
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
