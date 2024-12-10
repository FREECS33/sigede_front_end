
class CodeConfirmationEntity {
  final String code;
  final String userEmail;
  
  CodeConfirmationEntity({required this.code,required this.userEmail});
}

class ResponseCodeConfirmationEntity {
  final int status;
  final String message;
  final bool error;
  final String data;
  
  ResponseCodeConfirmationEntity({required this.status,required this.message,required this.error,required this.data});
}