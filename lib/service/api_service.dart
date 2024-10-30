// services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://api.npoint.io/a907f54f4d95e9e31711'; 

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> fetchProductDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}

