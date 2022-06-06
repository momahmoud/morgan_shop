import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:morgan_shop/logic/controllers/product_controller.dart';
import 'package:morgan_shop/utils/themes.dart';

import 'package:morgan_shop/view/widgets/text_widget.dart';

import '../../model/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (productController.favoriteProductList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100.0,
                  child: Image.asset(
                    'assets/images/heart.png',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextWidget(
                  text: 'No Favorite Products Yet,',
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
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextWidget(
                        text: 'Add Ones',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        } else {
          List<ProductModel> productData =
              productController.favoriteProductList;
          return ListView.builder(
            itemCount: productData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 8,
                  child: Container(
                      height: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                productData[index].image,
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
                                  text: productData[index].title,
                                  fontWeight: FontWeight.w600,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextWidget(
                                  text: "\$${productData[index].price}",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                productController.addProductToFavorites(
                                    productData[index].id);
                              },
                              icon: Icon(
                                CupertinoIcons.heart_solid,
                                color: Get.isDarkMode
                                    ? mainColor
                                    : Colors.red[600],
                                size: 35,
                              ))
                        ],
                      )),
                ),
              );
            },
          );
        }
      },
    );
  }
}
