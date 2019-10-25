import 'package:dio/dio.dart';

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
  final Map mockData;

  InterceptorMock(this.mockData);
  @override
  Future onRequest(RequestOptions options) async {
    if (mockData.containsKey(options.path)) {
      return Response(statusCode: options.method == "GET" ? 200 : 201, data: mockData[options.path]);
    } else {
     throw DioError(type: DioErrorType.RESPONSE,error: "Don't have on MOCKDATA");
    }
  }

  @override
  Future onResponse(Response response) async {
    
    return response;
  }

  @override
  Future onError(DioError err) async{
    return err;
  }
}
