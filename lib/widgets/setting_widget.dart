import 'package:flutter/material.dart';
import 'package:tuma/screens/personnal_information.dart';
import 'package:tuma/utillities/app_colors.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    required this.mediaQuery,
    required this.information,
    required this.iconsLeft,
    required this.routePath,
  });

  final MediaQueryData mediaQuery;
  final String information;
  final IconData iconsLeft;
  final String routePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(routePath),
      child: Container(
        margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconsLeft,
                  color: AppColor.appBleu4,
                ),
                Text(
                  information,
                  style: TextStyle(fontSize: mediaQuery.size.width * 0.05),
                ),
                Icon(
                  Icons.navigate_next,
                  color: AppColor.appBleu4,
                  size: mediaQuery.size.width * 0.08,
                ),
              ],
            ),
            Divider(
              color: AppColor.appLightGrey,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
