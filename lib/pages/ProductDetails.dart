// screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ApiService apiService = ApiService();
  late Future<Product> product;

  @override
  void initState() {
    super.initState();
    product = apiService.fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.bold, 
            color: Colors.black, 
          ),
        ),
        backgroundColor: Colors.white, 
        elevation: 2, 
        centerTitle: false, 
      ),
      
      body: FutureBuilder<Product>(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Product product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.images, height: 200, width: double.infinity, fit: BoxFit.cover),
                  SizedBox(height: 20),
                  Text(product.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(product.price, style: TextStyle(fontSize: 20, color: Colors.green)),
                  SizedBox(height: 10),
                  Text('Rating: ${product.rating}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text(product.description),
                ],
              ),
            );
          }
          return Center(child: Text('Product not found.'));
        },
      ),
    );
  }
}
