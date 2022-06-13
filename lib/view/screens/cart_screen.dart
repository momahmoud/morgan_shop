import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/view/screens/main_screen.dart';
import 'package:morgan_shop/view/screens/payment_screen.dart';

import '../../logic/controllers/cart_controller.dart';
import '../../logic/controllers/product_controller.dart';

import '../../utils/themes.dart';
import '../widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final cartController = Get.find<CartController>();
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomSheetContainer(),
      appBar: AppBar(
        title: const TextWidget(
          text: 'Cart Items',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        actions: [
          cartController.productMap.isEmpty
              ? Container()
              : IconButton(
                  onPressed: () {
                    cartController.clearAllProductsFromCart();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Get.isDarkMode ? Colors.red[600] : Colors.white,
                    size: 30,
                  ),
                ),
        ],
      ),
      body: Obx(
        () {
          if (cartController.productMap.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                      width: 100,
                      height: 100.0,
                      child: Icon(
                        CupertinoIcons.shopping_cart,
                        size: 100,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(
                    text: 'Your cart is Empty,',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        primary: Get.isDarkMode ? pinkClr : mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      Get.off(() => MainScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextWidget(
                          text: 'Got to Home',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartController.productMap.length,
              itemBuilder: (context, index) {
                var productData =
                    cartController.productMap.keys.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 8,
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                productData.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextWidget(
                                  text: productData.title,
                                  fontWeight: FontWeight.w600,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextWidget(
                                  text:
                                      "\$${cartController.productSubTotal[index].toStringAsFixed(2)}",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                          Obx(() {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        cartController.addProductToCart(
                                          productData,
                                        );
                                      },
                                      icon: Icon(
                                        CupertinoIcons.plus_circle_fill,
                                        color: Get.isDarkMode
                                            ? Colors.red[600]
                                            : mainColor,
                                        size: 30,
                                      ),
                                    ),
                                    TextWidget(
                                      text:
                                          "${cartController.productMap.values.toList()[index]}",
                                      fontWeight: FontWeight.w500,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cartController.removeProductFromCart(
                                          productData,
                                        );
                                      },
                                      icon: Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        color: Get.isDarkMode
                                            ? Colors.red[600]
                                            : mainColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartController
                                        .clearOneProductFromCart(productData);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    color: Get.isDarkMode
                                        ? Colors.red[600]
                                        : pinkClr,
                                    size: 30,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget bottomSheetContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      child: cartController.productMap.isEmpty
          ? Container()
          : Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const TextWidget(
                      text: 'Total',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Obx(() {
                      return TextWidget(
                        text: cartController.productMap.isEmpty
                            ? "0.0"
                            : '\$${cartController.total}',
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 22,
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => PaymentScreen());
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Get.isDarkMode ? pinkClr : mainColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const TextWidget(
                            text: 'Check Out',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
