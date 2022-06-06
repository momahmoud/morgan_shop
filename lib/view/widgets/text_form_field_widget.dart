import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/themes.dart';

class TextFormFieldWidget extends StatelessWidget {
  final dynamic imageIcon;
  final String hint;
  final TextEditingController controller;
  final Function validator;
  final bool secureText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextInputType? textInputType;

  const TextFormFieldWidget({
    Key? key,
    this.imageIcon,
    required this.hint,
    required this.controller,
    required this.validator,
    this.secureText = false,
    this.suffixIcon,
    this.textInputType,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: secureText,
      validator: (String? val) => validator(val),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon == null
            ? ImageIcon(
                AssetImage(
                  imageIcon,
                ),
                color: Get.isDarkMode ? pinkClr : mainColor,
              )
            : prefixIcon,
        hintText: hint,
        hintStyle: GoogleFonts.workSans(
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
