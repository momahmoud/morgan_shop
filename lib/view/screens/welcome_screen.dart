import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:morgan_shop/routes/routes.dart';
import 'package:morgan_shop/utils/themes.dart';

import 'package:morgan_shop/view/widgets/text_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 60,
                    width: 230,
                    child: const TextWidget(
                      text: 'Welcome',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 60,
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        TextWidget(
                          text: 'Morgan',
                          fontWeight: FontWeight.w500,
                          color: mainColor,
                          fontSize: 40,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        TextWidget(
                          text: 'Shop',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  SizedBox(
                    width: 170,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          primary: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      onPressed: () {
                        Get.offNamed(Routes.loginScreen);
                      },
                      child: const TextWidget(
                        text: 'Get Start',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const TextWidget(
                        text: 'Don\'t have an Account?',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.signUpScreen);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: const <Widget>[
                              TextWidget(
                                text: 'Sign Up',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: mainColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
