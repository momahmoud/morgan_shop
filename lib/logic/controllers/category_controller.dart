import 'package:get/get.dart';
import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/services/category_services.dart';

class CategoryController extends GetxController {
  var categoryList = <String>[].obs;
  var productCategoryList = <ProductModel>[].obs;
  var isLoading = false.obs;
  var isItemLoading = false.obs;

  List<String> categoryImages = [
    'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
  ];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    var categoryName = await CategoryService.getCategoryies();
    try {
      isLoading(true);
      if (categoryName.isNotEmpty) {
        categoryList.addAll(categoryName);
      }
    } finally {
      isLoading(false);
    }
  }

  getAllProductsFromTheSameCategory(String category) async {
    isItemLoading(true);
    productCategoryList.value =
        await CategoryService.getAllProductsFromTheSameCategory(
      category,
    );
    isItemLoading(false);
  }

  getAllProductCategoryIndex(int index) async {
    var allCategoryName = await getAllProductsFromTheSameCategory(
      categoryList[index],
    );
    if (allCategoryName != null) {
      productCategoryList.value = allCategoryName;
    }
  }
}
