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