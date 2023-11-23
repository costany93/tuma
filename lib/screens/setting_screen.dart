import 'package:flutter/material.dart';
import 'package:tuma/screens/change_password_screen.dart';
import 'package:tuma/screens/personnal_information.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';
import 'package:tuma/widgets/setting_cart_widget.dart';
import 'package:tuma/widgets/setting_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  static const routeName = '/setting-screen';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        //cadran bleu d'en haut
        child: Column(
          children: [
            SettingCartWidget(
              mediaQuery: mediaQuery,
              settingInfo: 'Parametre de compte',
              backRoute: '/home-page',
            ),
            //section parametre
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.65,
              decoration: BoxDecoration(color: AppColor.appWhite),
              //e recupere les informations du parent hauteur, largeur et plus dans le layout builder
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.all(mediaQuery.size.height * 0.05),
                    child: Container(
                      //colonne principale de
                      child: Column(
                        children: [
                          SettingWidget(
                            mediaQuery: mediaQuery,
                            information: 'Informations personnelles',
                            iconsLeft: Icons.account_circle,
                            routePath: PersonnalInformation.routeName,
                          ),
                          SettingWidget(
                            mediaQuery: mediaQuery,
                            information: 'Modifier votre mot de passe',
                            iconsLeft: Icons.lock,
                            routePath: ChangePasswordScreen.routeName,
                          ),
                          SettingWidget(
                            mediaQuery: mediaQuery,
                            information: 'Appeler le service client',
                            iconsLeft: Icons.call,
                            routePath: SettingScreen.routeName,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
