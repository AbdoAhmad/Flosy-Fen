import 'package:flutter/material.dart';
import 'package:frist/widgets/order_widgets/order_list.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = "/order-list-page";
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderList();
  }
}