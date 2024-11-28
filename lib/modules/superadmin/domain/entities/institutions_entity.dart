class InstitutionsEntity {
  final int? id;
  final String? name;
  final String? email_contact;
  final String? logo;
  final List<InstitutionsEntity> data;

  InstitutionsEntity({ this.id,  this.name,  this.email_contact,  this.logo,required this.data, });
}