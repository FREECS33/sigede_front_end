class ResetPasswordEntity {
  final String? newPassword;
  final String? userEmail;
  final bool? error;
  ResetPasswordEntity({
    this.newPassword,
    this.userEmail,
    this.error, 
  });
}