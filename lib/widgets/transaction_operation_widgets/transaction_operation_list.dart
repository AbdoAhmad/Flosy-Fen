import 'package:flutter/material.dart';
import 'package:frist/models/transactionOperation.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';
import 'transaction_operation_item.dart';

class TransactionOperationList extends StatelessWidget {
  const TransactionOperationList({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Transaction>(context, listen: false)
          .getAllTransactionOperation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<Transaction>(
            builder: (context, transactionOerationProvider, child) {
              final List<TransactionOperation> listOfTransactionOperation =
                  transactionOerationProvider.listOfTransactionOperation;
              return listOfTransactionOperation.isEmpty
                  ? const Center(
                      child: Text('ليس لديك أي عمليات من فضلك أضف عملية',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: listOfTransactionOperation.length,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: listOfTransactionOperation[i],
                              child: Dismissible(
                                key: ValueKey(listOfTransactionOperation[i]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async {
                                  await transactionOerationProvider
                                      .deleteTransactionOperation(
                                          listOfTransactionOperation[i].id);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text('تم مسح العملية  بنجاح'),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                          label: "استرجاع العملية",
                                          onPressed: () async =>
                                              await transactionOerationProvider
                                                  .insertTransactionOperation(
                                            i,
                                            listOfTransactionOperation[i],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                background: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    color: Colors.red,
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                child: const TransactionOperationItem(),
                              ),
                            ),
                            shrinkWrap: true,
                          ),
                        ),
                      ),
                    );
            },
          );
        }
      },
    );
  }
}
