import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/controllers/cart_controller.dart';
import '../../logic/controllers/product_controller.dart';
import '../../utils/themes.dart';
import 'text_form_field_widget.dart';

class SearchTextFieldWidget extends StatelessWidget {
  SearchTextFieldWidget({Key? key}) : super(key: key);

  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (context) {
        return Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                  height: 45,
                  child: TextFormField(
                    onChanged: (searchName) {
                      productController.searchProduct(searchName);
                    },
                    keyboardType: TextInputType.text,
                    controller: productController.searchEditingController,
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      suffixIcon:
                          productController.searchEditingController.text.isEmpty
                              ? null
                              : InkWell(
                                  onTap: () {
                                    productController.clearSearch();
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Get.isDarkMode ? pinkClr : mainColor,
                                    size: 30,
                                  ),
                                ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Get.isDarkMode ? pinkClr : mainColor,
                        size: 30,
                      ),
                      hintText: 'Search you\'re looking for',
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
                  )),
            ),
            IconButton(
              onPressed: () {
                productController.clearSearch();
              },
              icon: Icon(
                Icons.sort,
                color: Get.isDarkMode ? pinkClr : Colors.white,
                size: 40,
              ),
            ),
          ],
        );
      },
    );
  }
}
