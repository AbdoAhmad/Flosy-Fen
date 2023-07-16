import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frist/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _listOfTransaction = [];
  final String? authToken;
  final String? userId;

  List<Transaction> get listOfTransaction {
    return [..._listOfTransaction];
  }

  TransactionProvider(
      [this.authToken = '',
      this.userId = '',
      this._listOfTransaction = const []]);

  double get finalTakenMoney {
    double finalTakenMoney = 0;

    if (_listOfTransaction.isEmpty) return finalTakenMoney;

    for (Transaction transaction in _listOfTransaction) {
      finalTakenMoney += transaction.totalTakenMoney;
    }
    return finalTakenMoney;
  }

  double get finalGavenMoney {
    double finalGavenMoney = 0;

    if (_listOfTransaction.isEmpty) return finalGavenMoney;

    for (Transaction transaction in _listOfTransaction) {
      finalGavenMoney += transaction.totalGavenMoney;
    }
    return finalGavenMoney;
  }

  double get finalBalance {
    double totalBalance = finalTakenMoney - finalGavenMoney;

    return totalBalance.abs();
  }

  Future<void> getAllTransaction() async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList.json?auth=$authToken&orderBy="userId"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      final fromattedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> loadedTransaction = [];

      fromattedResponse.forEach((id, transactionData) {
        final Transaction newTransaction = Transaction(
          id: id,
          index: transactionData["index"],
          companyName: transactionData["companyName"],
          authToken: authToken,
        );
        newTransaction.getAllTransactionOperation();
        loadedTransaction.add(newTransaction);
      });

      _listOfTransaction = loadedTransaction;
      _listOfTransaction.sort((a, b) => a.index.compareTo(b.index));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addTransaction(
      String companyName, double takenMoney, double gavenMoney) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList.json?auth=$authToken');
    if (ifTansactionNotExists(companyName)) {
      final response = await http.post(url,
          body: json.encode({
            "index": _listOfTransaction.length,
            "companyName": companyName,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      Transaction newTransaction = Transaction(
        id: id,
        index: _listOfTransaction.length,
        companyName: companyName,
        authToken: authToken,
      );

      await newTransaction.addTransactionOperation(
          takenMoney, gavenMoney, DateTime.now());

      _listOfTransaction.add(newTransaction);
    } else {
      Transaction currentTransaction = _listOfTransaction
          .firstWhere((element) => element.companyName == companyName);
      await currentTransaction.addTransactionOperation(
          takenMoney, gavenMoney, DateTime.now());
    }
    notifyListeners();
  }

  Future<void> insertTransaction(int index, Transaction transaction) async {
    final url = Uri.parse(
        'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            "index": index,
            "companyName": transaction.companyName,
            "userId": userId,
          }));
      final id = json.decode(response.body)["name"];
      Transaction insertedTransaction = Transaction(
        id: id,
        index: index,
        companyName: transaction.companyName,
        authToken: transaction.authToken,
      );
      for (var transactionOperation in transaction.listOfTransactionOperation) {
        await insertedTransaction.addTransactionOperation(
            transactionOperation.takenMoney,
            transactionOperation.gavenMoney,
            transactionOperation.date);
      }
      _listOfTransaction.insert(index, insertedTransaction);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      final url = Uri.parse(
          'https://tech-app-16de3-default-rtdb.firebaseio.com/TransactionList/$id.json?auth=$authToken');
      await http.delete(url);
      _listOfTransaction.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Transaction getTransaction(String id) {
    Transaction transaction =
        _listOfTransaction.firstWhere((element) => element.id == id);
    return transaction;
  }

  bool ifTansactionNotExists(String companyName) {
    int transactionId = _listOfTransaction
        .indexWhere((element) => element.companyName == companyName);
    return transactionId == -1;
  }
}
