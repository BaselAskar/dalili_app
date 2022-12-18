import 'dart:convert';

import 'package:dalili_app/src/utils/shared_data.dart';

import './constants.dart';
import 'package:http/http.dart' as http;
import './token_services.dart' as ts;

enum Methods { get, post, put, delete }

enum Behavior { one, multi }

class HttpRequest {
  final String url;
  final Methods method;
  final Behavior behavior;
  final String? contentType;
  final bool auth;

  HttpRequest({
    required this.url,
    this.method = Methods.get,
    this.behavior = Behavior.multi,
    this.contentType,
    this.auth = false,
  });

  bool _proccess = false;
  http.Response? _response;

  http.Response? get response {
    return this._response;
  }

  bool get wating {
    return _proccess;
  }

  Future sendRequest({
    Object? body,
    List<String>? pathParams,
    Map<String, String>? query,
  }) async {
    if (behavior == Behavior.one && _proccess) return;

    _proccess = true;
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

    if (auth) {
      headerArg.addAll({'Authorization': await ts.getToken()});
    }

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

    if (_response == null || _response!.statusCode >= 400) {
      _proccess = false;
      throw _response != null
          ? jsonDecode(_response!.body)
          : 'There is error occurding request';
    }

    if (auth) {
      ts.refreshToken(response!);
    }

    dynamic result;
    try {
      result = jsonDecode(_response!.body);
    } catch (ex) {
      result = _response!.body;
    } finally {
      _proccess = false;
      return result;
    }
  }
}
