import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morgan_shop/logic/controllers/cart_controller.dart';
import 'package:morgan_shop/logic/controllers/product_controller.dart';
import 'package:morgan_shop/model/product_model.dart';

import 'package:morgan_shop/utils/themes.dart';

import 'package:morgan_shop/view/widgets/products_grid_view_widget.dart';
import 'package:morgan_shop/view/widgets/search_text_field_widget.dart';

import 'package:morgan_shop/view/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  // final TextEditingController _searchController = TextEditingController();
  final String dropdownValue = 'Newest';

  // List of items in our dropdown menu
  final items = [
    'Newest',
    'oldest',
    'Popular',
  ];

  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20, top: 5),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
              color: Get.isDarkMode ? darkGreyClr : mainColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Find Your',
                  style: GoogleFonts.spaceMono(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TextWidget(
                  text: 'INSPIRATION',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchTextFieldWidget(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextWidget(
                  text: 'Categories',
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black54,
                  fontSize: 23,
                ),
                Container(
                  // width: 80,
                  padding: const EdgeInsets.only(left: 15),
                  height: 25,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(0, 3)),
                    ],
                    color: Get.isDarkMode ? pinkClr : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    value: dropdownValue,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Get.isDarkMode ? pinkClr : mainColor,
                  ),
                );
              } else {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .63,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: productController.searchList.isEmpty
                      ? productController.productList.length
                      : productController.searchList.length,
                  itemBuilder: (context, index) {
                    if (productController.searchList.isEmpty) {
                      List<ProductModel> productData =
                          productController.productList;
                      return ProductsGridViewWidget(
                        productModel: productData[index],
                        index: index,
                      );
                    } else {
                      List<ProductModel> productData =
                          productController.searchList;
                      if (productController.searchList.isEmpty &&
                          productController
                              .searchEditingController.text.isNotEmpty) {
                        return Image.asset(
                            'assets/images/search_empry_light.png');
                      }
                      return ProductsGridViewWidget(
                        productModel: productData[index],
                        index: index,
                      );
                    }
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
