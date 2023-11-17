class UserTestModel {
  final int userId;
  final String firstname;
  final String lastname;
  final int solde;

  const UserTestModel({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.solde,
  });

  factory UserTestModel.fromJson(Map<String, dynamic> json) {
    return UserTestModel(
      userId: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      solde: json['solde'] as int,
    );
  }
}
