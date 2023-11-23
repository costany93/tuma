import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:tuma/utillities/number_formater.dart';

class ReceiptScreen extends StatelessWidget {
  ReceiptScreen({super.key});
  static const routeName = '/receipt';
  final formaterPhoneNumber = new NumberFormat("##,##,##,##0", "fr_FR");

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print('here is arguments');
    print(arguments['montant']);

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
          content: Text('Transfert annulé avec succès'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)..pushNamed('/home-page');
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
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .cancelTransfert(
              arguments['transaction_id'],
            )
            .then((_) => _showSuccessDialog());
      } on HttpExceptions catch (error) {
        var messageError = 'Erreur d\'e modification du mot de passe';
        if (error
            .toString()
            .contains('La transaction recherché n\'est plus disponible')) {
          messageError = 'La transaction recherché n\'est plus disponible';
        } else if (error.toString().contains(
            'Vous ne pouvez pas annuler une transaction qui ne vous appartient pas')) {
          messageError =
              'Vous ne pouvez pas annuler une transaction qui ne vous appartient pas';
        } else if (error.toString().contains(
            'Vous ne pouvez pas annuler, une transaction deja annulé')) {
          messageError =
              'Vous ne pouvez pas annuler, une transaction deja annulé';
        } else {
          messageError = 'Probleme d\annulation du transfert';
        }
        _showErrorDialog(messageError);
      } catch (error) {
        _showErrorDialog('une erreur s\'est produite veuillez reessayer');
      }
    }

    //process du alert button
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //fin du dialog button
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          //container du haut avec le montant transferer et le destinataire
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: mediaQuery.size.height * 0.20,
                  width: mediaQuery.size.width,
                  //color: AppColor.appGreen,
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          NumberFormater()
                                  .formaterNumber(arguments['montant']) +
                              ' F',
                          style: TextStyle(
                              fontSize: mediaQuery.size.width * 0.08,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          /** ici on verifie si le numero de celui qui a envoye l'argent c'est notre numero(numero de l'utilisateur connecte) pour afficher son, et aussi on verifie si c'est un nouvelle utilisateur on affiche nouvelle utilisateur */
                          arguments['n_expediteur'] ==
                                  arguments['n_user_connecte']
                              ? arguments['destinataire_firstname'] == 'new'
                                  ? 'À nouvelle utilisateur '
                                      .characters
                                      .take(22)
                                      .toString()
                                  : 'À '.characters.take(22).toString() +
                                      arguments['destinataire_firstname']
                              : arguments['is_depot'] == 1
                                  ? 'Depot'
                                  : arguments['expediteur_firstname'] == 'new'
                                      ? 'De nouvelle utilisateur'
                                          .characters
                                          .take(22)
                                          .toString()
                                      : 'De '.characters.take(22).toString() +
                                          arguments['expediteur_firstname'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //partie numero
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(mediaQuery.size.width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Numéro',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            color: AppColor.appGrey),
                      ),
                      Text(
                        arguments['n_expediteur'] ==
                                arguments['n_user_connecte']
                            ? arguments['n_destinataire']
                            : arguments['n_expediteur'],
                      )
                    ],
                  ),
                ),
              ),
              //partie montant
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(mediaQuery.size.width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Montant',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            color: AppColor.appGrey),
                      ),
                      Text(NumberFormater()
                              .formaterNumber(arguments['montant']) +
                          ' F')
                    ],
                  ),
                ),
              ),
              //partie frais
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(mediaQuery.size.width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frais de service',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            color: AppColor.appGrey),
                      ),
                      Text(NumberFormater().formaterNumber(0) + ' F')
                    ],
                  ),
                ),
              ),
              //partie statut
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(mediaQuery.size.width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statut de la transaction',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            color: AppColor.appGrey),
                      ),
                      Text(arguments['statut'] == 1 ? 'Effectué' : 'Annulé')
                    ],
                  ),
                ),
              ),
              //partie date et heure
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(mediaQuery.size.width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date et heure',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            color: AppColor.appGrey),
                      ),
                      Text(arguments['date_transactions'].toString())
                    ],
                  ),
                ),
              ),
              //button annulation de transaction
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
                                Color.fromARGB(255, 234, 106, 97),
                                Color.fromARGB(255, 242, 109, 100),
                                Color.fromARGB(255, 243, 109, 99),
                              ],
                            ),
                          ),
                        ),
                      ),
                      arguments['n_expediteur'] == arguments['n_user_connecte']
                          ? SizedBox(
                              width: mediaQuery.size.height * 0.25,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  primary: AppColor.appWhite,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed:
                                    arguments['statut'] == 1 ? _submit : null,
                                child: Text('Annuler'),
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
