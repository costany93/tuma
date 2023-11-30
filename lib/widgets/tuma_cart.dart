import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tuma/utillities/app_colors.dart';
import 'package:tuma/utillities/number_formater.dart';

class TumaCart extends StatefulWidget {
  const TumaCart({required this.solde});
  final int solde;

  @override
  State<TumaCart> createState() => _TumaCartState();
}

class _TumaCartState extends State<TumaCart> {
  bool _hideSolde = true;

  _changeSoldeHide() {
    if (_hideSolde == false) {
      setState(() {
        _hideSolde = true;
        //print('the hide solde is ' + _hideSolde.toString());
      });
    } else {
      setState(() {
        _hideSolde = false;
        //print('the hide solde is ' + _hideSolde.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: mediaQuery.size.height * 0.01),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //transform: GradientRotation(0.1),
              colors: <Color>[
                Color(0xFFFFFFFF),
                AppColor.appBleu5,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 207, 207, 207),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 6)),
            ],
          ),
          height: mediaQuery.size.height * 0.27,
          width: mediaQuery.size.width * 0.85,
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              margin: EdgeInsets.all(mediaQuery.size.height * 0.015),
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID',
                          style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.020,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'TINDA',
                          style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.020,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.480,
                    width: constraints.maxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'solde',
                          style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.024,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: _hideSolde
                                  ? NumberFormater()
                                      .formaterNumber(widget.solde)
                                  : '*******',
                              style: TextStyle(
                                  fontSize: mediaQuery.size.height * 0.04,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.appBlack),
                              children: [
                                TextSpan(
                                  text: _hideSolde ? ' F' : '',
                                  style: TextStyle(
                                    fontSize: mediaQuery.size.height * 0.02,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: _changeSoldeHide,
                          icon: Icon(
                            _hideSolde
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                            color: AppColor.appWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })

          //color: Colors.red,
          ),
    );
  }
}
