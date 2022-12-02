import 'dart:math';

import 'package:dalili_app/src/utils/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Map<String, String?> _user = {};

  String? _token;

  HttpRequest _loginReq = HttpRequest(
    url: '/api/account/login',
    method: Methods.post,
    contentType: APPLICATION_JSON,
  );

  HttpRequest _registerReq = HttpRequest(
    url: '/api/account/register',
    method: Methods.post,
    contentType: APPLICATION_JSON,
  );

  Future<bool> get isLogin async {
    final result = await ShD.getUser();

    if (result == null) return false;

    return true;
  }

  Future<Map<String, dynamic>?> get user async {
    var result = await ShD.getUser();

    if (result == null) return {};

    return result;
  }

  String? get token => _token;

  Future<void> login(Map<String, dynamic> loginInfo) async {
    var data = await _loginReq.sendRequest(body: loginInfo);

    bool result = await ShD.setUser(data);

    if (result) {
      notifyListeners();
    } else {
      throw Exception('فشل في عملية تسجيل الدخول');
    }
  }

  Future<void> register(Map<String, dynamic> registerInfo) async {
    var data = await _registerReq.sendRequest(body: registerInfo);
    bool result = await ShD.setUser(data);

    if (result)
      notifyListeners();
    else
      throw Exception('فشل في عملية التسجيل');
  }

  Future<void> logout() async {
    await ShD.RemoveUser();
  }
}
