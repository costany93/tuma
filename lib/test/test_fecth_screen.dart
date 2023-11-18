import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/user_model.dart';
import 'package:tuma/models/user_transaction_model.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/test/user_test_model.dart';

class TestFectData extends StatefulWidget {
  const TestFectData({super.key});

  @override
  State<TestFectData> createState() => _TestFectDataState();
}

class _TestFectDataState extends State<TestFectData> {
  @override
  late Future<UserModel> FutureUser;
  late Future<List<UserTransaction>> FutureListTransaction;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FutureUser = AuthProvider().getUser();
  }
  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    FutureUser = AuthProvider().getUser();
    //print(Provider.of<AuthProvider>(context, listen: false)
    //.getUserTransactions());
    //FutureListTransaction = AuthProvider().getUserTransactions();

    //print('nous sommes dans la vue');
    //print(AuthProvider().getUserTransactions);
  }*/

  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: Column(
      children: [
        FutureBuilder<UserModel>(
            future: FutureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.solde.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
        FutureBuilder<List<UserTransaction>>(
            future: AuthProvider().fetchTransactions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Text(
                          snapshot.data![index].date_transactions.toString());
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
      ],
    ));
  }
}
