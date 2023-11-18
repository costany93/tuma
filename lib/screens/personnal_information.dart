import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/models/user_model.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/widgets/setting_cart_widget.dart';

class PersonnalInformation extends StatefulWidget {
  const PersonnalInformation({super.key});

  static const routeName = '/personnal-information';

  @override
  State<PersonnalInformation> createState() => _PersonnalInformationState();
}

class _PersonnalInformationState extends State<PersonnalInformation> {
  //pour nous permettre d'avoir acces au input du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey();
  //stockons les informations du formualaire dans un map
  Map<String, String> _personnalData = {'nom': '', 'prenom': ''};

  late Future<UserModel> FutureUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FutureUser = AuthProvider().getUser();
  }

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
        ],
      ),
    );
  }

  //pour afficher une boite de dialog de nos erreurs
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Genial',
          style: TextStyle(color: AppColor.appGreen),
        ),
        content:
            Text('Vos informations personnelles ont été modifiez avec succès'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/setting-screen');
              },
              child: const Text(
                'merci',
                style: TextStyle(color: AppColor.appGreen),
              )),
        ],
      ),
    );
  }

  //la fonction de modification des informations personnelles
  Future<void> _submit() async {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateUserInfo(
            _personnalData['nom'].toString(),
            _personnalData['prenom'].toString(),
          )
          .then((_) => _showSuccessDialog());
    } on HttpExceptions catch (error) {
      var messageError = 'Erreur d\'e modification du mot de passe';
      if (error.toString().contains('User password don\'t match')) {
        messageError =
            'L\'ancien mot de passe du compte ne correspond pas, reessayez';
      } else if (error
          .toString()
          .contains('The new password field is required.')) {
        messageError = 'Le nouveau mot de passe est obligatoire';
      } else {
        messageError = 'Probleme de connexion a votre compte';
      }
      _showErrorDialog(messageError);
    } catch (error) {
      _showErrorDialog('une erreur s\'est produite veuillez reessayer');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SettingCartWidget(
                mediaQuery: mediaQuery,
                settingInfo: 'Informations personnelles',
                backRoute: '/setting-screen',
              ),
              Padding(
                padding: EdgeInsets.all(mediaQuery.size.height * 0.05),
                child: Form(
                  key: _formKey,
                  child: Container(
                    //ici on accede a notre utilisateur pour pouvoir preremplir le formilaire avec ces informations
                    child: FutureBuilder<UserModel>(
                        future: FutureUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                //input nom
                                SizedBox(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Nom',
                                      hintStyle: TextStyle(
                                        color: AppColor.appGrey,
                                      ),
                                    ),
                                    initialValue: snapshot.data!.lastname,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z]'))
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Champs nom vide, entrez un nom valide';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => {
                                      _personnalData['nom'] = value!,
                                    },
                                  ),
                                ),
                                //input prenom
                                SizedBox(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Prénom',
                                      hintStyle: TextStyle(
                                        color: AppColor.appGrey,
                                      ),
                                    ),
                                    initialValue: snapshot.data!.firstname,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z]'))
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Champs prénom vide, entrez un nom valide';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => {
                                      _personnalData['prenom'] = value!,
                                    },
                                  ),
                                ),
                                //button de modification
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              primary: AppColor.appWhite,
                                              textStyle:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            onPressed: _submit,
                                            child: Text('Modifier'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
