class Capturista {
  final String email;
  final String name;
  final String rol;
  final String status;
  final int institution;

  Capturista({
    required this.email,
    required this.name,
    required this.rol,
    required this.status,
    required this.institution,
  });

  factory Capturista.fromJson(Map<String, dynamic> json) {
    return Capturista(
      email: json['email'],
      name: json['name'],
      rol: json['rol'],
      status: json['status'],
      institution: json['institution'],
    );
  }
}