class Capturista {
  final String id;
  final String nombre;
    final String? password;
  final String correo;
    bool isActive;

  Capturista({
    required this.id,
    required this.nombre,
    required this.password,
    required this.correo,
    this.isActive = true,
  });

  factory Capturista.fromJson(Map<String, dynamic> json) {
    return Capturista(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      password: json['password'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'password': password,
      'isActive': isActive,
    };
  }
}
