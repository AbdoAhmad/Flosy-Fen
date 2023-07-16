import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frist/models/transactionOperation.dart';
import 'package:http/http.dart' as http;

class Transaction extends ChangeNotifier {
  final String id;
  final int index;
  final String companyName;
  final String? authToken;
  List<TransactionOperation> _listOfTransactionOperation = [];

  Transaction({
    required this.id,
    required this.index,
    required this.companyName,
    required this.authToken,
  });

  List<TransactionOperation> get listOfTransactionOperation {
    return [..._listOfTransactionOperation];
  }

  double get totalTakenMoney {
    double totalTakenMoney = 0;

    if (_listOfTransactionOperation.isEmpty) return totalTakenMoney;

    for (TransactionOperation operation in _listOfTransactionOperation) {
      totalTakenMoney += operation.takenMoney;
    }

    return totalTakenMoney;
  }

  double get totalGavenMoney {
    double totalGavenMoney = 0;

    if (_listOfTransactionOperation.isEmpty) return totalGavenMoney;

    for (TransactionOperation operation in _listOfTransactionOperation) {
      totalGavenMoney += operation.gavenMoney;
    }
    return totalGavenMoney;
  }

  double get totalBalance {
    double totalBalance = totalTakenMoney - totalGavenMoney;

    return totalBalance.abs();
  }

  String get finalFormattedDate {
    if (_listOfTransactionOperation.isEmpty) return "";
    final lastOperation = _listOfTransactionOperation.last;
    return lastOperation.formattedDate;
  }

  Future<void> getAllTransactionOperation() async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id/TransactionOperationList.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final fromattedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      final List<TransactionOperation> loadedTransactionOperation = [];

      fromattedResponse.forEach((id, transactionOperationData) {
        loadedTransactionOperation.add(TransactionOperation(
            id: id,
            index: transactionOperationData["index"],
            takenMoney: transactionOperationData["takenMoney"],
            gavenMoney: transactionOperationData["gavenMoney"],
            date: DateTime.parse(transactionOperationData["date"])));
      });
      _listOfTransactionOperation = loadedTransactionOperation;
      _listOfTransactionOperation.sort((a, b) => a.index.compareTo(b.index));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addTransactionOperation(
      double takenMoney, double gavenMoney, DateTime date) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id/TransactionOperationList.json?auth=$authToken');

      final response = await http.post(url,
          body: json.encode({
            "index": _listOfTransactionOperation.length,
            "takenMoney": takenMoney,
            "gavenMoney": gavenMoney,
            "date": date.toIso8601String(),
          }));

      final transactionOperationId = json.decode(response.body)["name"];
      final transactionOperation = TransactionOperation(
          id: transactionOperationId,
          index: _listOfTransactionOperation.length,
          takenMoney: takenMoney,
          gavenMoney: gavenMoney,
          date: date);
      _listOfTransactionOperation.add(transactionOperation);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> insertTransactionOperation(
      int index, TransactionOperation operation) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id/TransactionOperationList.json?auth=$authToken');

      final response = await http.post(url,
          body: json.encode({
            "index": index,
            "takenMoney": operation.takenMoney,
            "gavenMoney": operation.gavenMoney,
            "date": operation.date.toIso8601String(),
          }));
      final transactionOperationId = json.decode(response.body)["name"];
      final transactionOperation = TransactionOperation(
          id: transactionOperationId,
          index: index,
          takenMoney: operation.takenMoney,
          gavenMoney: operation.gavenMoney,
          date: operation.date);
      _listOfTransactionOperation.insert(index, transactionOperation);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // Future<void> updateTransactionOperation(String transactionOperationId,
  //     double takenMoney, double gavenMoney, DateTime date) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id/TransactionOperationList/$transactionOperationId.json');
  //     await http.patch(url, body: {
  //       "takenMoney": takenMoney,
  //       "gavenMoney": gavenMoney,
  //       "date": date,
  //     });
  //     final int currentOperationIndex = _listOfTransactionOperation
  //         .indexWhere((element) => element.id == transactionOperationId);

  //     final updatedOperation = TransactionOperation(
  //         id: transactionOperationId,
  //         takenMoney: takenMoney,
  //         gavenMoney: gavenMoney,
  //         date: date);

  //     _listOfTransactionOperation[currentOperationIndex] = updatedOperation;
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     rethrow;
  //   }
  // }

  Future<void> deleteTransactionOperation(String transactionOperationId) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id/TransactionOperationList/$transactionOperationId.json?auth=$authToken');
      await http.delete(url);
      _listOfTransactionOperation
          .removeWhere((element) => element.id == transactionOperationId);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  TransactionOperation getTransactionOperation(String id) {
    TransactionOperation operation =
        _listOfTransactionOperation.firstWhere((element) => element.id == id);
    return operation;
  }
}
