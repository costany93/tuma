import 'package:flutter/material.dart';
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
                          NumberFormater().formaterNumber(200000) + ' F',
                          style: TextStyle(
                              fontSize: mediaQuery.size.width * 0.08,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(formaterPhoneNumber.format(786097344)),
                      ],
                    ),
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
                      Text(NumberFormater().formaterNumber(200000) + ' F')
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
                      Text(NumberFormater().formaterNumber(150) + ' F')
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
                      Text('Effectué')
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
                      Text('25 octobre 2023 16h11')
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
                      SizedBox(
                        width: mediaQuery.size.height * 0.25,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: AppColor.appWhite,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            showDialog(
                                context: context, builder: ((context) => alert))
                          },
                          child: Text('Annuler'),
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
    );
  }
}
