class UserTransaction {
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
  final String expediteur_firstname;
  final String expediteur_phone_number;
  final String destinataire_firstname;
  final String destinataire_phone_number;

  UserTransaction({
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
    required this.expediteur_firstname,
    required this.expediteur_phone_number,
    required this.destinataire_firstname,
    required this.destinataire_phone_number,
  });
}
