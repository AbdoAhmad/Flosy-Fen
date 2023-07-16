import 'package:flutter/material.dart';

import '../../widgets/product_widgets/product_list.dart';

class ProductListPage extends StatelessWidget {
  static const String routeName = "/item-list-page";
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductList();
  }
}
