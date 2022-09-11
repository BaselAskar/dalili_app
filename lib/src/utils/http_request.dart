import 'dart:convert';

import './constants.dart';
import 'package:http/http.dart' as http;

enum Methods { get, post, put, delete }

class HttpRequest {
  final String url;
  final Methods method;
  final String? contentType;
  final Object? body;

  HttpRequest({
    required this.url,
    this.method = Methods.get,
    this.contentType,
    this.body,
  });

  Future sendRequest() async {
    // var uriArg = Uri.parse(BASE_API + url);

    var uriArg = Uri.https(BASE_API_HTTPS, url);

    Map<String, String> headerArg =
        contentType != null ? {'Content-Type': contentType as String} : {};

    var bodyArg = contentType == APPLICATION_JSON ? jsonEncode(body) : {};

    http.Response response;
    switch (method) {
      case Methods.get:
        response = await http.get(uriArg, headers: headerArg);
        break;

      case Methods.post:
        response = await http.post(uriArg, headers: headerArg, body: bodyArg);
        break;

      case Methods.put:
        response = await http.put(uriArg, headers: headerArg, body: bodyArg);
        break;

      case Methods.delete:
        response = await http.delete(uriArg, headers: headerArg, body: bodyArg);
        break;
    }

    if (response.statusCode != 200) throw Exception(jsonDecode(response.body));

    return jsonDecode(response.body);
  }
}
