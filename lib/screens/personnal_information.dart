import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/widgets/setting_cart_widget.dart';

class PersonnalInformation extends StatefulWidget {
  const PersonnalInformation({super.key});

  static const routeName = '/personnal-information';

  @override
  State<PersonnalInformation> createState() => _PersonnalInformationState();
}

class _PersonnalInformationState extends State<PersonnalInformation> {
  Future<String> getFirstname() async {
    final String firstname;

    final localStorage = await SharedPreferences.getInstance();
    final userDataJson = localStorage.getString('userData');
    final userData = json.decode(userDataJson.toString());
    firstname = userData['firstname'].toString();

    return firstname;
  }

  //pour nous permettre d'avoir acces au input du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey();
  //stockons les informations du formualaire dans un map
  Map<String, String> _personnalData = {'nom': '', 'prenom': ''};
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
              ),
              Padding(
                padding: EdgeInsets.all(mediaQuery.size.height * 0.05),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
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
                            initialValue: 'initial',
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
                                      padding: const EdgeInsets.all(16.0),
                                      primary: AppColor.appWhite,
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () => print(_personnalData['nom']
                                            .toString() +
                                        ' ' +
                                        _personnalData['prenom'].toString()),
                                    child: Text('Modifier'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
