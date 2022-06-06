import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/routes/routes.dart';
import 'package:morgan_shop/view/screens/cart_screen.dart';

import '../../model/product_model.dart';
import '../../utils/themes.dart';

class CartController extends GetxController {
  var productMap = {}.obs;

  get productSubTotal => productMap.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => productMap.entries
      .map((product) => product.key.price * product.value)
      //reduce to collect all element
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void addProductToCart(ProductModel productModel) {
    if (productMap.containsKey(productModel)) {
      productMap[productModel] += 1;
    } else {
      productMap[productModel] = 1;
    }
  }

  void removeProductFromCart(ProductModel productModel) {
    if (productMap.containsKey(productModel) && productMap[productModel] == 1) {
      productMap.removeWhere((key, value) => key == productModel);
    } else {
      productMap[productModel] -= 1;
    }
  }

  void clearOneProductFromCart(ProductModel productModel) {
    productMap.removeWhere((key, value) => key == productModel);
  }

  void clearAllProductsFromCart() {
    Get.defaultDialog(
      middleText: 'Are you sure?',
      title: 'Delete All Products',
      buttonColor: Get.isDarkMode ? pinkClr : mainColor,
      textCancel: 'No',
      textConfirm: 'Ok',
      cancelTextColor: Get.isDarkMode ? Colors.white : mainColor,
      barrierDismissible: true,
      onConfirm: () {
        productMap.clear();
        Get.back();
      },
      onCancel: () => Get.to(CartScreen()),
    );
  }

  int quantity() {
    return productMap.entries
        .map((product) => product.value)
        .toList()
        .reduce((value, element) => value + element);
  }
}
