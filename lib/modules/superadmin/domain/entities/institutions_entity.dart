class InstitutionsEntity {
  final int? id;
  final String? name;
  final String? emailContact;
  final String? logo;

  InstitutionsEntity({ this.id,  this.name,  this.emailContact,  this.logo });

  factory InstitutionsEntity.fromJson(Map<String, dynamic> json) {
    return InstitutionsEntity(
      id: json['institutionId'],
      name: json['name'],
      emailContact: json['email_contact'],
      logo: json['logo'],
    );
  }
}