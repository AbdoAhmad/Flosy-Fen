import 'package:flutter/material.dart';

import 'package:frist/widgets/product_widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/product_provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ProductProvider>(context, listen: false).getAllProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              final List<Product> listOfProduct = productProvider.listOfProduct;
              return listOfProduct.isEmpty
                  ? const Center(
                      child: Text('ليس لديك أي منتجات من فضلك أضف منتجاتك',
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
                            itemCount: listOfProduct.length,
                            itemBuilder: (context, i) =>
                                ChangeNotifierProvider.value(
                              value: listOfProduct[i],
                              child: Dismissible(
                                key: ValueKey(listOfProduct[i]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) async {
                                  await productProvider
                                      .deleteProduct(listOfProduct[i].id);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text('تم مسح المنتج بنجاح'),
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                            label: "استرجاع المنتج",
                                            onPressed: () async =>
                                                await productProvider
                                                    .insertProduct(
                                                        i, listOfProduct[i])),
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
                                child: const ProductItem(),
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
