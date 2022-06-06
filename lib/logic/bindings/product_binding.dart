import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/cart_controller.dart';

import 'package:morgan_shop/logic/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.lazyPut(() => CartController());
  }
}
