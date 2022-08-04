import 'dart:ffi';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:tuma/widgets/transactions_widget.dart';
import 'package:tuma/widgets/tuma_cart.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Bienvenue',
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.03,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TumaCart(),
              Container(
                margin: EdgeInsets.all(mediaQuery.size.height * 0.03),
                //height: mediaQuery.size.height * 0.04,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.024,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          height: mediaQuery.size.height * 0.008,
                          width: mediaQuery.size.width * 0.23,
                          color: Color(0xFF18E8E8),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.short_text,
                        size: mediaQuery.size.height * 0.05,
                        color: Color(0xFF18E8E8),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: mediaQuery.size.height * 0.72,
                width: mediaQuery.size.height * 0.9,
                child: ListView(
                  children: [
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                    TransactionWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('press');
        },
        backgroundColor: Color(0XFF12CFC9),
        child: Icon(
          Icons.add,
          size: mediaQuery.size.height * 0.05,
          color: Colors.white,
        ),
      ),
    );
  }
}
