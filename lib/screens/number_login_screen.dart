import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';
import 'package:provider/provider.dart';

//pour pouvoir switcher de mode
enum AuthMode { Signup, Login }

class NumberLoginScreen extends StatefulWidget {
  const NumberLoginScreen({super.key});
  static const routeName = '/number-login';

  @override
  State<NumberLoginScreen> createState() => _NumberLoginScreenState();
}

class _NumberLoginScreenState extends State<NumberLoginScreen> {
  //pour nous permettre d'avoir acces au input du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey();
  //ici on defini le mode de base du formulaire le mode login
  AuthMode _authMode = AuthMode.Login;
  //stockons l'email et le mot de passe
  Map<String, String> _authData = {
    'phone_number': '',
    'password': '',
  };
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

  //ici nous envoyons les informations de notre fornulaire a notre serveur
  Future<void> _submit() async {
    //si notre formulaire n'est pas valide on ne faiit rien
    /*if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }*/
    // _formKey.currentState!.save();

    // try {
    if (_authMode == AuthMode.Login) {
      //logger l'utilisateur
      //print('Logger');
      await Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email'].toString(), _authData['password'].toString());
    } else {
      //enregistrer l'utilisateur
      print('Inscrit');
      await Provider.of<AuthProvider>(context, listen: false)
          .registerWithPhoneNumber(
            'kandza@kandza.com',
            'password',
          )
          .then(
              (_) => /*_showInscriptionDialog(
                _authData['email'].toString(),
                _authData['password'].toString(),
              ),*/
                  print('email, mot de passe'));
    }
    /*} on HttpExceptions catch (error) {
      var messageError = 'Erreur d\'authentification';
      /*if (error.toString().contains('Unauthorized')) {
        messageError = 'Email ou mot de passe incorrect, veuillez réessayer ';
      } else if (error
          .toString()
          .contains('The email has already been taken.')) {
        messageError =
            'Email déjà utilisé par un autre utilisateur, veuillez changer d’adresse email';
      } else {
        messageError = 'Probleme de connexion a votre compte';
      }
      _showErrorDialog(messageError);*/
    } catch (error) {
      // _showErrorDialog('une erreur s\'est produite veuillez reessayer');
      print('une erreur s\'est produite veuillez reessayer');
    }*/
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

                            //champs qui va s'afficher juste pour l'inscription
                            //champs qui va s'afficher juste pour l'inscription
                            //champs qui va s'afficher juste pour l'inscription
                            //champs qui va s'afficher juste pour l'inscription
                            _authMode == AuthMode.Signup
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: mediaQuery.size.width * 0.030),
                                    child: Row(
                                      children: [
                                        //input numero
                                        Expanded(
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              filled: true,
                                              hintText:
                                                  'Entrez votre mot de passe',
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: AppColor.appGrey,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                            ),
                                            /*onSaved: (value) => {
                                        _personnalData['nom'] = value!,
                                      },*/
                                            obscureText: true,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),

                            //fin des champs juste pour l'inscription
                            //fin des champs juste pour l'inscription
                            //fin des champs juste pour l'inscription
                            //fin des champs juste pour l'inscription
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
                                        onPressed: _submit,
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
