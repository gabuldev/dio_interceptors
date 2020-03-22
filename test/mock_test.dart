import 'package:dio/dio.dart';
import 'package:dio_interceptors/dio_interceptors.dart';
import 'package:dio_interceptors/src/mock/mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Mock mock = Mock();

  group("TEST MOCK", () {
    test("GET Method and authenticated false", () async {
      Dio dio = Dio();
      mock.add(
          path: "/test", method: MockMethod.GET, success: {"success": true});
      dio.interceptors.add(InterceptorMock(mock));
      final result = await dio.get("/test");
      expect(result.data, {"success": true});
    });

    test("GET Method and authenticated true", () async {
      Dio dio = Dio();
      dio.interceptors.add(InterceptorToken(token: mockToken));
      mock.add(
          path: "/test",
          method: MockMethod.GET,
          success: {"success": true},
          isAuthenticated: true);
      dio.interceptors.add(InterceptorMock(mock));
      final result = await dio.get("/test");
      expect(result.data, {"success": true});
    });

    test("POST Method and authenticated false", () async {
      Dio dio = Dio();
      mock.add(
        path: "/test",
        method: MockMethod.POST,
        success: {"success": true},
        body: {"email": "email"},
      );
      dio.interceptors.add(InterceptorMock(mock));
      final result = await dio.post("/test", data: {"email": "email"});
      expect(result.data, {"success": true});
    });

    test("POST Method and authenticated true", () async {
      Dio dio = Dio();
      dio.interceptors.add(InterceptorToken(token: mockToken));
      mock.add(
          path: "/test",
          method: MockMethod.POST,
          success: {"success": true},
          body: {"email": "email"},
          isAuthenticated: true);
      dio.interceptors.add(InterceptorMock(mock));
      final result = await dio.post("/test", data: {"email": "email"});
      expect(result.data, {"success": true});
    });

    test("POST Method, authenticated true and return error", () async {
      Dio dio = Dio();
      dio.interceptors.add(InterceptorToken(token: mockToken));
      mock.add(
          path: "/test",
          method: MockMethod.POST,
          error: {"error": true},
          success: {"success": true},
          body: {"email": "email"},
          isAuthenticated: true);
      dio.interceptors.add(InterceptorMock(mock));
      try {
        await dio.post("/test", data: {"email": "e"});
      } on DioError catch (e) {
        print(e);
        expect(e.error, {"error": true});
      }
    });
  });
}

Future<String> mockToken() async => "132";
