import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.pexels.com/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
    debugPrint(dio.runtimeType.toString());
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    // String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : '563492ad6f917000010000011a29dd2926944efa9468d621881b813f',
    };
    return await dio!.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    // String? token,
  }) async{
    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : '563492ad6f917000010000011a29dd2926944efa9468d621881b813f',
    };
    return await dio!.post(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async{
    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : '563492ad6f917000010000011a29dd2926944efa9468d621881b813f',
    };
    return await dio!.put(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async{
    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : '563492ad6f917000010000011a29dd2926944efa9468d621881b813f',
    };
    return await dio!.delete(
      path,
      queryParameters: query,
      data: data,
    );
  }

}
