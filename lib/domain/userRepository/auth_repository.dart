import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
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
    http.Response response;

    try {
      response = await Network().post('/token', data);
    } catch (e) {
      rethrow;
    }
    return response.body;
  }

  Future<bool> signupUser(
      {required String email,
      required String password,
      required String name,
      required String username}) async {
    var data = {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
    };

    http.Response response;

    try {
      response = await Network().post('/register', data);
      return jsonDecode(response.body)['success'];
    } catch (e) {
      rethrow;
    }
  }
}
