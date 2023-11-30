import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuma/utillities/logo_image.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key, required this.mediaQuery})
      : super(key: key);
  final MediaQueryData mediaQuery;
  @override
  Widget build(BuildContext context) {
    //MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      //color: Colors.amber,

      /* decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF12CFC9),
            Color(0xFF16E1DF),
            Color.fromARGB(255, 9, 211, 204),
          ],
        ),
      ), */
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              LogoImage.imageLogoPath,
              height: mediaQuery.size.height * 0.20,
            ),
          ],
        ),
      ),
    );
  }
}
