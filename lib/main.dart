import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuma/providers/auth_provider.dart';
import 'package:tuma/screens/homepage_screen.dart';
import 'package:tuma/screens/login_screen.dart';
import 'package:tuma/screens/setting_screen.dart';
import 'package:tuma/screens/signin_screen.dart';

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
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.cyan,
                  ),
                ),
                //home: authData.isAuth ? HomePageScreen() : LoginScreen(),
                home: SettingScreen(),
                routes: {
                  LoginScreen.routeName: (context) => LoginScreen(),
                  SignIn.routeName: (context) => SignIn()
                },
              )),
        ));
  }
}
