import 'package:flutter/material.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:intl/intl.dart';

class ReceiptScreen extends StatelessWidget {
  ReceiptScreen({super.key});
  static const routeName = '/receipt';
  final formaterNumber = new NumberFormat("#,##0", "fr_FR");
  final formaterPhoneNumber = new NumberFormat("##,##,##,##0", "fr_FR");

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        color: AppColor.appLightGrey,
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        //container du haut avec le montant transferer et le destinataire
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: mediaQuery.size.height * 0.25,
            width: mediaQuery.size.width,
            color: AppColor.appGreen,
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formaterNumber.format(-200000) + ' F',
                    style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.08,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(formaterPhoneNumber.format(786097344)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
