import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/themes.dart';
import 'text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final Color? btnColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextWidget(
        text: text,
        fontWeight: FontWeight.w500,
        color: textColor,
        fontSize: 25,
      ),
    );
  }
}
