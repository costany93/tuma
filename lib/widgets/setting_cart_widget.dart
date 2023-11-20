import 'package:flutter/material.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/logo_image.dart';

class SettingCartWidget extends StatelessWidget {
  const SettingCartWidget(
      {super.key,
      required this.mediaQuery,
      required this.settingInfo,
      required this.backRoute});

  final MediaQueryData mediaQuery;
  final String settingInfo;
  final String backRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.appBleu4),
      height: mediaQuery.size.height * 0.35,
      width: mediaQuery.size.width,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        width: mediaQuery.size.width * 0.2,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(backRoute),
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Column(
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
                    settingInfo,
                    style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
