import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/orderOperation.dart';

class OrderOperationItem extends StatelessWidget {
  const OrderOperationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final operation = Provider.of<OrderOperation>(context);
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                " الكمية : ${operation.productQuantity}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                " بتاريخ : ${operation.formattedDate}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
