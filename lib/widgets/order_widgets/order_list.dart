import 'package:flutter/material.dart';
import 'package:frist/models/order.dart';
import 'package:frist/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../../pages/order_operation_page/orderOperationListPage.dart';
import 'order_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderProvider>(context, listen: false).getAllOrder(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<OrderProvider>(
            builder: (context, orderProvider, child) {
              final List<Order> listOfOrder = orderProvider.listOfOrder;
              return listOfOrder.isEmpty
                  ? const Center(
                      child: Text('ليس لديك أي طلبات من فضلك أضف طلب',
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
                            itemCount: listOfOrder.length,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: listOfOrder[i],
                              child: Dismissible(
                                key: ValueKey(listOfOrder[i]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async {
                                  await orderProvider
                                      .deleteOrder(listOfOrder[i].id);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text('تم مسح الطلب  بنجاح'),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                            label: "استرجاع الطلب",
                                            onPressed: () async =>
                                               await orderProvider.insertOrder(
                                                    i, listOfOrder[i])),
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
                                    child: const OrderItem(),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangeNotifierProvider.value(
                                            value: listOfOrder[i],
                                            child:
                                                const OrderOperationListPage(),
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
