class CapturistModel {
  final String name;
  final String email;
  final int fkInstitution;

  CapturistModel({
    required this.name,
    required this.email,
    required this.fkInstitution
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'fkInstitution': fkInstitution
    };
  }
}