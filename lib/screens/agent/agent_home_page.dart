import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuma/models/user_model.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/agent/depot_screen.dart';
import 'package:tuma/screens/agent/retrait_screen.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/number_formater.dart';

class AgentHomePage extends StatelessWidget {
  AgentHomePage({super.key, required this.solde});
  final int solde;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              NumberFormater().formaterNumber(solde) + ' F',
              style: TextStyle(fontSize: mediaQuery.size.width * 0.07),
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.75,
            height: mediaQuery.size.height * 0.08,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RetraitScreen.routeName,
                    arguments: {'solde': solde});
              },
              child: Text('Retrait'),
              style: TextButton.styleFrom(
                foregroundColor: AppColor.appWhite,
                backgroundColor: AppColor.appRed,
                textStyle: TextStyle(
                  fontSize: mediaQuery.size.width * 0.07,
                ),
              ),
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.75,
            height: mediaQuery.size.height * 0.08,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DepotScreen.routeName,
                    arguments: {'solde': solde});
              },
              child: Text('Dépot'),
              style: TextButton.styleFrom(
                foregroundColor: AppColor.appWhite,
                backgroundColor: AppColor.appGreen,
                textStyle: TextStyle(
                  fontSize: mediaQuery.size.width * 0.07,
                ),
              ),
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.75,
            height: mediaQuery.size.height * 0.08,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              child: Text('Deconnexion'),
              style: TextButton.styleFrom(
                foregroundColor: AppColor.appWhite,
                backgroundColor: AppColor.appBleu1,
                textStyle: TextStyle(
                  fontSize: mediaQuery.size.width * 0.07,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
