import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/widgets/auth_footer_widget.dart';
import 'package:tuma/widgets/login_header_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/signin-screen';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  //ici nous envoyons les informations de notre fornulaire a notre serveur
  void _submit() {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    Provider.of<AuthProvider>(context, listen: false).register(
        _authData['email'].toString(), _authData['password'].toString());
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
            height: mediaQuery.size.height * 0.33,
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
                          bottom: mediaQuery.size.height * 0.030),
                      child: Text(
                        'Inscrivez-vous',
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
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.020),
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
                          obscureText: true,
                          controller: _passwordController,
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
                    //confirmer le mot de passe//password
                    Container(
                      padding:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.020),
                      child: SizedBox(
                        width: mediaQuery.size.height * 0.42,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0XFFF6F5F5),
                            hintText: 'Confirmer le Mot de passe',
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
                              return 'Confirmation de mot de passe incorrect';
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
                          top: mediaQuery.size.height * 0.040,
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
                                child: const Text('Incription'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Texte de creation de compte
                    Container(
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Déjà membre??',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkResponse(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed('/login-screen'),
                            child: const Text(
                              '  Connectez-vous',
                              style: TextStyle(
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
