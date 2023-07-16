import 'package:flutter/material.dart';
import 'package:frist/models/transaction.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<Transaction>(context);
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text(transaction.companyName,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " أخذ : ${transaction.totalTakenMoney.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " أعطى : ${transaction.totalGavenMoney.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if(transaction.totalGavenMoney<transaction.totalTakenMoney)
                  Text(
                    " عليه : ${transaction.totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if(transaction.totalGavenMoney>transaction.totalTakenMoney)
                  Text(
                    " له : ${transaction.totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if (transaction.finalFormattedDate.isNotEmpty)
                    Text(
                      " بتاريخ : ${transaction.finalFormattedDate}",
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
