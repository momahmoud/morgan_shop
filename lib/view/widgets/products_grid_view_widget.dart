import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/model/product_model.dart';

import '../../logic/controllers/cart_controller.dart';
import '../../logic/controllers/product_controller.dart';
import '../../utils/themes.dart';
import '../screens/product_details_screen.dart';
import 'text_widget.dart';

class ProductsGridViewWidget extends StatelessWidget {
  final ProductModel productModel;
  final int index;
  ProductsGridViewWidget(
      {Key? key, required this.productModel, required this.index})
      : super(key: key);

  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          ProductDetailsScreen(
            productModel: productModel,
          ),
        );
      },
      child: Card(
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        elevation: 10,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Get.isDarkMode ? Colors.black : Colors.grey,
        child: Column(
          children: <Widget>[
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        productController
                            .addProductToFavorites(productModel.id);
                      },
                      child: Icon(
                        productController.toggleFavorites(productModel.id)
                            ? CupertinoIcons.heart_solid
                            : Icons.favorite_border,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: TextWidget(
                          text: productModel.title,
                          fontWeight: FontWeight.w600,
                          color:
                              Get.isDarkMode ? Colors.white54 : Colors.black54,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cartController.addProductToCart(
                            productController.productList[index]);
                      },
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .33,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      productModel.image,
                      color: Colors.black.withOpacity(.2),
                      filterQuality: FilterQuality.high,
                      colorBlendMode: BlendMode.darken,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * .33,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[300],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextWidget(
                            text: '\$${productModel.price}',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Get.isDarkMode ? pinkClr : mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                TextWidget(
                                  text: '${productModel.rating.rate}',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
