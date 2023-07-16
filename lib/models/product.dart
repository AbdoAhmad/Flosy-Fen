import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final int index;
  final String name;
  final String cmmf;
  final double price;

   Product({
    required this.id,
    required this.index,
    required this.name,
    required this.cmmf,
    required this.price,
  });
}
