import 'dart:convert';

import './constants.dart';
import 'package:http/http.dart' as http;

enum Methods { get, post, put, delete }

class HttpRequest {
  final String url;
  final Methods method;
  final String? contentType;
  // final Object? body;
  final bool auth;

  HttpRequest({
    required this.url,
    this.method = Methods.get,
    this.contentType,
    // this.body,
    this.auth = false,
  });

  http.Response? _response;

  http.Response? get response {
    return this._response;
  }

  Future sendRequest({
    Object? body,
    List<String>? pathParams,
    Map<String, String>? query,
  }) async {
    _response = null;

    pathParams = pathParams ?? [];
    String pathForUrl = '';

    for (String param in pathParams) {
      pathForUrl += '/${param}';
    }

    query = query ?? {};
    String queryUrl = '';

    if (!query.isEmpty) {
      queryUrl += '?';

      for (String queryParam in query.keys) {
        queryUrl += '$queryParam=${query[queryParam]}&';
      }

      queryUrl = queryUrl.substring(0, (queryUrl.length - 1));
    }

    var uriArg = Uri.parse(BASE_API + url + pathForUrl + queryUrl);

    Map<String, String> headerArg =
        contentType != null ? {'Content-Type': contentType as String} : {};

    var bodyArg = contentType == APPLICATION_JSON ? jsonEncode(body) : {};

    switch (method) {
      case Methods.get:
        _response = await http.get(uriArg, headers: headerArg);
        break;

      case Methods.post:
        _response = await http.post(uriArg, headers: headerArg, body: bodyArg);
        break;

      case Methods.put:
        _response = await http.put(uriArg, headers: headerArg, body: bodyArg);
        break;

      case Methods.delete:
        _response =
            await http.delete(uriArg, headers: headerArg, body: bodyArg);
        break;
    }

    if (_response?.statusCode as int >= 400) {
      throw jsonDecode(_response!.body);
    }

    try {
      return jsonDecode(_response!.body);
    } catch (ex) {
      throw 'error Request';
    }
  }
}
