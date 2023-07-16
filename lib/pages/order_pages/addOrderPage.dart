import 'package:flutter/material.dart';
import 'package:frist/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/order_provider.dart';

class AddOrderPage extends StatefulWidget {
  static const String routeName = "/add-order-page";
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _companyNameController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productQuantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _companyNameController.dispose();
    _productNameController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اضف طلب',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false)
              .getAllProduct(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                final List<Product> listOfProduct =
                    productProvider.listOfProduct;
             
                String? dropdownValue =
                    listOfProduct.isEmpty ? null : listOfProduct.first.name;
                String productId = "";
             
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _companyNameController,
                            keyboardType: TextInputType.name,
                            cursorColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك أدخل اسم صاحب الطلب';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabled: true,
                                hintText: "اسم صاحب الطلب",
                                alignLabelWithHint: true,
                                label: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "اسم صاحب الطلب",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 3)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.red.shade800, width: 3),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 3))),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                enabled: true,
                                hintText: "اسم المنتج",
                                alignLabelWithHint: true,
                                label: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "اسم المنتج",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 3)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.red.shade800, width: 3),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 3))),
                            value: dropdownValue,
                            disabledHint: const Text("اسم المنتج"),
                            onChanged: listOfProduct.isEmpty
                                ? null
                                : (String? newValue) {
                                    dropdownValue = newValue;
                                  },
                            items: listOfProduct.map<DropdownMenuItem<String>>(
                                (Product product) {
                              productId = product.id;
                              return DropdownMenuItem<String>(
                                value: product.name,
                                child: Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _productQuantityController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            cursorColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك ادخل كمية المنتج';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabled: true,
                                hintText: "كمية المنتج",
                                alignLabelWithHint: true,
                                label: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "كمية المنتج",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 5),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 3))),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white),
                            icon: const Icon(
                              Icons.add,
                            ),
                            label: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "إضافة",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign:
                                    TextAlign.center, // Align text centered
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final companyName = _companyNameController.text;
                                final productName = dropdownValue.toString();
                                final productQuantity =
                                    int.parse(_productQuantityController.text);
                                final Product product =
                                    productProvider.getProduct(productId);
                                final double productPrice = product.price;
                                await orderProvider.addOrder(companyName,
                                    productName, productPrice, productQuantity);
                                if (context.mounted)
                                  Navigator.of(context).pop();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
            }
          }),
    );
  }
}
