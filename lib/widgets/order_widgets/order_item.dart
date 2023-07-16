import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      " صاحب الطلب : ${order.companyName}",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " المنتج : ${order.productName}",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " الكمية : ${order.totalProductQuantity}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " إجمالي السعر : ${order.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " بتاريخ : ${order.finalFormattedDate}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // trailing: IconButton(
              //   onPressed: () => Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (BuildContext context) =>
              //           ChangeNotifierProvider.value(
              //         value: order,
              //         child: const UpdateOrderPage(),
              //       ),
              //     ),
              //   ),
              //   icon: const Icon(
              //     Icons.edit,
              //     color: Colors.white,
              //   ),
              // ),
            ),
          )),
    );
  }
}
