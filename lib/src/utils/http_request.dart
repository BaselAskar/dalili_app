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

  http.Response? _response;

  http.Response? get response {
    return this._response;
  }

  Future sendRequest({
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

    var uriArg = Uri.parse(BASE_API_HTTPS + url + pathForUrl + queryUrl);

    Map<String, String> headerArg =
        contentType != null ? {'Content-Type': contentType as String} : {};

    var bodyArg = contentType == APPLICATION_JSON ? jsonEncode(body) : {};

    // http.Response response;
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

    if (_response?.statusCode != 200)
      throw Exception(jsonDecode(_response!.body));

    return jsonDecode(_response!.body);
  }
}
