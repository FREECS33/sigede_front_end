class LoginModel {
  final String userEmail;
  final String password;

  LoginModel({
    required this.userEmail,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userEmail: json['userEmail'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'password': password,
    };
  }
}