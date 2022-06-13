import 'package:http/http.dart' as http;
import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/utils/my_string.dart';

class ProductService {
  static Future<List<ProductModel>> getProduct() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      var jsonData = response.body;

      return productModelFromJson(jsonData);
    } else {
      return throw Exception('error!');
    }
  }
}
