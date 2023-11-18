class UserTransactionModel {
  int? userId;
  String? transaction_id;
  String? n_expediteur;
  String? n_destinataire;
  int? montant;
  bool? statut;
  bool? is_transfert;
  bool? is_depot;
  bool? is_retrait;
  DateTime? date_transactions;

  UserTransactionModel({
    this.userId,
    this.transaction_id,
    this.n_expediteur,
    this.n_destinataire,
    this.montant,
    this.statut,
    this.is_transfert,
    this.is_depot,
    this.is_retrait,
    this.date_transactions,
  });

  UserTransactionModel.fromJson(Map<String, dynamic> json) {
    userId:
    json['id'];
    transaction_id:
    json['transaction_id'];
    n_expediteur:
    json['n_expediteur'];
    n_destinataire:
    json['n_destinataire'];
    montant:
    json['montant'];
    statut:
    json['statut'];
    is_transfert:
    json['is_transfert'];
    is_depot:
    json['is_depot'];
    is_retrait:
    json['is_retrait'];
    date_transactions:
    json['date_transactions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = userId;
    data['transaction_id'] = transaction_id;
    data['n_expediteur'] = n_expediteur;
    data['n_destinataire'] = n_destinataire;
    data['montant'] = montant;
    data['statut'] = statut;
    data['is_transfert'] = is_transfert;
    data['is_depot'] = is_depot;
    data['is_retrait'] = is_retrait;
    data['date_transactions'] = date_transactions;
    return data;
  }
}
