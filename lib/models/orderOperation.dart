import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class OrderOperation with ChangeNotifier {
  final String id;
  final int index;
  final int productQuantity;
  final DateTime date;

  OrderOperation({
    required this.id,
    required this.index,
    required this.productQuantity,
    required this.date,
  });

  String get formattedDate {
    DateFormat formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
