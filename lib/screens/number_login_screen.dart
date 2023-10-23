import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';

//pour pouvoir switcher de mode
enum AuthMode { Signup, Login }

class NumberLoginScreen extends StatefulWidget {
  const NumberLoginScreen({super.key});
  static const routeName = '/number-login';

  @override
  State<NumberLoginScreen> createState() => _NumberLoginScreenState();
}

class _NumberLoginScreenState extends State<NumberLoginScreen> {
  //ici on defini le mode de base du formulaire le mode login
  AuthMode _authMode = AuthMode.Login;
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
          ),
          child: Column(
            children: [
              //la zone du logo d'en haut occupe 35% de l'ecran
              Container(
                height: mediaQuery.size.height * 0.35,
                child: Align(
                  child: Image.asset(
                    LogoImage.imageLogoPath,
                    height: mediaQuery.size.height * 0.2,
                  ),
                ),
              ),
              //zone du bas du formulaire et du bouton occupera 65% de l'ecran
              Container(
                child: Column(
                  children: [
                    //texte numero de telephone
                    Text(
                      'Numéro de téléphone',
                      style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.05,
                      ),
                    ),
                    //Input formulaire du numero de telephone
                    Container(
                      width: mediaQuery.size.width,
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.width * 0.15),
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.07),
                      child: Form(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //input +221
                                SizedBox(
                                  width: mediaQuery.size.width * 0.2,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      hintText: '+221',
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(
                                        color: AppColor.appGrey,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12),
                                    ),
                                    /*onSaved: (value) => {
                                      _personnalData['nom'] = value!,
                                    },*/

                                    keyboardType: TextInputType.phone,
                                    enabled: false,
                                  ),
                                ),
                                //input numero
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      hintText: '78 000 00 00',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppColor.appGrey,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12),
                                    ),
                                    /*onSaved: (value) => {
                                      _personnalData['nom'] = value!,
                                    },*/
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //button d'inscription
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
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () => print(
                                            'Inscription reussi effectue'),
                                        child: Text(
                                          _authMode == AuthMode.Login
                                              ? 'Connexion'
                                              : 'Inscription',
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Texte de creation de compte
                            Container(
                              margin: EdgeInsets.only(
                                  top: /*_authMode == AuthMode.Login
                                ? mediaQuery.size.height * 0.015
                                : mediaQuery.size.height * 0.005*/
                                      mediaQuery.size.height * 0.015),
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
                                    onTap:
                                        _switchAuthMode /*() =>
                                        print('tu as switcher de mode')*/
                                    ,
                                    child: Text(
                                      _authMode == AuthMode.Login
                                          ? '  Inscrivez-vous'
                                          : '  Connectez-vous' /*' Inscrivez-vous'*/,
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
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
