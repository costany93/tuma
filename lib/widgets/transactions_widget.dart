import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tuma/utillities/app_colors.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => print('transactions'),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.height * 0.03,
            vertical: mediaQuery.size.height * 0.008),
        padding: EdgeInsets.all(mediaQuery.size.height * 0.015),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0XFFF9F9F9),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 207, 207, 207),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 0)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A Fortune Rocil',
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.024,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Success',
                      style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.015,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: AppColor.appGrey,
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Color(0XFF4ECB71),
                      size: mediaQuery.size.height * 0.025,
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '30 000F',
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.024,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '06-07-2022 a 16h30',
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.015,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
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
