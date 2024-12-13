import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _tokenKey = 'auth_token';
  static const _userEmail = 'user_email';
  static const _institutionId = 'institution_id';

  /// Guarda el token en SharedPreferences.
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Recupera el token de SharedPreferences.
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Elimina el token de SharedPreferences.
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Guardar el correo del usuario
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmail, email);
  }

  // Guardar el id de la institución
  static Future<void> saveInstitutionId(int? institutionId) async {
    final prefs = await SharedPreferences.getInstance();
    if (institutionId != null) {
      await prefs.setInt(_institutionId, institutionId);
    } else {
      await prefs.remove(_institutionId);
    }
  }

  static Future<void> saveLogo(String logo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logo', logo);
  }

  static Future<String?> getLogo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('logo');
  }
  
  static Future<void> clearLogo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logo');
  }

  // name de la isntitución
  static Future<void> saveInstitutionName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('institution_name', name);
  }

  static Future<String?> getInstitutionName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('institution_name');
  }

  static Future<void> clearInstitutionName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('institution_name');
  }

  // Recupera el correo del usuario
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmail);
  }

  // Recupera el Id de la institución
  static Future<int?> getInstituionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_institutionId);
  }

  // Elimina el correo del usuario
  static Future<void> clearUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userEmail);
  }

  // Elimina el id de la institución
  static Future<void> clearInstitutionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_institutionId);
  }

  // guardar userId
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  // recuperar userId
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // eliminar userId
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }
}
