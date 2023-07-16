import 'package:flutter/material.dart';
import 'package:frist/pages/transaction_operation_pages/transactionOperationListPage.dart';
import 'package:frist/providers/transaction_provider.dart';
import 'package:frist/widgets/transaction_widgets/transaction_item.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TransactionProvider>(context, listen: false)
          .getAllTransaction(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<TransactionProvider>(
            builder: (context, transactionProvider, child) {
              final List<Transaction> listOfTransaction =
                  transactionProvider.listOfTransaction;
                  
                  print(transactionProvider.finalBalance);
              return listOfTransaction.isEmpty
                  ? const Column(
                      children: [
                        Center(
                          child: Text('ليس لديك أي معاملات من فضلك أضف معاملة',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 400,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: listOfTransaction.length,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: listOfTransaction[i],
                              child: Dismissible(
                                key: ValueKey(listOfTransaction[i]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async {
                                  await transactionProvider.deleteTransaction(
                                      listOfTransaction[i].id);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'تم مسح المعاملة  بنجاح'),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                            label: "استرجاع المعاملة",
                                            onPressed: () async =>
                                                await transactionProvider
                                                    .insertTransaction(i,
                                                        listOfTransaction[i])),
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
                                child: InkWell(
                                    child: const TransactionItem(),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangeNotifierProvider.value(
                                            value: listOfTransaction[i],
                                            child:
                                                const TransactionOperationListPage(),
                                          ),
                                        ),
                                      );
                                    }),
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
