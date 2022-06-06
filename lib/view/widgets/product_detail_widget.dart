import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../logic/controllers/product_controller.dart';
import '../../utils/themes.dart';

class ProductDetailWidget extends StatelessWidget {
  final String title;
  final int id;
  ProductDetailWidget({Key? key, required this.title, required this.id})
      : super(key: key);

  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextWidget(
                  text: title,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Obx(
                () {
                  return InkWell(
                    onTap: () {
                      productController.addProductToFavorites(id);
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          Get.isDarkMode ? Colors.white : Colors.black,
                      radius: 20,
                      child: Icon(
                        productController.toggleFavorites(id)
                            ? CupertinoIcons.heart_solid
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
