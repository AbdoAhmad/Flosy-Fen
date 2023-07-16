import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'orderOperation.dart';

class Order with ChangeNotifier {
  final String id;
  final int index;
  final String companyName;
  final String productName;
  final double productPrice;
  final String? authToken;
  List<OrderOperation> _listOfOrderOperation = [];

  Order(
      {required this.id,
      required this.index,
      required this.companyName,
      required this.productName,
      required this.productPrice,
      required this.authToken});

  List<OrderOperation> get listOfOrderOperation {
    return [..._listOfOrderOperation];
  }

  int get totalProductQuantity {
    int totalProductQuantity = 0;

    if (_listOfOrderOperation.isEmpty) return totalProductQuantity;

    for (OrderOperation operation in _listOfOrderOperation) {
      totalProductQuantity += operation.productQuantity;
    }
    return totalProductQuantity;
  }

  double get totalPrice {
    double totalPrice = productPrice * totalProductQuantity;

    return totalPrice;
  }

  String get finalFormattedDate {
    if (_listOfOrderOperation.isEmpty) return "";
    final lastOperation = _listOfOrderOperation.last;
    return lastOperation.formattedDate;
  }

  Future<void> getAllOrderOperation() async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList/$id/OrderOperationList.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final fromattedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      final List<OrderOperation> loadedOrderOperation = [];

      fromattedResponse.forEach((id, orderOperationData) {
        loadedOrderOperation.add(OrderOperation(
            id: id,
            index: orderOperationData["index"],
            productQuantity: orderOperationData["productQuantity"],
            date: DateTime.parse(orderOperationData["date"])));
      });
      _listOfOrderOperation = loadedOrderOperation;
      _listOfOrderOperation.sort((a, b) => a.index.compareTo(b.index));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrderOperation(int productQuantity, DateTime date) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList/$id/OrderOperationList.json?auth=$authToken');

      final response = await http.post(url,
          body: json.encode({
            "index": _listOfOrderOperation.length,
            "productQuantity": productQuantity,
            "date": date.toIso8601String(),
          }));

      final orderOperationId = json.decode(response.body)["name"];
      final orderOperation = OrderOperation(
          id: orderOperationId,
          index: _listOfOrderOperation.length,
          productQuantity: productQuantity,
          date: date);
      _listOfOrderOperation.add(orderOperation);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> insertOrderOperation(int index, OrderOperation operation) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList/$id/OrderOperationList.json?auth=$authToken');

      final response = await http.post(url,
          body: json.encode({
            "index": index,
            "productQuantity": operation.productQuantity,
            "date": operation.date.toIso8601String(),
          }));
      final orderOperationId = json.decode(response.body)["name"];
      final orderOperation = OrderOperation(
          id: orderOperationId,
          index: index,
          productQuantity: operation.productQuantity,
          date: operation.date);
      _listOfOrderOperation.insert(index, orderOperation);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  // void updateOrderOperation(String id, int productQuantity, DateTime date) {
  //   final int currentOperationIndex =
  //       _listOfOperation.indexWhere((element) => element.id == id);

  //   final updatedOperation =
  //       // OrderOperation(productQuantity: productQuantity, date: date);

  //       deleteOrderOperation(id);

  //   // insertOperation(currentOperationIndex, updatedOperation);

  //   notifyListeners();
  // }

  Future<void> deleteOrderOperation(String orderOperationId) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/OrderList/$id/OrderOperationList/$orderOperationId.json?auth=$authToken');
    await http.delete(url);
    _listOfOrderOperation
        .removeWhere((element) => element.id == orderOperationId);
    notifyListeners();
  }

  OrderOperation getOrderOperation(String id) {
    OrderOperation operation =
        _listOfOrderOperation.firstWhere((element) => element.id == id);
    return operation;
  }
}
