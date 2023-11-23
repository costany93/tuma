import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tuma/screens/receipt_screen.dart';
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
    required this.expediteur_firstname,
    required this.expediteur_phone_number,
    required this.destinataire_firstname,
    required this.destinataire_phone_number,
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
  final String expediteur_firstname;
  final String expediteur_phone_number;
  final String destinataire_firstname;
  final String destinataire_phone_number;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/receipt', arguments: {
        'userId': userId,
        'transaction_id': transaction_id,
        'n_expediteur': n_expediteur,
        'n_destinataire': n_destinataire,
        'montant': montant,
        'statut': statut,
        'is_transfert': is_transfert,
        'is_depot': is_depot,
        'is_retrait': is_retrait,
        'date_transactions': date_transactions,
        'n_user_connecte': n_user_connecte,
        'expediteur_firstname': expediteur_firstname,
        'expediteur_phone_number': expediteur_phone_number,
        'destinataire_firstname': destinataire_firstname,
        'destinataire_phone_number': destinataire_phone_number,
      }),
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
                  /** ici on verifie si le numero de celui qui a envoye l'argent c'est notre numero(numero de l'utilisateur connecte) pour afficher son, et aussi on verifie si c'est un nouvelle utilisateur on affiche nouvelle utilisateur */
                  n_expediteur == n_user_connecte
                      ? is_depot == 1
                          ? 'Depot'
                          : destinataire_firstname == 'new'
                              ? 'À nouvelle utilisateur '
                                  .characters
                                  .take(22)
                                  .toString()
                              : 'À '.characters.take(22).toString() +
                                  destinataire_firstname
                      : is_retrait == 1
                          ? 'Retrait'
                          : is_depot == 1
                              ? 'Depot'
                              : expediteur_firstname == 'new'
                                  ? 'De nouvelle utilisateur'
                                      .characters
                                      .take(22)
                                      .toString()
                                  : 'De '.characters.take(22).toString() +
                                      expediteur_firstname,
                  style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.020,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      n_expediteur == n_user_connecte
                          ? statut == 1
                              ? 'Envoyé'
                              : 'Annulé'
                          : is_retrait == 1
                              ? 'Retiré'
                              : statut == 1
                                  ? 'Reçu'
                                  : 'Annulé',
                      style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.015,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: AppColor.appGrey,
                      ),
                    ),
                    Icon(
                      n_expediteur == n_user_connecte
                          ? statut == 1
                              ? Icons.arrow_downward
                              : Icons.cancel_outlined
                          : is_retrait == 1
                              ? Icons.arrow_downward
                              : statut == 1
                                  ? Icons.arrow_upward
                                  : Icons.cancel_outlined,
                      color: n_expediteur == n_user_connecte
                          ? Color.fromARGB(255, 203, 78, 78)
                          : is_retrait == 1
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
