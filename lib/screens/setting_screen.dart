import 'package:flutter/material.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';
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
            Container(
              decoration: BoxDecoration(color: AppColor.appBleu4),
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.width,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                width: mediaQuery.size.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      LogoImage.imageLogoPath,
                      height: mediaQuery.size.height * 0.15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: mediaQuery.size.height * 0.02,
                      ),
                      child: Text(
                        'Bienvenue',
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
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
                          ),
                          SettingWidget(
                            mediaQuery: mediaQuery,
                            information: 'Modifier votre mot de passe',
                            iconsLeft: Icons.lock,
                          ),
                          SettingWidget(
                            mediaQuery: mediaQuery,
                            information: 'Appeler le service client',
                            iconsLeft: Icons.call,
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
