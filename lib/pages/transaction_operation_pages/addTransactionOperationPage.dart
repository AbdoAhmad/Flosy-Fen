import 'package:flutter/material.dart';
import 'package:frist/models/transaction.dart';
import 'package:provider/provider.dart';

class AddTransactionOperationPage extends StatefulWidget {
  static const routeName = "/add-tansaction-operation-page";

  const AddTransactionOperationPage({super.key});

  @override
  State<AddTransactionOperationPage> createState() =>
      _AddTransactionOperationPageState();
}

class _AddTransactionOperationPageState
    extends State<AddTransactionOperationPage> {
  final _takenMoneyController = TextEditingController();
  final _gavenMoneyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _takenMoneyController.dispose();
    _gavenMoneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionOperationProvider =
        Provider.of<Transaction>(context, listen: false);
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _gavenMoneyController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        cursorColor: Theme.of(context).primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل المبلغ المعطى';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabled: true,
                            hintText: "المبلغ المعطى",
                            alignLabelWithHint: true,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "المبلغ المعطى",
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
                        controller: _takenMoneyController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        cursorColor: Theme.of(context).primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل المبلغ المأخوذ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabled: true,
                            hintText: "المبلغ المأخوذ",
                            alignLabelWithHint: true,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "المبلغ المأخوذ",
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
                      final takenMoney =
                          double.parse(_takenMoneyController.text);
                      final gavenMoney =
                          double.parse(_gavenMoneyController.text);
                      await transactionOperationProvider
                          .addTransactionOperation(
                              takenMoney, gavenMoney, DateTime.now());
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
