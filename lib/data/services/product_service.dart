import 'package:dio/dio.dart';
import 'package:e_commers_app_sample/utils/app_urls.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    final response = await _dio.get(AppUrls.getProductsUrl);
    print("call ${AppUrls.getProductsUrl}");
    print("res  ${response.data["products"]}");

    return (response.data['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<Product> fetchProductDetail(int id) async {
    print('${AppUrls.getProductsUrl}$id');
    final response = await _dio.get('${AppUrls.getProductsUrl}$id');
    return Product.fromJson(response.data);
  }
}
