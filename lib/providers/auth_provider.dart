import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:tuma/models/user_model.dart';
import 'package:tuma/models/user_transaction_model.dart';
import 'package:tuma/test/user_test_model.dart';
import 'package:tuma/utillities/host.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? _firstname;
  String? _lastname;

  final String host = Host.host;

  bool get isAuth {
    return token != null;
  }

  // cette fonction nous permet de verifier si notre token est encore valide en regardant et en comparant sa date expiration a la date actuelle
  //pour un token avec date d'expiration
  String? get sectoken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //pour un token sans date d'expiration
  String? get token {
    if (_token != null) {
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

  //Phone number authetication
  //Phone number authetication
  //Phone number authetication
  //Phone number authetication
  Future<void> loginWithPhoneNumber(String phone, String password) async {
    //print('Make your login logic here');
    //on configure le headers
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    // This will be sent as form data in the post requst
    var map = Map<String, dynamic>();
    map['phone_number'] = phone;
    map['password'] = password;
    try {
      var url = Uri.parse(
        '$host/api/login',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);

      final responseData = json.decode(response.body);

      //print(responseData);
      //on checke d'abord si nous avons un erreur dans la recuperation de nos données
      if (responseData['message'] != null) {
        //print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      final token = responseData['authorization']['token'];

      _token = token;
      _userId = responseData['user']['id'].toString();
      _firstname = responseData['user']['firstname'].toString();
      _lastname = responseData['user']['lastname'].toString();

      //print('Your credential' + _userId.toString() + _token.toString());

      //ici on converti la date d'expiration du token en une date exploitable sur flutter

      notifyListeners();
      //ici nous allons sauvegarder nos donnees utilisateur localement
      final localStorage = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'firstname': _firstname,
          'lastname': _lastname,
        },
      );
      localStorage.setString('userData', userData);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

//ici on va s'enregistrer avec notre numero de telephone
  Future<void> registerWithPhoneNumber(String phone, String password) async {
    print('tu es dans le register provider');
    //on configure le headers
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['firstname'] = 'new';
    map['lastname'] = 'new';
    map['phone_number'] = phone;
    map['password'] = password;
    //map['password_confirmation'] = password;
    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/register',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      if (responseData['phone_number'] != null) {
        throw HttpExceptions(responseData['phone_number'].join());
      }
      //print(responseData['user'].toString() + ' its here');
      loginWithPhoneNumber(phone, password);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> seclogout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    notifyListeners();
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    print(_token);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //pour supprimer une donnees a la fois
    //prefs.remove('userData');

    // on supprime toutes les preferences de notre application stocker dans la memoire
    prefs.clear();
  }

  //Ici on fera la mise a jour du mot de passe de l'utilisateur

  Future<void> updateUserPassword(
      String oldPassword, String newPassword) async {
    //je recupere les donnees stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['old_password'] = oldPassword;
    map['new_password'] = newPassword;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/update-user-password',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        //print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //Ici on fera la mise a jour les informations personnelles de l'utilsateur de l'utilisateur

  Future<void> updateUserInfo(String nom, String prenom) async {
    //je recupere les donnees stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['firstname'] = prenom;
    map['lastname'] = nom;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/update-user-profile-info',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['errors'] != null) {
        print(responseData['errors']);
        throw HttpExceptions(responseData['errors']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //Ici on fera le transfert

  Future<void> makeTransfert(
      String n_destinataire, String montant, String password) async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['n_destinataire'] = n_destinataire;
    map['montant'] = montant;
    map['password'] = password;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/make-user-transfert',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['errors'] != null) {
        print(responseData['errors']);
        throw HttpExceptions(responseData['errors']);
      }
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //ici on recupere les informations d'un utilisateur
  Future<UserModel> getUser() async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    if (userData == null) {
      logout();
      return UserModel(
          userId: 0,
          firstname: '',
          lastname: '',
          solde: 0,
          phone_number: '',
          is_client: 0,
          is_agent: 0,
          is_admin: 0);
    }
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/get-user',
      );
      final response = await http.get(url, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['errors'] != null) {
        print(responseData['errors']);
        throw HttpExceptions(responseData['errors']);
      }
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
      return UserModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //ici on recupere les transactions d'un utilsateur
  /* Future<List<UserTransactionModel>> getUserTransactions() async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    //print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/get-user-client-transactions',
      );
      final response = await http.get(url, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print('les transactions');
      print(responseData);
      print('les transactions');
      /*if (responseData['errors'].toString() != null) {
        print(responseData['errors'].toString());
        throw HttpExceptions(responseData['errors'].toString());
      }
      if (responseData['message'].toString() != null) {
        print(responseData['message'].toString());
        throw HttpExceptions(responseData['message'].toString());
      }*/

      notifyListeners();
      return responseData.map((e) => UserTransactionModel.fromJson(e)).toList();
      //final List<UserTransactionModel> transactions = [];
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }*/

  Future<List<UserTransaction>> fetchTransactions() async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    if (userData == null) {
      logout();
      return [];
    }
    final updateToken = userData['token'];
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };
    var url = Uri.parse(
      '$host/api/get-user-client-transactions',
    );
    final response = await http.get(url, headers: requestHeaders);
    ;
    List<dynamic> result = json.decode(response.body);
    // result.forEach((element) {
    //   print(element['montant']);
    // });
    List<UserTransaction> listTransactions = [];
    if (response.statusCode == 200) {
      /*listTransactions =
          result.map((e) => UserTransactionModel.fromJson(e)).toList();
      listTransactions.forEach((element) {
        print(element.montant);
      });*/
      print(response.body);
      result.forEach((element) {
        listTransactions.add(
          UserTransaction(
            userId: element['id'],
            transaction_id: element['transaction_id'],
            n_expediteur: element['n_expediteur'],
            n_destinataire: element['n_destinataire'],
            montant: element['montant'],
            statut: element['statut'],
            is_transfert: element['is_transfert'],
            is_depot: element['is_depot'],
            is_retrait: element['is_retrait'],
            date_transactions: DateFormat('y-M-d H:m:s').parse(
              element['date_transactions'],
            ),
            expediteur_firstname: element['expediteur_firstname'],
            expediteur_phone_number: element['expediteur_phone_number'],
            destinataire_firstname: element['destinataire_firstname'],
            destinataire_phone_number: element['destinataire_phone_number'],
          ),
        );
      });
      // listTransactions.forEach((element) {
      //   print(element.montant.toString() + ' icici');
      // });
      notifyListeners();
      return listTransactions;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Ici on va annuler un transfert effecté

  Future<void> cancelTransfert(String transaction_id) async {
    //je recupere les donnees stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['transaction_id'] = transaction_id;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/cancel-user-transfert',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  ////////////
  ////////////
  //////////
  //ici on va effectuer les transactions agent

  //depot a un utilisateur
  Future<void> makeDepot(
      String n_destinataire, String montant, String password) async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['n_destinataire'] = n_destinataire;
    map['montant'] = montant;
    map['password'] = password;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/make-user-depot',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['errors'] != null) {
        print(responseData['errors']);
        throw HttpExceptions(responseData['errors']);
      }
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //depot a un utilisateur
  Future<void> initializeRetrait(
      String n_destinataire, String montant, String password) async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['n_destinataire'] = n_destinataire;
    map['montant'] = montant;
    map['password'] = password;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/initialize-user-retrait',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['errors'] != null) {
        print(responseData['errors']);
        throw HttpExceptions(responseData['errors']);
      }
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<List<UserTransaction>> fetchRetraitTransactions() async {
    //je recupere le token stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    if (userData == null) {
      logout();
      return [];
    }
    final updateToken = userData['token'];
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };
    var url = Uri.parse(
      '$host/api/get-user-retrait-initialize',
    );
    final response = await http.get(url, headers: requestHeaders);
    ;
    List<dynamic> result = json.decode(response.body);
    // result.forEach((element) {
    //   print(element['montant']);
    // });
    List<UserTransaction> listTransactions = [];
    if (response.statusCode == 200) {
      /*listTransactions =
          result.map((e) => UserTransactionModel.fromJson(e)).toList();
      listTransactions.forEach((element) {
        print(element.montant);
      });*/
      print('////////////////\n\n');
      print(response.body);
      result.forEach((element) {
        listTransactions.add(
          UserTransaction(
            userId: element['id'],
            transaction_id: element['transaction_id'],
            n_expediteur: element['n_expediteur'],
            n_destinataire: element['n_destinataire'],
            montant: element['montant'],
            statut: element['statut'],
            is_transfert: element['is_transfert'],
            is_depot: element['is_depot'],
            is_retrait: element['is_retrait'],
            date_transactions: DateFormat('y-M-d H:m:s').parse(
              element['date_transactions'],
            ),
            expediteur_firstname: 'empty',
            expediteur_phone_number: 'empty',
            destinataire_firstname: 'empty',
            destinataire_phone_number: 'empty',
          ),
        );
      });
      // listTransactions.forEach((element) {
      //   print(element.montant.toString() + ' icici');
      // });
      notifyListeners();
      return listTransactions;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Ici on va annuler un transfert effecté

  Future<void> validateUserRetrait(String transaction_id) async {
    //je recupere les donnees stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['transaction_id'] = transaction_id;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/validate-user-retrait',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //Ici on va annuler un transfert effecté

  Future<void> invalidateUserRetrait(String transaction_id) async {
    //je recupere les donnees stocker localement
    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    final updateToken = userData['token'];
    print(userData['token']);
    //header
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $updateToken"
    };

    //on cree un map pour stocker toutes nos donnees
    var map = Map<String, dynamic>();
    map['transaction_id'] = transaction_id;

    try {
      //on initialise l'url
      var url = Uri.parse(
        '$host/api/invalidate-user-retrait',
      );
      final response = await http.post(url, body: map, headers: requestHeaders);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        print(responseData['message']);
        throw HttpExceptions(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
