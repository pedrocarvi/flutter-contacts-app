class SignUpModel {
  final String name;
  final String lastName;
  final String userName;
  final String email;
  final String password;

  SignUpModel({
    required this.name,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
