import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morgan_shop/logic/controllers/cart_controller.dart';
import 'package:morgan_shop/logic/controllers/product_controller.dart';
import 'package:morgan_shop/model/product_model.dart';

import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/screens/product_details_screen.dart';
import 'package:morgan_shop/view/widgets/text_form_field_widget.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextFormFieldWidget(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Get.isDarkMode ? pinkClr : mainColor,
                            size: 30,
                          ),
                          hint: 'Search you\'re looking for',
                          controller: _searchController,
                          validator: () {},
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sort,
                        color: Get.isDarkMode ? pinkClr : Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
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
                List<ProductModel> productData = productController.productList;
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
                  itemCount: productData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          ProductDetailsScreen(
                            productModel: productData[index],
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
                        shadowColor:
                            Get.isDarkMode ? Colors.black : Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Obx(
                              () => Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        productController.addProductToFavorites(
                                            productData[index].id);
                                      },
                                      child: Icon(
                                        productController.toggleFavorites(
                                                productData[index].id)
                                            ? CupertinoIcons.heart_solid
                                            : Icons.favorite_border,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        child: TextWidget(
                                          text: productData[index].title,
                                          fontWeight: FontWeight.w600,
                                          color: Get.isDarkMode
                                              ? Colors.white54
                                              : Colors.black54,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartController.addProductToCart(
                                            productController
                                                .productList[index]);
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 7),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      productData[index].image,
                                      color: Colors.black.withOpacity(.2),
                                      filterQuality: FilterQuality.high,
                                      colorBlendMode: BlendMode.darken,
                                      height: Get.height - 547,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.grey[300],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          TextWidget(
                                            text:
                                                '\$${productData[index].price}',
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
                                              color: Get.isDarkMode
                                                  ? pinkClr
                                                  : mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                TextWidget(
                                                  text:
                                                      '${productData[index].rating.rate}',
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
