import 'dart:convert';

import 'package:http/http.dart';
import 'package:pingolearn/models/product_model.dart';

class HomeRepo {
  Future<ProductModel> getProducts() async {
    try {
      final res = await get(Uri.parse('https://dummyjson.com/products'));
      if (res.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(res.body));
      }
      return ProductModel.fromJson({});
    } catch (e) {
      rethrow;
    }
  }
}
