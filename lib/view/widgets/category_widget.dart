import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/logic/controllers/category_controller.dart';
import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/screens/category_item_screen.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key}) : super(key: key);

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? pinkClr : mainColor,
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: ListView.separated(
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                categoryController.getAllProductCategoryIndex(index);
                Get.to(() => CategoryItemScreen(
                      categoryName: categoryController.categoryList[index],
                    ));
              },
              child: _buildCategoryCard(
                index,
              ),
            );
          }),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: categoryController.categoryList.length,
        ),
      );
    });
  }

  _buildCategoryCard(index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              categoryController.categoryImages[index],
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(.7),
              ),
              child: TextWidget(
                  text: categoryController.categoryList[index],
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
