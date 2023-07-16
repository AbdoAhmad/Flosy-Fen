import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:frist/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _listOfProduct = [];

  final String? authToken;
  final String? userId;
  List<Product> get listOfProduct {
    return [..._listOfProduct];
  }

  ProductProvider(
      [this.authToken = '', this.userId = '', this._listOfProduct = const []]);

  Future<void> getAllProduct() async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/productList.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final fromattedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      fromattedResponse.forEach((id, productData) {
        loadedProducts.add(Product(
            id: id,
            index: productData["index"],
            name: productData["productName"],
            cmmf: productData["productCmmf"],
            price: productData["productPrice"]));
      });
      _listOfProduct = loadedProducts;
      _listOfProduct.sort((a, b) => a.index.compareTo(b.index));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(String name, String cmmf, double price) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/productList.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            "productName": name,
            "productCmmf": cmmf,
            "productPrice": price,
            "index": _listOfProduct.length,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      final Product product = Product(
          id: id,
          index: _listOfProduct.length,
          name: name,
          cmmf: cmmf,
          price: price);
      _listOfProduct.add(product);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> insertProduct(int index, Product product) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/productList.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            "productName": product.name,
            "productCmmf": product.cmmf,
            "productPrice": product.price,
            "index": index,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      final Product insertedProduct = Product(
          id: id,
          index: index,
          name: product.name,
          cmmf: product.cmmf,
          price: product.price);

      _listOfProduct.insert(index, insertedProduct);

     
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }

    notifyListeners();
  }

  Future<void> updateProduct(
      String id, String name, String cmmf, double price) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/productList/$id.json?auth=$authToken');
      final int currentProductIndex =
          _listOfProduct.indexWhere((element) => element.id == id);
      await http.patch(url,
          body: json.encode({
            "productName": name,
            "productCmmf": cmmf,
            "productPrice": price,
            "index": currentProductIndex,
            "userId": userId
          }));

      final updatedProduct = Product(
          id: id,
          index: _listOfProduct.length,
          name: name,
          cmmf: cmmf,
          price: price);

      _listOfProduct[currentProductIndex] = updatedProduct;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/productList/$id.json?auth=$authToken');

      await http.delete(url);
      _listOfProduct.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Product getProduct(String id) {
    Product product = _listOfProduct.firstWhere((element) => element.id == id);
    return product;
  }

  double getProductPrice(String productName) {
    Product product =
        _listOfProduct.firstWhere((element) => element.name == productName);
    return product.price;
  }
}
