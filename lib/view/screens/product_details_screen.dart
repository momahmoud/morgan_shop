import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/view/widgets/image_slider_widget.dart';
import 'package:morgan_shop/view/widgets/product_detail_widget.dart';
import 'package:morgan_shop/view/widgets/product_sizes_widget.dart';

import '../../logic/controllers/cart_controller.dart';
import '../../utils/themes.dart';
import '../widgets/text_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  final cartController = Get.find<CartController>();
// final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomSheetContainer(),
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: <Widget>[
            ImageSliderWidget(imageUrl: productModel.image),
            ProductDetailWidget(
              title: productModel.title,
              id: productModel.id,
              rateCount: productModel.rating.rate,
              description: productModel.description,
            ),
            const ProductSizesWidget()
          ],
        ),
      ),
    );
  }

  Widget bottomSheetContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              const TextWidget(
                text: 'Price',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 20,
              ),
              const SizedBox(
                height: 3,
              ),
              TextWidget(
                text: '\$${productModel.price}',
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                cartController.addProductToCart(productModel);
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
                      text: 'Add to Cart',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
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
