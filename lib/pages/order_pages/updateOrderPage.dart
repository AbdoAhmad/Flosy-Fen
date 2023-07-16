import 'package:flutter/material.dart';
import 'package:frist/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';

class UpdateOrderPage extends StatefulWidget {
  static const String routeName = "/update-order-page";
  const UpdateOrderPage({super.key});

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  final _companyNameController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _productPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _companyNameController.dispose();
    _productNameController.dispose();
    _productQuantityController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final currentOrder = Provider.of<Order>(context, listen: false);
    _companyNameController.text = currentOrder.companyName;
    _productNameController.text = currentOrder.productName;
    // _productQuantityController.text = currentOrder.productQuantity.toString();
    // _productPriceController.text = currentOrder.productPrice.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعديل طلب',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
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
                              color: Theme.of(context).primaryColor, width: 3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Colors.red.shade800, width: 3),
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
                child: TextFormField(
                  controller: _productNameController,
                  keyboardType: TextInputType.name,
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل اسم المنتج';
                    }
                    return null;
                  },
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
                              color: Theme.of(context).primaryColor, width: 3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Colors.red.shade800, width: 3),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Directionality(
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
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _productPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        cursorColor: Theme.of(context).primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل سعر المنتج';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabled: true,
                            hintText: "سعر المنتج",
                            alignLabelWithHint: true,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "سعر المنتج",
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
                  ),
                ],
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
                      "تعديل",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Align text centered
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final companyName = _companyNameController.text;
                      final productName = _productNameController.text;
                      // final productQuantity =
                      //     int.parse(_productQuantityController.text);
                      final productPrice =
                          double.parse(_productPriceController.text);
                      orderProvider.updateOrder(currentOrder.id, companyName,
                          productName, productPrice, DateTime.now());
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
