import 'package:flutter/material.dart';
import 'package:frist/models/order.dart';
import 'package:provider/provider.dart';

class AddOrderOperationPage extends StatefulWidget {
  static const routeName = "/add-Order-operation-page";
  const AddOrderOperationPage({super.key});

  @override
  State<AddOrderOperationPage> createState() => _AddOrderOperationPageState();
}

class _AddOrderOperationPageState extends State<AddOrderOperationPage> {
  final _productQuantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final operationProvider = Provider.of<Order>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اضف عملية',
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
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _productQuantityController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل الكمية';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabled: true,
                        hintText: "الكمية",
                        alignLabelWithHint: true,
                        label: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "الكمية",
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
                              color: Theme.of(context).primaryColor, width: 3),
                        ),
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
                      textAlign: TextAlign.center, // Align text centered
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final productQuantity =
                          int.parse(_productQuantityController.text);
                      await operationProvider.addOrderOperation(
                        productQuantity,
                        DateTime.now(),
                      );
                      if (context.mounted) Navigator.of(context).pop();
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
