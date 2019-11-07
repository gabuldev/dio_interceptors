# dio_interceptors

A interceptors to use on Dio.

## INTERCEPTORS

### Interceptor Mock

You use for mock API requests.

```dart

void main() {
  Dio dio = Dio();

  var mockData = {
     "/test" : {
       "name" : "Gabul DEV",
       "site" : "https://gabul.dev"
     }
   };
   dio.interceptors.add(InterceptorMock(mockData));

   void getData() async{
       var res = await dio.get("/test");
      print(res.data["name"])// "Gabul DEV" 
      print(res.data["site"])// "https://gabul.dev"); 
   }
    
    getData();
}

```

### Interceptor Token

You can use for add JWT all requests

```dart
Future<String> token() async{
  //Implements your logic here
  return jwt;
}

dio.interceptors.add(InterceptorToken(token: () async => await token()))

```


