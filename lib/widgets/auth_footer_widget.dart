import 'package:flutter/material.dart';

class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      height: mediaQuery.size.height * 0.05,
      width: mediaQuery.size.width * 1,

      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF12CFC9),
              Color(0xFF16E1DF),
              Color(0xFF12CFC9),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Optez pour la rapidité, effectuez vos transactions avec ',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: mediaQuery.size.height * 0.015,
                  color: Colors.white),
            ),
            Text(
              'NOUS',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: mediaQuery.size.height * 0.015),
            )
          ],
        ),
      ),
    );
  }
}
