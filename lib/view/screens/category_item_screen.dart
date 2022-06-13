import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/category_controller.dart';

import '../../logic/controllers/product_controller.dart';

import '../../model/product_model.dart';
import '../../utils/themes.dart';
import '../widgets/products_grid_view_widget.dart';
import '../widgets/text_widget.dart';

class CategoryItemScreen extends StatelessWidget {
  final String categoryName;
  CategoryItemScreen({Key? key, required this.categoryName}) : super(key: key);

  final productController = Get.find<ProductController>();
  final categoryController = Get.find<CategoryController>();
  // final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: TextWidget(
          text: categoryName,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
      ),
      body: Obx(() {
        if (categoryController.isItemLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
          );
        } else {
          return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .60,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryController.productCategoryList.length,
              itemBuilder: (context, index) {
                List<ProductModel> productData =
                    categoryController.productCategoryList;
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductsGridViewWidget(
                      productModel: productData[index],
                      index: index,
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
