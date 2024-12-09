class LoginEntity {
  final String email;
  final String password;  
  LoginEntity({required this.email,required this.password,});
}

class ResponseLoginEntity {
  final String token;
  final String email;
  final int userId;
  final int institutionId;

  ResponseLoginEntity({required this.token,required this.email,required this.userId,required this.institutionId});
}