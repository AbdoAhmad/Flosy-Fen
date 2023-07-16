import 'package:flutter/material.dart';
import 'package:frist/pages/auth_pages/authPage.dart';
import 'package:frist/pages/auth_pages/splashPage.dart';
//import 'package:frist/pages/auth_pages/otpPage.dart';
import 'package:frist/pages/homePage.dart';
import 'package:frist/pages/order_operation_page/addOrderOperationPage.dart';
import 'package:frist/pages/order_operation_page/orderOperationListPage.dart';
import 'package:frist/pages/transaction_operation_pages/addTransactionOperationPage.dart';
import 'package:frist/pages/transaction_operation_pages/transactionOperationListPage.dart';
import 'package:frist/pages/order_pages/addOrderPage.dart';
import 'package:frist/pages/order_pages/orderListPage.dart';
import 'package:frist/pages/product_pages/addProductPage.dart';
import 'package:frist/pages/product_pages/productListPage.dart';
import 'package:frist/pages/product_pages/updateProductPage.dart';
import 'package:frist/pages/transaction_pages/AddTransactionPage.dart';
import 'package:frist/pages/transaction_pages/transactionListPage.dart';
import 'package:frist/providers/auth_provider.dart';
import 'package:frist/providers/order_provider.dart';
import 'package:frist/providers/product_provider.dart';
import 'package:frist/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (context) => ProductProvider(),
          update: (BuildContext context, authProvider,
                  ProductProvider? previousProductProvider) =>
              ProductProvider(
                  authProvider.token,
                  authProvider.userId,
                  previousProductProvider == null
                      ? []
                      : previousProductProvider.listOfProduct),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TransactionProvider>(
          create: (_) => TransactionProvider(),
          update: (BuildContext context, authProvider,
                  TransactionProvider? previousTransactionProvider) =>
              TransactionProvider(
                  authProvider.token,
                  authProvider.userId,
                  previousTransactionProvider == null
                      ? []
                      : previousTransactionProvider.listOfTransaction),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (_) => OrderProvider(),
          update: (BuildContext context, authProvider,
                  OrderProvider? previousOrderProvider) =>
              OrderProvider(
                  authProvider.token,
                  authProvider.userId,
                  previousOrderProvider == null
                      ? []
                      : previousOrderProvider.listOfOrder),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => MaterialApp(
          title: 'Flutter Demo ${authProvider.isAuth}',
          theme: ThemeData(
            primaryColor: Colors.black,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            primaryIconTheme: const IconThemeData(color: Colors.white),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: authProvider.isAuth
              ? const HomePage()
              : FutureBuilder(
                  future: authProvider.autoLogIn(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const SplashPage()
                          : const AuthPage()),
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            TransactionListPage.routeName: (context) =>
                const TransactionListPage(),
            AddTransactionPage.routeName: (context) =>
                const AddTransactionPage(),
            TransactionOperationListPage.routeName: (context) =>
                const TransactionOperationListPage(),
            AddTransactionOperationPage.routeName: (context) =>
                const AddTransactionOperationPage(),
            OrderListPage.routeName: (context) => const OrderListPage(),
            AddOrderPage.routeName: (context) => const AddOrderPage(),
            OrderOperationListPage.routeName: (context) =>
                const OrderOperationListPage(),
            AddOrderOperationPage.routeName: (context) =>
                const AddOrderOperationPage(),
            ProductListPage.routeName: (context) => const ProductListPage(),
            AddProductPage.routeName: (context) => const AddProductPage(),
            UpdateProductPage.routeName: (context) => const UpdateProductPage(),
            AuthPage.routeName: (context) => const AuthPage(),
            //OtpPage.routeName: (context) => const OtpPage(),
          },
        ),
      ),
    );
  }
}
