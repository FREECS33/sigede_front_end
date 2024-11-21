class Capturista {
  final String id;
  final String nombre;
  final String correo;
    bool isActive;

  Capturista({
    required this.id,
    required this.nombre,
    required this.correo,
    this.isActive = true,
  });

  factory Capturista.fromJson(Map<String, dynamic> json) {
    return Capturista(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'isActive': isActive,
    };
  }
}
