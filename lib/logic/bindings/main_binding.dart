import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/main_controller.dart';
import 'package:morgan_shop/logic/controllers/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
    Get.put(MainController());
  }
}
