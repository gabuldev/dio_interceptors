import 'package:dio/dio.dart';
import 'package:dio_interceptors/src/mock/mock.dart';

/// You can use for Mock your API
///
/// Implements your mockData based example:
///
/// ```
/// const MOCKDATA = {
/// "/path":{YOURDATA}
/// };
/// ```
///
/// Examples use `YOURDATA``
///
/// ```
/// YOURDATA = ["1","2"];
///
/// YOURDATA = {"name1": "1"}
/// ```
class InterceptorMock implements InterceptorsWrapper {
  final Mock mock;

  InterceptorMock(this.mock);
  @override
  Future onRequest(RequestOptions options) async {
    return this.mock.verify(options);
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }

  @override
  Future onError(DioError err) async {
    return err;
  }
}
