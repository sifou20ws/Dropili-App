import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:dropili/core/api/post_get.dart';

class AuthRepository {
  final Network _network;
  String _deviceName = ' ';

  AuthRepository(this._network) {}

  Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceName = androidInfo.manufacturer +
          ' ' +
          androidInfo.brand +
          ' ' +
          androidInfo.model;
      log(_deviceName);
    } else {
      IosDeviceInfo iosinfo = await deviceInfo.iosInfo;
      _deviceName = iosinfo.model ?? 'iphone';
    }
    return _deviceName;
  }

  Future<String> loginUser({
    required String username,
    required String password,
  }) async {
    var data = {
      'username': username,
      'password': password,
      'device_name': await _getDeviceName(),
    };

    http.Response response;

    try {
      response = await _network.post('/token', data);
    } catch (e) {
      rethrow;
    }
    return response.body;
  }

  Future<String> googleLogin({
    required String name,
    required String email,
    required access_token,
  }) async {
    var data = {
      'email': email,
      'name': name,
      'device_name': await _getDeviceName(),
      'access_token': access_token,
    };

    http.Response response;

    try {
      response = await _network.post('/auth/google', data);
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
      response = await _network.post('/register', data);
      return jsonDecode(response.body)['success'];
    } catch (e) {
      rethrow;
    }
  }
}
