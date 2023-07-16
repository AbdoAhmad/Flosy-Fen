import 'package:flutter/material.dart';
import 'package:frist/models/order.dart';
import 'package:frist/models/orderOperation.dart';
import 'package:provider/provider.dart';

import 'order_operation_item.dart';

class OrderOperationList extends StatelessWidget {
  const OrderOperationList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Order>(context, listen: false).getAllOrderOperation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<Order>(
            builder: (context, orderOperationProvider, child) {
              final List<OrderOperation> listOfOrderOperation =
                  orderOperationProvider.listOfOrderOperation;
              return listOfOrderOperation.isEmpty
                  ? const Center(
                      child: Text(
                          'ليس لديك أي عمليات من فضلك أضف طلبات من الشركة علي هذا المنتج',
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
                            itemCount: listOfOrderOperation.length,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: listOfOrderOperation[i],
                              child: Dismissible(
                                key: ValueKey(listOfOrderOperation[i]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async {
                                  await orderOperationProvider
                                      .deleteOrderOperation(
                                          listOfOrderOperation[i].id);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text('تم مسح الطلب  بنجاح'),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                            label: "استرجاع الطلب",
                                            onPressed: () async =>
                                                await orderOperationProvider
                                                    .insertOrderOperation(
                                                        i,
                                                        listOfOrderOperation[
                                                            i])),
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
                                child: const OrderOperationItem(),
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
