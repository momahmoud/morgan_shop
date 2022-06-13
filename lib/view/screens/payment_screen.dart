import 'package:flutter/material.dart';
import 'package:morgan_shop/logic/controllers/cart_controller.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../utils/themes.dart';
import '../widgets/payment/delivery_continer_widget.dart';
import '../widgets/payment/payment_method_widget.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.transparent : mainColor,
        elevation: 0,
        title: const TextWidget(
          text: 'Payment',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            TextWidget(
              text: 'Shipping to',
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 22,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const DeliveryContinerWidget(),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              text: "Payment method",
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            const PayMentMethodWidget(),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: TextWidget(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                text: "Total: ${cartController.total}\$",
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    primary: Get.isDarkMode ? pinkClr : mainColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _choiceCard(String title) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          RadioListTile(
            value: true,
            groupValue: 'groupValue',
            onChanged: (value) {},
            title: TextWidget(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
