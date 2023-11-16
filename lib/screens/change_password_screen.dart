import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/providers/auth_provider.dart';
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
    'oldPassword': '',
    'newPassword': ''
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
        content: Text('Mot de passe modifiez avec succès'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)..pushNamed('/setting-screen');
              },
              child: const Text(
                'merci',
                style: TextStyle(color: AppColor.appGreen),
              )),
        ],
      ),
    );
  }

//la fonction de modification du mot de passe
  Future<void> _submit() async {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateUserPassword(
            _passwordInformation['oldPassword'].toString(),
            _passwordInformation['newPassword'].toString(),
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

  //pour la confirmation du mot de passe
  final _passwordController = TextEditingController();
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
                backRoute: '/setting-screen',
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
                                    _passwordInformation['newPassword'] =
                                        value!,
                                  },
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                return value!.length < 6
                                    ? 'Nombre de caractere minimum 6'
                                    : null;
                              }),
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
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Confirmation du mot de passe incorrect';
                              }
                              //return null;
                            },
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
                                    onPressed:
                                        _submit /*() => print(
                                        _passwordInformation['nom'].toString() +
                                            ' ' +
                                            _passwordInformation['prenom']
                                                .toString())*/
                                    ,
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
