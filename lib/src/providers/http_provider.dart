import 'dart:convert';

import 'package:flutter_launcher_icons/main.dart';

import '../utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

enum Methods { get, post, put, delete }

class HttpProvider with ChangeNotifier {
  //Initailed states
  String? url;
  Methods method = Methods.get;
  String? contentType;
  Map<String, dynamic>? body;

  Function? applyData;

  void Function(dynamic error)? applyError = (error) {
    print(error);
  };

  //states
  bool isLoading = false;
  http.Response? response;

  void Init({
    required String url,
    Methods method = Methods.get,
    String? contentType,
    Map<String, dynamic>? body,
    Function(dynamic error)? applyError,
    required Function applyData,
  }) {
    this.url = url;
    this.method = method;
    this.contentType = contentType;
    this.body = body;
    this.applyError = applyError;
    this.applyData = (data) {
      print(data);
    };
  }

  Future<void> sendRequest() async {
    if (url == null) throw new Exception("Initial request first");

    isLoading = true;
    notifyListeners();

    try {
      String uriPath = BASE_API + (url as String);

      switch (method) {
        case Methods.get:
          response = await http.get(Uri.parse(uriPath));
          break;

        case Methods.post:
          response = await http.post(Uri.parse(uriPath));
          break;

        case Methods.put:
          response = await http.put(Uri.parse(uriPath));
          break;

        case Methods.delete:
          response = await http.delete(Uri.parse(uriPath));
          break;
      }

      if (response!.statusCode >= 400) throw jsonDecode(response!.body);

      Map<String, dynamic> data = jsonDecode(response!.body);

      applyData!(data);
    } catch (error) {
      applyError!(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
