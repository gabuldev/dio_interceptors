import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum MockMethod { GET, POST, PUT, DELETE }

class MockData {
  final MockMethod? method;
  final bool? isAuthenticated;
  final String? path;
  final Map? success;
  final Map? error;

  ///EXPECTED BODY
  ///
  ///EXAMPLE
  ///MOCK LOGIN
  ///body: {"email" : "email@email", "password":"1234"}
  ///
  ///You try request POST and send body
  ///body: {"email" : "email@email", "password":"1234"} => SUCCESS
  ///body: {"email" : "email@email", "password":"14"} => FAILED
  final Map? body;
  MockData(
      {this.success,
      this.error,
      this.body,
      this.path,
      this.method,
      this.isAuthenticated = false})
      : assert(method == MockMethod.GET && body == null ||
            method != MockMethod.GET && body!.isNotEmpty);
}

class Mock {
  Map<String, MockData> _map = <String, MockData>{};
  add(
          {Map? success,
          Map? error,
          Map? body,
          required String path,
          required MockMethod method,
          bool isAuthenticated = false}) =>
      _map.addAll({
        path: MockData(
            success: success,
            error: error,
            body: body,
            path: path,
            method: method,
            isAuthenticated: isAuthenticated)
      });
  Response verify(RequestOptions options) {
    if (_map.containsKey(options.path)) {
      final MockData mock = _map[options.path]!;

      if (mock.isAuthenticated!) {
        if (options.headers.containsKey("authorization")) {
          if (mock.method == MockMethod.GET) {
            return Response(
                statusCode: 200,
                data: mock.success,
                request: RequestOptions(path: options.path));
          } else {
            final data = options.data as Map;
            var response;
            mock.body!.forEach((key, value) {
              if (data.containsKey(key)) {
                if (data[key] == value) {
                  response = Response(
                      statusCode: 201,
                      data: mock.success,
                      request: RequestOptions(path: options.path));
                } else {
                  throw DioError(
                      type: DioErrorType.response, error: mock.error);
                }
              } else {
                throw DioError(type: DioErrorType.response, error: mock.error);
              }
            });
            return response;
          }
        } else {
          throw DioError(type: DioErrorType.response, error: mock.error);
        }
      } else {
        if (mock.method == MockMethod.GET) {
          return Response(
              statusCode: 200,
              data: mock.success,
              request: RequestOptions(path: options.path));
        } else {
          final data = options.data as Map;
          var response;
          mock.body!.forEach((key, value) {
            if (data.containsKey(key)) {
              if (data[key] == value) {
                response = Response(
                    statusCode: 201,
                    data: mock.success,
                    request: RequestOptions(path: options.path));
              } else {
                throw DioError(type: DioErrorType.response, error: mock.error);
              }
            } else {
              throw DioError(type: DioErrorType.response, error: mock.error);
            }
          });
          return response;
        }
      }
    } else {
      throw DioError(
          type: DioErrorType.response, error: "Don't have on MOCKDATA");
    }
  }
}
