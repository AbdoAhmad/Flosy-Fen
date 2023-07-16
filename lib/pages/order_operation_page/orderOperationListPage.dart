import 'package:flutter/material.dart';
import 'package:frist/models/order.dart';
import 'package:frist/widgets/order_operation_widgets/order_operation_List.dart';
import 'package:provider/provider.dart';

import 'addOrderOperationPage.dart';

class OrderOperationListPage extends StatelessWidget {
  static const String routeName = "/order-operation-list-page";
  const OrderOperationListPage({super.key});

  
  

  @override
  Widget build(BuildContext context) {
    final operationProvider = Provider.of<Order>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الطلب"),
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
      body: const OrderOperationList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider.value(
              value: operationProvider,
              child: const AddOrderOperationPage(),
            ),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}