import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';
import '../../widgets/transaction_operation_widgets/transaction_operation_list.dart';
import 'addTransactionOperationPage.dart';

class TransactionOperationListPage extends StatelessWidget {
  static const String routeName = "/transaction-operation-list-page";
  const TransactionOperationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionOperationProvider = Provider.of<Transaction>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل المعاملة"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //      showSearch(context: context, delegate: HomeSearchBar());
              },
              icon: const Icon(Icons.search),
              color: Colors.white)
        ],
      ),
      body: const TransactionOperationList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider.value(
              value: transactionOperationProvider,
              child: const AddTransactionOperationPage(),
            ),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
