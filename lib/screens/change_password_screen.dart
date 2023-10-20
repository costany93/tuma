import 'package:flutter/material.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/widgets/setting_cart_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const routeName = '/change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  //pour nous permettre d'avoir acces au input du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey();
  //stockons les informations du formulaire dans un map
  Map<String, String> _passwordInformation = {
    'newPassword': '',
    'oldPassword': ''
  };
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
                settingInfo: 'Modifier votre mot de passe',
              ),
              Container(
                height: mediaQuery.size.height * 0.65,
                child: Padding(
                  padding: EdgeInsets.all(mediaQuery.size.height * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //input nom
                        SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ancien mot de passe',
                              hintStyle: TextStyle(
                                color: AppColor.appGrey,
                              ),
                            ),
                            onSaved: (value) => {
                              _passwordInformation['oldPassword'] = value!,
                            },
                            obscureText: true,
                          ),
                        ),
                        //input prenom
                        SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Nouveau mot de passe',
                              hintStyle: TextStyle(
                                color: AppColor.appGrey,
                              ),
                            ),
                            onSaved: (value) => {
                              _passwordInformation['newPassword'] = value!,
                            },
                            obscureText: true,
                          ),
                        ),
                        //input prenom
                        SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Confirmer le mot de passe',
                              hintStyle: TextStyle(
                                color: AppColor.appGrey,
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),

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
                                    onPressed: () => print(
                                        _passwordInformation['nom'].toString() +
                                            ' ' +
                                            _passwordInformation['prenom']
                                                .toString()),
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
