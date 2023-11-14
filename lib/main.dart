import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/change_password_screen.dart';
import 'package:tuma/screens/homepage_screen.dart';
import 'package:tuma/screens/login_screen.dart';
import 'package:tuma/screens/number_login_screen.dart';
import 'package:tuma/screens/personnal_information.dart';
import 'package:tuma/screens/receipt_screen.dart';
import 'package:tuma/screens/setting_screen.dart';
import 'package:tuma/screens/signin_screen.dart';
import 'package:tuma/screens/transfert_screen.dart';

void main() {
  runApp(const Tuma());
}

class Tuma extends StatelessWidget {
  const Tuma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthProvider(),
          )
        ],
        child: Consumer<AuthProvider>(
          builder: ((ctx, authData, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.cyan,
                  ),
                ),
                home: authData.isAuth ? HomePageScreen() : LoginScreen(),
                //home: LoginScreen(),
                routes: {
                  LoginScreen.routeName: (context) => LoginScreen(),
                  SignIn.routeName: (context) => SignIn(),
                  PersonnalInformation.routeName: (context) =>
                      PersonnalInformation(),
                  ChangePasswordScreen.routeName: (context) =>
                      ChangePasswordScreen(),
                  SettingScreen.routeName: (context) => SettingScreen(),
                  TransfertScreen.routeName: (context) => TransfertScreen(),
                  NumberLoginScreen.routeName: (context) => NumberLoginScreen(),
                  ReceiptScreen.routeName: (context) => ReceiptScreen()
                },
              )),
        ));
  }
}
