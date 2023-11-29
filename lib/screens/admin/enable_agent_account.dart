import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';

class EnableAgentAccount extends StatefulWidget {
  const EnableAgentAccount({super.key});
  static const routeName = '/enable-agent-account';

  @override
  State<EnableAgentAccount> createState() => _EnableAgentAccountState();
}

class _EnableAgentAccountState extends State<EnableAgentAccount> {
//pour nous permettre d'avoir acces au input du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey();
  //stockons les informations du formulaire dans un map
  Map<String, String> _transfertData = {'n_destinataire': '', 'password': ''};

  //pour afficher une boite de dialog de nos erreurs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Oops', style: TextStyle(color: AppColor.appRed)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ok ', style: TextStyle(color: AppColor.appRed)),
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
          'Agent activé',
          style: TextStyle(color: AppColor.appGreen),
        ),
        content: Text(
            'Nouvel agent défini, demandez lui de se connecter à son compte'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home-page');
              },
              child: const Text(
                'merci',
                style: TextStyle(color: AppColor.appGreen),
              )),
        ],
      ),
    );
  }

  //la fonction de transferer de l'argent
  Future<void> _submit() async {
    //si notre formulaire n'est pas valide on ne faiit rien
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    // print(_transfertData['n_destinataire'].toString() +
    //     _transfertData['montant'].toString() +
    //     _transfertData['password'].toString() +
    //     'ici');
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .enableAgent(
            _transfertData['n_destinataire'].toString(),
            _transfertData['password'].toString(),
          )
          .then((_) => _showSuccessDialog());
    } on HttpExceptions catch (error) {
      var messageError = 'Erreur d\'e ';
      if (error
          .toString()
          .contains('Vous n\'etes pas un administrateur, reessayez')) {
        messageError = 'Vous n\'etes pas un administrateur, reessayez';
      } else if (error
          .toString()
          .contains('Cette utilisateur est déjà un agent, reessayez')) {
        messageError = 'Cette utilisateur est déjà un agent, reessayez';
      } else if (error
          .toString()
          .contains('Mot de passe incorrect, reessayez')) {
        messageError = 'Mot de passe incorrect, reessayez';
        //Veuillez mettre a jour vos informations personnelles avant de
      } else if (error
          .toString()
          .contains('Utilisateur introuvable, reessayez')) {
        messageError = 'Utilisateur introuvable, reessayez';
        //Veuillez mettre a jour vos informations personnelles avant de
      } else if (error.toString().contains(
          'Vous ne pouvez pas vous définir comme agent, entrez un autre numero de telephone')) {
        messageError =
            'Vous ne pouvez pas vous définir comme agent, entrez un autre numero de telephone';
        //Veuillez mettre a jour vos informations personnelles avant de
      } else {
        messageError = 'Veuillez vérifier les informations';
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
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Column(
            children: [
              //ici on a l'icone de retour arrow back
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Center(
                child: Text(
                  'Définir un nouvel agent',
                  style: TextStyle(
                    fontSize: mediaQuery.size.width * 0.07,
                  ),
                ),
              ),

              //ici on a la ligne en dessous du texte de solde
              Container(
                margin: EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.height * 0.05,
                ),
                child: Divider(
                  height: 2,
                  color: AppColor.appBlack,
                ),
              ),
              // ici nous avons le formulaire pour faire une transaction
              Container(
                margin: EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.height * 0.05,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //input numero du destinataire
                      SizedBox(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Numero de l\'agent',
                            helperText: 'au format ** *** ** **',
                            counterText: '',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              color: AppColor.appGrey,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                          ),
                          onSaved: (value) => {
                            _transfertData['n_destinataire'] = value!,
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 9,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Numero de telephone vide';
                            }
                            return null;
                          },
                        ),
                      ),

                      //input mot de passe
                      Container(
                        margin:
                            EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                        child: SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Entrez votre mot de passe',
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                color: AppColor.appGrey,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                            ),
                            onSaved: (value) => {
                              _transfertData['password'] = value!,
                            },
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mot de passe vide, entrez un mot de passe valide';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      //button de transfert
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
                                        AppColor.appGreen,
                                        AppColor.appGreen,
                                        AppColor.appGreen,
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
                                  child: Text('Définir'),
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

              //ici on a le button de transfert
            ],
          ),
        ),
      ),
    );
  }
}
