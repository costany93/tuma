class UserModel {
  final int userId;
  final String firstname;
  final String lastname;
  final int solde;

  const UserModel({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.solde,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      solde: json['solde'] as int,
    );
  }
}
