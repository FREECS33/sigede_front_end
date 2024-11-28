class Capturista {
  final int userId;
  final String name;
  final String email;
  //bool isActive;

  Capturista({
    required this.userId,
    required this.name,
    required this.email,
    //this.isActive = true,
  });

  factory Capturista.fromJson(Map<String, dynamic> json) {
    return Capturista(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      //isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      //'isActive': isActive,
    };
  }
}