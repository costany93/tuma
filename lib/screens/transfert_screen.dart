import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';

class TransfertScreen extends StatefulWidget {
  const TransfertScreen({super.key});
  static const routeName = '/transfert';

  @override
  State<TransfertScreen> createState() => _TransfertScreenState();
}

class _TransfertScreenState extends State<TransfertScreen> {
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
              //ici on a l'image du logo de l'application
              Image.asset(
                LogoImage.imageLogoPath,
                width: mediaQuery.size.height * 0.15,
              ),
              //ici on a les texte de solde
              Container(
                margin: EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.height * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Solde'),
                    Text(
                      '200 000 F',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
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
                  child: Column(
                    children: [
                      //input numero du destinataire
                      SizedBox(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Numero du destinataire',
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      //input montant a transferer
                      Container(
                        margin:
                            EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                        child: SizedBox(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Montant du transfert',
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              )
                            ],
                          ),
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
                            /*onSaved: (value) => {
                                    _personnalData['nom'] = value!,
                                  },*/
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              )
                            ],
                          ),
                        ),
                      ),
                      //ici on a les texte de frais
                      Container(
                        margin:
                            EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Frais'),
                            Text(
                              '4600 F',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
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
                                  onPressed: () => print('transfert effectue'),
                                  child: Text('Transferer'),
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
