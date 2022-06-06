import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../utils/themes.dart';

class BottomSheetWidget extends StatelessWidget {
  final String text;
  final String hint;
  final IconData icon;
  final String route;
  const BottomSheetWidget({
    Key? key,
    required this.text,
    required this.hint,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? pinkClr : mainColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: <Widget>[
          TextWidget(
            text: hint,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 16,
          ),
          TextButton(
            onPressed: () {
              Get.offNamed(route);
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  TextWidget(
                    text: text,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  Icon(
                    icon,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
