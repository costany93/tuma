import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:tuma/utillities/host.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  final String host = Host.host;

  bool get isAuth {
    return token != null;
  }

  // cette fonction nous permet de verifier si notre token est encore valide en regardant et en comparant sa date expiration a la date actuelle
  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //ici nous retournons l'id de l'utilisateur
  String get userId {
    return _userId.toString();
  }

  Future<void> login(String email, String password) async {
    //print('Make your login logic here');
    // This will be sent as form data in the post requst
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    try {
      var url = Uri.parse(
        '$host/api/auth/login',
      );
      final response = await http.post(url, body: map
          /* body: json.encode(
        {'email': email, 'password': password},
      ), */
          );

      final responseData = json.decode(response.body);
      final token = responseData['access_token'];
      //print(responseData['error']);
      //on checke d'abord si nous avons un erreur dans la recuperation de notre token afin de recuperer notre utilisateur
      if (responseData['error'] != null) {
        throw HttpExceptions(responseData['error']);
      }

      //ici nous recuperons les informations sur l'utilisateur
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };
      url = Uri.parse(
        '$host/api/auth/profile',
      );
      final getUser = await http.post(url, headers: requestHeaders);
      final userJson = json.decode(getUser.body);
      _token = token;
      _userId = userJson['id'].toString();
      //ici on converti la date d'expiration du token en une date exploitable sur flutter
      _expiryDate = DateTime.now().add(
          Duration(seconds: int.parse(responseData['expires_in'].toString())));
      print(userJson);

      notifyListeners();
      //ici nous allons sauvegarder nos donnees utilisateur localement
      final localStorage = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      localStorage.setString('userData', userData);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> register(String email, String password) async {
    var map = Map<String, dynamic>();
    map['name'] = 'new user';
    map['email'] = email;
    map['password'] = password;
    map['password_confirmation'] = password;
    try {
      var url = Uri.parse(
        '$host/api/auth/register',
      );
      final response = await http.post(url, body: map);
      final responseData = json.decode(response.body);
      if (responseData['email'] != null) {
        throw HttpExceptions(responseData['email'].join());
      }
      print(responseData['user']);
      //login(email, password);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    notifyListeners();
  }
}
