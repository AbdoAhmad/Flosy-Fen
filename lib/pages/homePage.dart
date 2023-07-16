import 'package:flutter/material.dart';
import 'package:frist/pages/order_pages/orderListPage.dart';
import 'package:frist/pages/product_pages/addProductPage.dart';
import 'package:frist/pages/product_pages/productListPage.dart';
import 'package:frist/pages/transaction_pages/AddTransactionPage.dart';
import 'package:frist/pages/transaction_pages/transactionListPage.dart';
import 'package:frist/providers/auth_provider.dart';
import 'package:frist/widgets/home_widgets/homeFloatingActionButton.dart';
import 'package:provider/provider.dart';
//import 'package:frist/widgets/home_widgets/homeSearchBar.dart';

import '../widgets/home_widgets/homeBottomNavigationBar.dart';
import 'order_pages/addOrderPage.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;
  final List<Map<String, dynamic>> _tabPages = [
    {
      "title": "معاملاتي",
      "page": const TransactionListPage(),
      "routeName": AddTransactionPage.routeName
    },
    {
      "title": "منتجاتي",
      "page": const ProductListPage(),
      "routeName": AddProductPage.routeName
    },
    {
      "title": "طلباتي",
      "page": const OrderListPage(),
      "routeName": AddOrderPage.routeName
    }
  ];

  void _selectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tabPages[_selectedPageIndex]["title"],
        ),
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
      drawer: Drawer(
          child: Column(
        children: [
          ListTile(
            title: Text("${authProvider.email}"),
          ),
          const Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text("تسجيل خروج"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
            ),
          ),
        ],
      )),
      body: _tabPages[_selectedPageIndex]["page"],
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedPageIndex: _selectedPageIndex,
        selectePage: _selectePage,
      ),
      floatingActionButton: HomeFloatingActionButton(
          routeName: _tabPages[_selectedPageIndex]["routeName"]),
    );
  }
}
