import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/order.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _listOfOrder = [];
  final String? authToken;
  final String? userId;

  List<Order> get listOfOrder {
    return [..._listOfOrder];
  }

  OrderProvider(
      [this.authToken = '', this.userId = '', this._listOfOrder = const []]);

  Future<void> getAllOrder() async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList.json?auth=$authToken&orderBy="userId"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      final fromattedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Order> loadedOrder = [];

      fromattedResponse.forEach((id, orderData) {
        final Order newOrder = Order(
            id: id,
            index: orderData["index"],
            companyName: orderData["companyName"],
            productName: orderData["productName"],
            productPrice: orderData["productPrice"],
            authToken: authToken);

        newOrder.getAllOrderOperation();
        loadedOrder.add(newOrder);
      });

      _listOfOrder = loadedOrder;
      _listOfOrder.sort((a, b) => a.index.compareTo(b.index));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(String companyName, String productName,
      double productPrice, int productQuantity) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList.json?auth=$authToken');
    if (ifOrderNotExists(companyName, productName)) {
      final response = await http.post(url,
          body: json.encode({
            "index": _listOfOrder.length,
            "companyName": companyName,
            "productName": productName,
            "productPrice": productPrice,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      Order newOrder = Order(
        id: id,
        index: _listOfOrder.length,
        companyName: companyName,
        productName: productName,
        productPrice: productPrice,
        authToken: authToken,
      );

      await newOrder.addOrderOperation(productQuantity, DateTime.now());

      _listOfOrder.add(newOrder);
    } else {
      Order currentOrder = _listOfOrder.firstWhere((element) =>
          element.companyName == companyName &&
          element.productName == productName);
      await currentOrder.addOrderOperation(productQuantity, DateTime.now());
    }

    notifyListeners();
  }

  Future<void> insertOrder(int index, Order order) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList.json?auth=$authToken');

    try {
      final response = await http.post(url,
          body: json.encode({
            "companyName": order.companyName,
            "productName": order.productName,
            "productPrice": order.productPrice,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      final insertedOrder = Order(
          id: id,
          index: index,
          companyName: order.companyName,
          productName: order.productName,
          productPrice: order.productPrice,
          authToken: order.authToken);
      for (var orderOperation in order.listOfOrderOperation) {
        await insertedOrder.addOrderOperation(
            orderOperation.productQuantity, orderOperation.date);
      }
      _listOfOrder.insert(index, order);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void updateOrder(String id, String companyName, String productName,
      double productPrice, DateTime date) {
//     final int currentOrderIndex =
//         _listOfOrder.indexWhere((element) => element.id == id);

//     // final updatedOrder = Order(
//     //   companyName: companyName,
//     //   productName: productName,
//     //   productPrice: productPrice,
//     // );

//     deleteOrder(id);

// //    insertOrder(currentOrderIndex, updatedOrder);

//     notifyListeners();
  }

  Future<void> deleteOrder(String id) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList/$id.json?auth=$authToken');
      await http.delete(url);
      _listOfOrder.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Order getOrder(String id) {
    Order order = _listOfOrder.firstWhere((element) => element.id == id);
    return order;
  }

  bool ifOrderNotExists(String companyName, String productName) {
    int orderId = _listOfOrder.indexWhere((element) =>
        element.companyName == companyName &&
        element.productName == productName);
    return orderId == -1;
  }
}
