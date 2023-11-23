import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/http_exceptions.dart';
import 'package:tuma/models/user_transaction_model.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/number_formater.dart';

class ValidateRetraitScreen extends StatefulWidget {
  ValidateRetraitScreen({super.key});
  static const routeName = '/validate-retrait';

  @override
  State<ValidateRetraitScreen> createState() => _ValidateRetraitScreenState();
}

class _ValidateRetraitScreenState extends State<ValidateRetraitScreen> {
  late Future<List<UserTransaction>> FutureListRetraitTransaction;
  @override
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    FutureListRetraitTransaction = AuthProvider().fetchRetraitTransactions();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
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
    void _showSuccessDialog(bool validate) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Genial',
            style: TextStyle(color: AppColor.appGreen),
          ),
          content: Text(validate == true
              ? 'Retrait validé avec succès'
              : 'Retrait annulé avec succès'),
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
    Future<void> _submitYes(String transaction_id, bool validate) async {
      try {
        if (validate == true) {
          await Provider.of<AuthProvider>(context, listen: false)
              .validateUserRetrait(
                transaction_id,
              )
              .then((_) => _showSuccessDialog(true));
        } else {
          await Provider.of<AuthProvider>(context, listen: false)
              .invalidateUserRetrait(
                transaction_id,
              )
              .then((_) => _showSuccessDialog(false));
        }
      } on HttpExceptions catch (error) {
        var messageError = 'Erreur';
        if (error
            .toString()
            .contains('Le retrait de cette transaction a déjà été effectué')) {
          messageError = 'Le retrait de cette transaction a déjà été effectué';
        } else if (error
            .toString()
            .contains('Cette transaction a déjà été validé')) {
          messageError = 'Cette transaction a déjà été validé';
        } else if (error
            .toString()
            .contains('Cette transaction a déjà été retiré')) {
          messageError = 'Cette transaction a déjà été retiré';
        } else if (error
            .toString()
            .contains('Cette transaction a déjà été annulé')) {
          messageError = 'Cette transaction a déjà été annulé';
        } else if (error
            .toString()
            .contains('Cette transaction n\'est pas une demande de retrait')) {
          messageError = 'Cette transaction n\'est pas une demande de retrait';
        } else if (error.toString().contains(
            'Votre solde est insuffiant pour valider cette transactions, déposer des  fonds')) {
          messageError =
              'Votre solde est insuffiant pour valider cette transactions, déposer des  fonds';
        } else {
          messageError = 'Probleme de validation du retrait';
        }
        _showErrorDialog(messageError);
      } catch (error) {
        _showErrorDialog('une erreur s\'est produite veuillez reessayer');
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              FutureBuilder<List<UserTransaction>>(
                  future: FutureListRetraitTransaction,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              width: mediaQuery.size.width * 0.8,
                              height: mediaQuery.size.height * 0.2,
                              color: Color.fromARGB(255, 242, 241, 241),
                              margin:
                                  EdgeInsets.all(mediaQuery.size.width * 0.05),
                              padding:
                                  EdgeInsets.all(mediaQuery.size.width * 0.02),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      child: Text('Retrait'),
                                    ),
                                    Align(
                                      child: Text(
                                        NumberFormater().formaterNumber(
                                                snapshot.data![index].montant) +
                                            ' F',
                                        style: TextStyle(
                                            fontSize:
                                                mediaQuery.size.width * 0.07,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      child: Text(
                                          'Souhaitez-vous valider ce retrait'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () => _submitYes(
                                              snapshot
                                                  .data![index].transaction_id
                                                  .toString(),
                                              true),
                                          style: TextButton.styleFrom(
                                            backgroundColor: AppColor.appGreen,
                                            foregroundColor: AppColor.appWhite,
                                          ),
                                          child: Text('oui'),
                                        ),
                                        TextButton(
                                          onPressed: () => _submitYes(
                                              snapshot
                                                  .data![index].transaction_id,
                                              false),
                                          style: TextButton.styleFrom(
                                            backgroundColor: AppColor.appRed,
                                            foregroundColor: AppColor.appWhite,
                                          ),
                                          child: Text('non'),
                                        ),
                                      ],
                                    )
                                  ]),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
