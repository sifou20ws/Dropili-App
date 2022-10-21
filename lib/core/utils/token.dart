import 'package:shared_preferences/shared_preferences.dart';

class TokenHandler {
  static Future<String?> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('access_token');

    return token;
  }

  static Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
