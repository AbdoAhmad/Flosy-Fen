import 'package:flutter/material.dart';
import 'package:frist/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  static const routeName = "/add-product-page";
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _cmmfController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _cmmfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اضف منتج',
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _nameController,
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
                      child: TextFormField(
                        controller: _cmmfController,
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).primaryColor,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains(".")) {
                            return 'من فضلك أدخل CMMF';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabled: true,
                            hintText: "CMMF",
                            alignLabelWithHint: true,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "CMMF",
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
                      child: TextFormField(
                        controller: _priceController,
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
                            _isLoading = true;

                            final name = _nameController.text;
                            final cmmf = _cmmfController.text;
                            final price = double.parse(_priceController.text);

                            try {
                              await productProvider.addProduct(name, cmmf, price);
                          
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("خطأ"),
                                      content: const Text("حدث خطأ"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("تم"),
                                        )
                                      ],
                                    );
                                  });
                            } finally {
                              _isLoading = false;
                              Navigator.of(context).pop();
                            }
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
