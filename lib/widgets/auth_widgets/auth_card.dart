//import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:frist/pages/auth_pages/otpPage.dart';
import 'package:frist/providers/auth_provider.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text("هناك خطأ"),
                content: Text(message),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("حسناً"))
                ],
              ),
            ));
  }

  Future<void> _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await authProvider.logIn(_authData['email']!, _authData['password']!);
        authProvider.setEmail = _authData['email']!;
      } else {
        // Sign user up
        await authProvider.signUp(_authData['email']!, _authData['password']!);
        authProvider.setEmail = _authData['email']!;
      }
    } catch (error) {
      String errorMessage = "حدث خطأء";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "البريد الإلكتروني موجود بالفعل";
      } else if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
        errorMessage = "حدث خطأ حاول في وقت لاحق";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "البريد الإلكتروني غير موجود ";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "كلمة المرور ليست صحيحة";
      }
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'البريد الإلكتروني'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'البريد الإلكتروني خاطئ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'كلمة المرور'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'كلمة المرور قصيرة للغاية';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          const InputDecoration(labelText: 'تأكيد كلمة المرور'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'لا يوجد تطابق';
                              }
                              return null;
                            }
                          : null,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white),
                          onPressed: _submit,
                          child: Text(_authMode == AuthMode.Login
                              ? 'تسجيل دخول'
                              : 'مستخدم جديد'),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _switchAuthMode,
                    child: Text(_authMode == AuthMode.Login
                        ? 'مستخدم جديد'
                        : 'تسجيل دخول'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
