import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShD {
  static Future<bool> setUser(Map<String, dynamic> userData) async {
    final pref = await SharedPreferences.getInstance();

    String userJson = jsonEncode(userData);

    if (userData.containsKey('token')) return pref.setString('user', userJson);

    return false;
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final pref = await SharedPreferences.getInstance();

    String? userJson = await pref.getString('user');

    if (userJson == null) return null;

    return jsonDecode(userJson);
  }

  static Future<void> RemoveUser() async {
    final pref = await SharedPreferences.getInstance();

    await pref.clear();
  }
}
