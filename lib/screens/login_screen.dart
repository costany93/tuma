import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';

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

  //ici nous envoyons les informations de notre fornulaire a notre serveur
  void _submit() {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    if (_authMode == AuthMode.Login) {
      //logger l'utilisateur
      //print('Logger');
      Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email'].toString(), _authData['password'].toString());
    } else {
      //enregistrer l'utilisateur
      print('Inscrit');
      Provider.of<AuthProvider>(context, listen: false).signIn(
          _authData['email'].toString(), _authData['password'].toString());
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
                          fillColor: const Color(0XFFF6F5F5),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w200,
                              fontSize: mediaQuery.size.height * 0.016,
                              color: Colors.grey),
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color(0XFFF6F5F5), width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color(0XFFF6F5F5), width: 0.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0.0),
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
                            fillColor: Color(0XFFF6F5F5),
                            hintText: 'Mot de passe',
                            hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w200,
                                fontSize: mediaQuery.size.height * 0.016,
                                color: Colors.grey),
                            contentPadding: const EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Color(0XFFF6F5F5), width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Color(0XFFF6F5F5), width: 0.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 0.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 0.0),
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
                              fillColor: Color(0XFFF6F5F5),
                              hintText: 'Confirmer le mot de passe',
                              hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w200,
                                  fontSize: mediaQuery.size.height * 0.016,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Color(0XFFF6F5F5), width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Color(0XFFF6F5F5), width: 0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 0.0),
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
                                      Color(0xFF12CFC9),
                                      Color(0xFF16E1DF),
                                      Color(0xFF12CFC9),
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
                                  primary: Colors.white,
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
                                color: Color(0XFF13D0CA),
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
