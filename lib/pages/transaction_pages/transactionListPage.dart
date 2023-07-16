import 'package:flutter/material.dart';
import 'package:frist/widgets/transaction_widgets/statistics_item.dart';
import 'package:provider/provider.dart';

import '../../providers/transaction_provider.dart';
import '../../widgets/transaction_widgets/transaction_list.dart';

class TransactionListPage extends StatelessWidget {
  static const String routeName = "/transaction-list-page";
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: StatisticsItem(
              finalTakenMoney: transactionProvider.finalTakenMoney,
              finalGavenMoney: transactionProvider.finalGavenMoney,
              finalBalance: transactionProvider.finalBalance),
        ),
        const Expanded(
          child: TransactionList(),
        )
      ],
    );
  }
}
