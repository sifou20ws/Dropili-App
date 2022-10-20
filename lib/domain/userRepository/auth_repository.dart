import 'package:dropili/core/api/post_get.dart';

class AuthRepository {
  Future<String> loginUser(
      {required String username,
      required String password,
      String deviceName = 'poco'}) async {
    var data = {
      'username': username,
      'password': password,
      'device_name': deviceName
    };
    // var response;
    // try {
    var response = await Network().post('/token', data);
    // } catch (e) {
    // throw e;
    // }
    // print(response.body);
    return 'token';
  }

  Future<String> signupUser(
      {required String email,
      required String password,
      required String name,
      required String username}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }
}
