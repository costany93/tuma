import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/admin/disable_agent_account.dart';
import 'package:tuma/screens/admin/enable_agent_account.dart';
import 'package:tuma/screens/admin/reload_agent_account.dart';
import 'package:tuma/utillities/app_colors.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.75,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: mediaQuery.size.width * 0.8,
              height: mediaQuery.size.height * 0.1,
              color: AppColor.appGreen,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Espace administration',
                  style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.07,
                      color: AppColor.appWhite),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.45,
                  height: mediaQuery.size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      //print('clic ');
                      Navigator.of(context)
                          .pushNamed(EnableAgentAccount.routeName);
                    },
                    child: Center(
                      child: Text(
                        'Activez un agent',
                        textAlign: TextAlign.center,
                      ),
                    ),
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
                  width: mediaQuery.size.width * 0.45,
                  height: mediaQuery.size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      //print('clic ');
                      Navigator.of(context)
                          .pushNamed(DisableAgentAccount.routeName);
                    },
                    child: Center(
                        child: Text('Désactivez un agent',
                            textAlign: TextAlign.center)),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.appWhite,
                      backgroundColor: AppColor.appGrey,
                      textStyle: TextStyle(
                        fontSize: mediaQuery.size.width * 0.07,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.45,
                  height: mediaQuery.size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      //print('clic ');
                      Navigator.of(context).pushNamed(
                        ReloadAgentAccount.routeName,
                      );
                    },
                    child: Center(
                        child: Text('Rechargez compte agent',
                            textAlign: TextAlign.center)),
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
                  width: mediaQuery.size.width * 0.45,
                  height: mediaQuery.size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout();
                    },
                    child: Center(
                        child:
                            Text('Deconnexion', textAlign: TextAlign.center)),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.appWhite,
                      backgroundColor: AppColor.appBleu4,
                      textStyle: TextStyle(
                        fontSize: mediaQuery.size.width * 0.07,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
