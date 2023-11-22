class UserModel {
  final int userId;
  final String firstname;
  final String lastname;
  final int solde;
  final String phone_number;
  final int is_client;
  final int is_agent;
  final int is_admin;

  const UserModel({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.solde,
    required this.phone_number,
    required this.is_client,
    required this.is_agent,
    required this.is_admin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      solde: json['solde'] as int,
      phone_number: json['phone_number'] as String,
      is_client: json['is_client'] as int,
      is_agent: json['is_agent'] as int,
      is_admin: json['is_admin'] as int,
    );
  }
}
