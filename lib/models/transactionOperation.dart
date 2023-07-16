import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TransactionOperation with ChangeNotifier {
  final String id;
  final int index;
  final double takenMoney;
  final double gavenMoney;
  final DateTime date;

  TransactionOperation({
    required this.id,
    required this.index,
    required this.takenMoney,
    required this.gavenMoney,
    required this.date,
  });

  String get formattedDate {
    DateFormat formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
