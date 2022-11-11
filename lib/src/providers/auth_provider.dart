import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier {
  bool _isLogin = false;

  HttpRequest _loginReq = HttpRequest(
    url: '/api/account/login',
    method: Methods.post,
    contentType: APPLICATION_JSON,
  );

  HttpRequest _logoutReq =
      HttpRequest(url: '/api/account/logout', method: Methods.post);

  bool get isLogin => _isLogin;
}
