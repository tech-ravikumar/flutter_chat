import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventKey = prefs.getString('event_key');
    // String eventKey = "EVENT23";
    if(eventKey!=null) {
      options.headers.addAll({'EVENT-KEY': eventKey});
    }
    if (options.headers.containsKey("token")) {
      // print('asking token');
      //remove the auxiliary header
      options.headers.remove("token");
      var token =  prefs.get("token");
      // var token = "eyJpdiI6InJOMTRMaFdXWkVUWmdlOUp6ZU9jemc9PSIsInZhbHVlIjoic1VvOERoeFNUWUFVbGRBYys2Y2VwY0xMQ29vTUR4bGFIM3dsaEJleDhTcjdJU014MmlOS2Z4aWlhdVZ3ZURSL20rRU1sdDJhNDYrUytyWk9CRGxvbWc9PSIsIm1hYyI6ImE2MzQ2OGZmY2JkZjZmMTRkNzc2ZWE0YTQ2MzBhZDkzMWZiZWQ4YWZkM2VhNjU0YzE3NDQ5OGZmNTM5MGY4ODEiLCJ0YWciOiIifQ==";

      // options.headers.addAll({"token": "$header"});
      options.headers["Authorization"] = "Bearer $token";
      return handler.next(options);
    }
    return handler.next(options);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response?.statusCode != null &&
        err.response?.statusCode == 401) {
      // (await CacheManager()).cleanCache();
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("apiToken", "");
      // navigatorKey.currentState.pushNamed(SplashScreen.routeName);

    }
    debugPrint('error response: ${err.response}');
    return handler.next(err);
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // print(response);
    return handler.next(response);
  }
}