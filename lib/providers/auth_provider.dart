import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token = "";
  DateTime? _expiredDate = DateTime(-1);
  String? _userId = "";
  String _email = "";
  bool get isAuth {
    
    return token != null;
  }

  set setEmail(String email) {
    _email = email;
  }

  String? get token {
    if (_token!.isNotEmpty &&
        _expiredDate!.year != -1 &&
        _expiredDate!.isAfter(DateTime.now())) return _token;
    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get email {
    return _email;
  }

  Future<void> signUp(String userEmail, String userPassword) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDxTM8FS-WljD8UypIGyLVt5pVsxQjxNe8');

      final response = await http.post(url,
          body: json.encode({
            'email': userEmail,
            'password': userPassword,
            'returnSecureToken': true
          }));

      final authData = json.decode(response.body) as Map<String, dynamic>;
      if (authData["error"] != null) throw authData["error"]["message"];

      _token = authData['idToken'];
      _userId = authData['localId'];
      _expiredDate = DateTime.now()
          .add(Duration(seconds: int.parse(authData['expiresIn'])));
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiredDate!.toIso8601String()
      });
      prefs.setString("userData", userData);
      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> logIn(String userEmail, String userPassword) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDxTM8FS-WljD8UypIGyLVt5pVsxQjxNe8');
      final response = await http.post(url,
          body: json.encode({
            'email': userEmail,
            'password': userPassword,
            'returnSecureToken': true
          }));

      final authData = json.decode(response.body) as Map<String, dynamic>;
      if (authData["error"] != null) throw authData["error"]["message"];

      _token = authData['idToken'];
      _userId = authData['localId'];
      _expiredDate = DateTime.now()
          .add(Duration(seconds: int.parse(authData['expiresIn'])));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiredDate!.toIso8601String()
      });

      prefs.setString("userData", userData);
    } catch (error) {
      
      throw error.toString();
    }
  }

  Future<bool> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;
    final extractedUserData = prefs.getString("userData");
    final userData = json.decode(extractedUserData!) as Map<String, dynamic>;
    _expiredDate = DateTime.parse(userData["expiryDate"]);
    if (_expiredDate!.isBefore(DateTime.now())) return false;
    _token = userData["token"];
    _userId = userData["userId"];
    notifyListeners();
    return true;
  }

  Future<void> logOut() async {
    _token = "";
    _expiredDate = DateTime(-1);
    _userId = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
