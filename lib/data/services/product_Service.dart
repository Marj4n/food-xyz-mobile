import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://80c6-202-73-27-104.ngrok-free.app/api/"),
  );

  Future<List<Product>> getProducts() async {
    final response = await _dio.get("products");

    final List data = response.data;

    return data.map((e) {
      return Product(
        id: e['id'].toString(),
        productName: e['productName'],
        price: e['price'],
        image: e['image'],
        rating: (e['rating'] ?? 0).toDouble(),
        stock: e['stock'],
      );
    }).toList();
  }
}
