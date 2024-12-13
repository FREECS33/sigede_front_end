class CredentialEntity {
  final int userAccountId;
  final String name;
  final String status;
  final String email;

  CredentialEntity({required this.userAccountId, required this.name, required this.status, required this.email});
}

class CredentialInstitutionEntity {
  final int institutionId;
  final String fullname;

  const CredentialInstitutionEntity({required this.institutionId, required this.fullname});
}

class ResponseCredentialInstitutionEntity {
  final int credentialId;
  final String fullname;
  final String userPhoto;
  final DateTime expirationDate;

  const ResponseCredentialInstitutionEntity({required this.credentialId, required this.fullname, required this.userPhoto, required this.expirationDate});
}