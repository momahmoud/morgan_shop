import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:morgan_shop/view/screens/cart_screen.dart';

import '../../model/product_model.dart';
import '../../utils/themes.dart';

class CartController extends GetxController {
  RxMap productMap = {}.obs;
  RxBool isAddingToCart = false.obs;
  var localStorage = GetStorage();

  @override
  void onInit() {
    List? storageProducts = localStorage.read<List<dynamic>>('isAddingToCart');
    if (storageProducts != null) {
      productMap = storageProducts
          .map((e) => ProductModel.fromJson(e))
          .toList()
          .obs as RxMap;
    }

    super.onInit();
  }

  get productSubTotal => productMap.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => productMap.entries
      .map((product) => product.key.price * product.value)
      //reduce to collect all element
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void addProductToCart(ProductModel productModel) async {
    if (productMap.containsKey(productModel)) {
      productMap[productModel] += 1;
      await localStorage.write('isAddingToCart', productMap.values);
    } else {
      productMap[productModel] = 1;
      await localStorage.write('isAddingToCart', productMap);
    }
  }

  void removeProductFromCart(ProductModel productModel) {
    if (productMap.containsKey(productModel) && productMap[productModel] == 1) {
      productMap.removeWhere((key, value) => key == productModel);
      localStorage.remove('isAddingToCart');
    } else {
      productMap[productModel] -= 1;
    }
  }

  void clearOneProductFromCart(ProductModel productModel) {
    productMap.removeWhere((key, value) => key == productModel);
    localStorage.remove('isAddingToCart');
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
        localStorage.remove('isAddingToCart');
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
