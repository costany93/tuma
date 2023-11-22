import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/agent/depot_screen.dart';
import 'package:tuma/screens/agent/retrait_screen.dart';
import 'package:tuma/utillities/app_colors.dart';

class AgentHomePage extends StatelessWidget {
  const AgentHomePage({super.key});

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
          Container(
            width: mediaQuery.size.width * 0.75,
            height: mediaQuery.size.height * 0.08,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RetraitScreen.routeName);
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
                Navigator.of(context).pushNamed(DepotScreen.routeName);
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
