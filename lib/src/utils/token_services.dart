import 'package:http/http.dart';
import './shared_data.dart';

Future<String> getToken() async {
  final Map<String, dynamic>? user = await ShD.getUser();

  if (user == null) return '';

  final String token = user['token'];

  return 'Bearer $token';
}

Future<void> setToken(tokenValue) async {}

Future<void> refreshToken(Response response) async {
  if (response.statusCode < 400) {
    final String? newToken = response.headers['refresh_token'];
    if (newToken != null) ShD.setToken(newToken);
  }
}
