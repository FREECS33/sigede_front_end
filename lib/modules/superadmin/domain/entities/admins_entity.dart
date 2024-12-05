class AdminsEntity {
  final int? userId;
  final String? name;
  final String? email;
  final int? fkInstitution;
  final String? role;
  AdminsEntity({this.userId, this.name, this.email,this.fkInstitution,this.role});
  
  factory AdminsEntity.fromJson(Map<String, dynamic> json) {
    return AdminsEntity(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
    );
  }
}