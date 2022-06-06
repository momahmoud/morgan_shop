import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/auth_controller.dart';
import 'package:morgan_shop/utils/my_string.dart';
import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/widgets/bottom_sheet_widget.dart';
import 'package:morgan_shop/view/widgets/button_widget.dart';
import 'package:morgan_shop/view/widgets/text_form_field_widget.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../../routes/routes.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (authController.isChecked) {
        authController.signUpWithEmailAndPassword(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
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
          text: 'Log in',
          hint: 'Already have an Account?',
          icon: Icons.arrow_forward,
          route: Routes.loginScreen,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextWidget(
                  text: 'SIGN',
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? pinkClr : mainColor,
                  fontSize: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                TextWidget(
                  text: 'UP',
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormFieldWidget(
                    imageIcon: 'assets/images/user.png',
                    hint: 'Username',
                    validator: (value) {
                      if (value.toString().length <= 2 ||
                          !RegExp(validationName).hasMatch(value)) {
                        return 'Please, Enter valid name';
                      } else {
                        return null;
                      }
                    },
                    controller: _usernameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                      textInputType: TextInputType.visiblePassword,
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
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      GetBuilder<AuthController>(
                        builder: (_) => InkWell(
                          onTap: () {
                            authController.toggleChecked();
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            width: 40,
                            decoration: BoxDecoration(
                              color: authController.isChecked
                                  ? Get.isDarkMode
                                      ? pinkClr
                                      : mainColor
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.isDarkMode ? pinkClr : mainColor,
                              ),
                            ),
                            child: ImageIcon(
                              const AssetImage('assets/images/check.png'),
                              color: authController.isChecked
                                  ? Get.isDarkMode
                                      ? Colors.white
                                      : mainColor
                                  : pinkClr,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      TextWidget(
                        text: 'I accept ',
                        color: Get.isDarkMode ? Colors.white : Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      TextWidget(
                        text: 'terms & conditions',
                        color: Get.isDarkMode ? Colors.white : Colors.blueGrey,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        textDecoration: TextDecoration.underline,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<AuthController>(
                    builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: authController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: ButtonWidget(
                                btnColor: authController.isChecked
                                    ? Get.isDarkMode
                                        ? pinkClr
                                        : mainColor
                                    : Colors.grey,
                                text: 'SIGN UP',
                                onPressed: _signUp,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
