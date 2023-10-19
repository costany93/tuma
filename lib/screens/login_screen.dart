import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';

import 'package:tuma/widgets/auth_footer_widget.dart';
import 'package:tuma/widgets/login_header_widget.dart';

//pour pouvoir switcher de mode
enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  //pour afficher une boite de dialog de nos erreurs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Oops'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ok '),
          )
          /*FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ok '))*/
        ],
      ),
    );
  }

  //pour afficher une boite de dialog de nos erreurs
  void _showInscriptionDialog(String email, String password) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Genial',
          style: TextStyle(color: AppColor.appGreen),
        ),
        content: Text('Inscription réussie avec succès'),
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).login(
                    _authData['email'].toString(),
                    _authData['password'].toString());

                Navigator.of(context).pop();
              },
              child: const Text(
                'Je me connecte',
                style: TextStyle(color: AppColor.appGreen),
              )),
          /*FlatButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).login(
                    _authData['email'].toString(),
                    _authData['password'].toString());

                Navigator.of(context).pop();
              },
              child: const Text(
                'Je me connecte',
                style: TextStyle(color: AppColor.appGreen),
              ))*/
        ],
      ),
    );
  }

  //ici nous envoyons les informations de notre fornulaire a notre serveur
  Future<void> _submit() async {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    try {
      if (_authMode == AuthMode.Login) {
        //logger l'utilisateur
        //print('Logger');
        await Provider.of<AuthProvider>(context, listen: false).login(
            _authData['email'].toString(), _authData['password'].toString());
      } else {
        //enregistrer l'utilisateur
        //print('Inscrit');
        await Provider.of<AuthProvider>(context, listen: false)
            .register(
                _authData['email'].toString(), _authData['password'].toString())
            .then((_) => _showInscriptionDialog(_authData['email'].toString(),
                _authData['password'].toString()));
      }
    } on HttpExceptions catch (error) {
      var messageError = 'Erreur d\'authentification';
      if (error.toString().contains('Unauthorized')) {
        messageError = 'Email ou mot de passe incorrect, veuillez réessayer ';
      } else if (error
          .toString()
          .contains('The email has already been taken.')) {
        messageError =
            'Email déjà utilisé par un autre utilisateur, veuillez changer d’adresse email';
      } else {
        messageError = 'Probleme de connexion a votre compte';
      }
      _showErrorDialog(messageError);
    } catch (error) {
      _showErrorDialog('une erreur s\'est produite veuillez reessayer');
    }
  }

  final _passwordController = TextEditingController();

  //nous permet de switcher de mode
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          //header
          Container(
            height: _authMode == AuthMode.Login
                ? mediaQuery.size.height * 0.4
                : mediaQuery.size.height * 0.33,
            width: mediaQuery.size.width * 1,
            child: LoginHeaderWidget(
              mediaQuery: mediaQuery,
            ),
          ),

          //section formulaire
          Form(
            key: _formKey,
            child: Container(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          bottom: _authMode == AuthMode.Login
                              ? mediaQuery.size.height * 0.045
                              : mediaQuery.size.height * 0.030),
                      child: Text(
                        _authMode == AuthMode.Login
                            ? 'Connectez-vous'
                            : 'Inscrivez-vous',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w100,
                            fontSize: mediaQuery.size.height * 0.025),
                      ),
                    ),
                    // email input
                    SizedBox(
                      width: mediaQuery.size.height * 0.42,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.appFillLoginColor,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w200,
                              fontSize: mediaQuery.size.height * 0.016,
                              color: AppColor.appGrey),
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: AppColor.appFillLoginColor, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: AppColor.appFillLoginColor, width: 0.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: AppColor.appRed, width: 0.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: AppColor.appRed, width: 0.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return 'L\'Email est invalide';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                      ),
                    ),

                    //password
                    Container(
                      margin: EdgeInsets.only(
                          top: _authMode == AuthMode.Login
                              ? mediaQuery.size.height * 0.045
                              : mediaQuery.size.height * 0.020),
                      child: SizedBox(
                        width: mediaQuery.size.height * 0.42,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.appFillLoginColor,
                            hintText: 'Mot de passe',
                            hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w200,
                                fontSize: mediaQuery.size.height * 0.016,
                                color: AppColor.appGrey),
                            contentPadding: const EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: AppColor.appFillLoginColor,
                                  width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: AppColor.appFillLoginColor,
                                  width: 0.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: AppColor.appRed, width: 0.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: AppColor.appRed, width: 0.0),
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Le mot de passe est trop court!';
                            }
                            //return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),
                      ),
                    ),
                    //confirmer le mot de passe en mode signup
                    if (_authMode == AuthMode.Signup)
                      Container(
                        padding: EdgeInsets.only(
                            top: mediaQuery.size.height * 0.020),
                        child: SizedBox(
                          width: mediaQuery.size.height * 0.42,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.appFillLoginColor,
                              hintText: 'Confirmer le mot de passe',
                              hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w200,
                                  fontSize: mediaQuery.size.height * 0.016,
                                  color: AppColor.appGrey),
                              contentPadding: const EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: AppColor.appFillLoginColor,
                                    width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: AppColor.appFillLoginColor,
                                    width: 0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: AppColor.appRed, width: 0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: AppColor.appRed, width: 0.0),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Confirmation du mot de passe incorrect';
                              }
                              //return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value!;
                            },
                          ),
                        ),
                      ),

                    //Bouton de connexion
                    Container(
                      margin: EdgeInsets.only(
                          top: _authMode == AuthMode.Login
                              ? mediaQuery.size.height * 0.055
                              : mediaQuery.size.height * 0.040,
                          bottom: mediaQuery.size.height * 0.025),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      AppColor.appBleu1,
                                      AppColor.appBleu2,
                                      AppColor.appBleu3,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mediaQuery.size.height * 0.25,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  primary: AppColor.appWhite,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: _submit,
                                child: Text(_authMode == AuthMode.Login
                                    ? 'Connexion'
                                    : 'Incription'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Texte de creation de compte
                    Container(
                      margin: EdgeInsets.only(
                          top: _authMode == AuthMode.Login
                              ? mediaQuery.size.height * 0.015
                              : mediaQuery.size.height * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _authMode == AuthMode.Login
                                ? 'Pas de compte?'
                                : 'Déjà membre?',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkResponse(
                            onTap: _switchAuthMode,
                            child: Text(
                              _authMode == AuthMode.Login
                                  ? '  Inscrivez-vous'
                                  : '  Connectez-vous',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: AppColor.appBleu4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    //footer
                  ],
                ),
              ),
            ),
          ),
          //footer
          AuthFooterWidget(mediaQuery: mediaQuery),
        ],
      ),
    );
  }
}
