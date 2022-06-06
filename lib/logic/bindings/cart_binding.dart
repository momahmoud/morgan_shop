import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
