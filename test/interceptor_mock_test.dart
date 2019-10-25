import 'package:dio/dio.dart';
import 'package:dio_interceptors/dio_interceptors.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  Dio dio = Dio();

  var mockData = {
     "/test" : {
       "name" : "Gabul DEV",
       "site" : "https://gabul.dev"
     }
   };

   dio.interceptors.add(InterceptorMock(mockData));
  
  test('Test InterceptorMock', () async {

     var res = await dio.get("/test");

     expect(res.data, isInstanceOf<Map>());
     expect(res.data["name"], "Gabul DEV"); 
      expect(res.data["site"], "https://gabul.dev"); 
   

  });
}
