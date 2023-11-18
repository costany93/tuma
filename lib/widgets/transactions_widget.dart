import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tuma/utillities/app_colors.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    required this.userId,
    required this.transaction_id,
    required this.n_expediteur,
    required this.n_destinataire,
    required this.montant,
    required this.statut,
    required this.is_transfert,
    required this.is_depot,
    required this.is_retrait,
    required this.date_transactions,
    required this.n_user_connecte,
  });

  final int userId;
  final String transaction_id;
  final String n_expediteur;
  final String n_destinataire;
  final int montant;
  final int statut;
  final int is_transfert;
  final int is_depot;
  final int is_retrait;
  final DateTime date_transactions;
  final String n_user_connecte;

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: n_expediteur == n_user_connecte
              ? Color.fromARGB(255, 247, 243, 243)
              : Color.fromARGB(255, 240, 243, 240),
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
                  n_expediteur == n_user_connecte
                      ? 'À ' + n_destinataire
                      : 'De ' + n_expediteur,
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.020,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      n_expediteur == n_user_connecte ? 'Envoyé' : 'Reçu',
                      style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.015,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: AppColor.appGrey,
                      ),
                    ),
                    Icon(
                      n_expediteur == n_user_connecte
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: n_expediteur == n_user_connecte
                          ? Color.fromARGB(255, 203, 78, 78)
                          : Color(0XFF4ECB71),
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
                  montant.toString() + ' F',
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.024,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date_transactions.toString(),
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
