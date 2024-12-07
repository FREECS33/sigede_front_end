class InstitutionEntity {
  final int institutionId;
  final String name;
  final String emailContact;
  final String logo;

  InstitutionEntity({required this.institutionId, required this.name, required this.emailContact, required this.logo});
}

class PageEntity {
  final String name;
  final int page;
  final int size;

  PageEntity({required this.name, required this.page, required this.size});
}

class AddInstitutionEntity {
  final String institutionName;
  final String institutionAddress;
  final String institutionEmail;
  final String institutionPhone;
  final String logo;

  AddInstitutionEntity({required this.institutionName, required this.institutionAddress, required this.institutionEmail, required this.institutionPhone, required this.logo});
}

class ResponseAddInstitutionEntity {
  final int id;  

  ResponseAddInstitutionEntity({required this.id});
}