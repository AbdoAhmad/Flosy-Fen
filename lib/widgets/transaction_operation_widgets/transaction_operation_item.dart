import 'package:flutter/material.dart';
import 'package:frist/models/transactionOperation.dart';
import 'package:provider/provider.dart';

class TransactionOperationItem extends StatelessWidget {
  const TransactionOperationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final operation = Provider.of<TransactionOperation>(context);

    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " أخذ : ${operation.takenMoney.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " أعطى : ${operation.gavenMoney.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    Text(
                      " بتاريخ : ${operation.formattedDate}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
