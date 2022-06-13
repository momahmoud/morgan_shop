import 'package:get/get.dart';

import 'package:morgan_shop/logic/controllers/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
  }
}
