import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../utils/my_string.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_form_field_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  void _send() {
    if (_formKey.currentState!.validate()) {
      authController.resetPassword(email: _emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? pinkClr : Colors.black,
        ),
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        title: TextWidget(
          text: 'Forget Password',
          color: Get.isDarkMode ? pinkClr : Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 400,
              child: TextWidget(
                textAlign: TextAlign.center,
                text:
                    'if you want to recover your account, then please provide your email below',
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black54,
                fontSize: 17,
              ),
            ),
            Image.asset(
              'assets/images/forgetpass.png',
              height: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: _formKey,
              child: TextFormFieldWidget(
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
            ),
            const SizedBox(
              height: 50,
            ),
            GetBuilder<AuthController>(
              builder: (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    btnColor: Get.isDarkMode ? pinkClr : mainColor,
                    text: 'SEND',
                    onPressed: _send,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
