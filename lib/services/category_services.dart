import 'package:http/http.dart' as http;
import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/utils/my_string.dart';

import '../model/category_model.dart';

class CategoryService {
  static Future<List<String>> getCategoryies() async {
    http.Response response =
        await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return categoryModelFromJson(jsonData);
    } else {
      return throw Exception('error!');
    }
  }

  static Future<List<ProductModel>> getAllProductsFromTheSameCategory(
      String categoryName) async {
    http.Response response =
        await http.get(Uri.parse('$baseUrl/products/category/$categoryName'));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productModelFromJson(jsonData);
    } else {
      return throw Exception('error!');
    }
  }
}
