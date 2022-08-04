import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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

  void signIn(String email, String password) {
    print(email);
    print(password);
  }

  Future<void> login(String email, String password) async {
    //print('Make your login logic here');
    // This will be sent as form data in the post requst
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    var url = Uri.parse(
      'http://localhost:8000/api/auth/login',
    );
    final response = await http.post(url, body: map
        /* body: json.encode(
        {'email': email, 'password': password},
      ), */
        );

    final responseData = json.decode(response.body);
    print('before data');
    print(responseData['access_token']);
    final token = responseData['access_token'];
    print('after data ');
    //ici nous recuperons les informations sur l'utilisateur
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };
    url = Uri.parse(
      'http://localhost:8000/api/auth/profile',
    );
    final response2 = await http.post(url, headers: requestHeaders);
    final response2t = json.decode(response2.body);
    print('after data ');
    print(response2t);
    notifyListeners();
  }
}
