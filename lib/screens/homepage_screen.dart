import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuma/models/user_model.dart';
import 'package:tuma/models/user_transaction_model.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/setting_screen.dart';
import 'package:tuma/screens/transfert_screen.dart';
import 'package:tuma/test/user_test_model.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/widgets/transactions_widget.dart';
import 'package:tuma/widgets/tuma_cart.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  //print(Provider.of<AuthProvider>(context, listen: false).getUser());
  late Future<UserModel> FutureUser;
  late Future<List<UserTransaction>> FutureListTransaction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FutureUser = AuthProvider().getUser();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: FutureBuilder<UserModel>(
                future: FutureUser,
                builder: (context, snapshotUser) {
                  if (snapshotUser.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SettingScreen.routeName),
                              icon: Icon(
                                Icons.settings,
                                color: AppColor.appBleu4,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Provider.of<AuthProvider>(
                                      context,
                                      listen: false)
                                  .logout(),
                              icon: Icon(
                                Icons.logout,
                                color: AppColor.appBleu4,
                              ),
                            ),
                          ],
                        ),
                        /*Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SettingScreen.routeName),
                  icon: Icon(Icons.settings),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () =>
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout(),
                  icon: Icon(Icons.logout),
                ),
              ),*/
                        Center(
                          child: Text(
                            'Bienvenue ' + snapshotUser.data!.lastname,
                            style: TextStyle(
                              fontSize: mediaQuery.size.height * 0.02,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          // child: Text(
                          //   'Bienvenue',
                          //   style: TextStyle(
                          //     fontSize: mediaQuery.size.height * 0.03,
                          //     fontFamily: 'Inter',
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ),
                        TumaCart(solde: snapshotUser.data!.solde),
                        Container(
                          margin: EdgeInsets.all(mediaQuery.size.height * 0.03),
                          //height: mediaQuery.size.height * 0.04,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Transactions',
                                    style: TextStyle(
                                      fontSize: mediaQuery.size.height * 0.024,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    height: mediaQuery.size.height * 0.008,
                                    width: mediaQuery.size.width * 0.23,
                                    color: AppColor.appBleu5,
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.short_text,
                                  size: mediaQuery.size.height * 0.05,
                                  color: AppColor.appBleu5,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: mediaQuery.size.height * 0.72,
                          width: mediaQuery.size.height * 0.9,
                          //ici on affiche notre liste de transaction
                          child: FutureBuilder<List<UserTransaction>>(
                              future: AuthProvider().fetchTransactions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return TransactionWidget(
                                          userId: snapshot.data![index].userId,
                                          transaction_id: snapshot
                                              .data![index].transaction_id,
                                          n_expediteur: snapshot
                                              .data![index].n_expediteur,
                                          n_destinataire: snapshot
                                              .data![index].n_destinataire,
                                          montant:
                                              snapshot.data![index].montant,
                                          statut: snapshot.data![index].statut,
                                          is_transfert: snapshot
                                              .data![index].is_transfert,
                                          is_depot:
                                              snapshot.data![index].is_depot,
                                          is_retrait:
                                              snapshot.data![index].is_retrait,
                                          date_transactions: snapshot
                                              .data![index].date_transactions,
                                          n_user_connecte:
                                              snapshotUser.data!.phone_number,
                                          expediteur_firstname: snapshot
                                              .data![index]
                                              .expediteur_firstname,
                                          expediteur_phone_number: snapshot
                                              .data![index]
                                              .expediteur_phone_number,
                                          destinataire_firstname: snapshot
                                              .data![index]
                                              .destinataire_firstname,
                                          destinataire_phone_number: snapshot
                                              .data![index]
                                              .destinataire_phone_number,
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }

                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              }),
                          //fin de la liste de transaction
                        )
                      ],
                    );
                  } else if (snapshotUser.hasError) {
                    return Text('${snapshotUser.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
          ),
        ),
        floatingActionButton: FutureBuilder<UserModel>(
            future: FutureUser,
            builder: (context, snapshotUser) {
              if (snapshotUser.hasData) {
                return FloatingActionButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                      TransfertScreen.routeName,
                      arguments: {'solde': snapshotUser.data!.solde}),
                  backgroundColor: AppColor.appBleu3,
                  child: Icon(
                    Icons.add,
                    size: mediaQuery.size.height * 0.05,
                    color: AppColor.appWhite,
                  ),
                );
              } else if (snapshotUser.hasError) {
                return Text('${snapshotUser.error}');
              } else {
                return Text('...chargement');
              }
            }));
  }
}
