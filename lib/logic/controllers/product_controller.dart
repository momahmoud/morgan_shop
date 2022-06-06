import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/services/product_service.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;
  var favoriteProductList = <ProductModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isFavorite = false.obs;
  var localStorage = GetStorage();

  @override
  void onInit() {
    List? storageProducts = localStorage.read<List>('isFavorite');
    if (storageProducts != null) {
      favoriteProductList =
          storageProducts.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    var products = await ProductService.getProduct();
    try {
      isLoading.value = true;
      if (products.isNotEmpty) {
        productList.addAll(products);
      }
    } finally {
      isLoading(false);
    }
  }

  void addProductToFavorites(int productId) async {
    var existingIndex =
        favoriteProductList.indexWhere((element) => element.id == productId);
    if (existingIndex >= 0) {
      favoriteProductList.removeAt(existingIndex);
      localStorage.remove('isFavorite');
    } else {
      favoriteProductList.add(productList.firstWhere(
        (element) => element.id == productId,
      ));
      await localStorage.write('isFavorite', favoriteProductList);
    }
  }

  bool toggleFavorites(int productId) {
    return favoriteProductList.any((element) => element.id == productId);
  }
}
