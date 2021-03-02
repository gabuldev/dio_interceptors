import 'package:dio/dio.dart';

///You can use for add JWT all requests
///
///[PARAMS]
///
///You can create method return Future<String> with JWT
///
///InterceptorToken(token: YOU_FUNCTION_HERE)
///
class InterceptorToken extends InterceptorsWrapper {
  final Future<String> Function() token;

  InterceptorToken({required this.token});

  @override
  Future onRequest(RequestOptions options) async {
    options.headers.addAll({"authorization": await token()});
    return options;
  }
}
