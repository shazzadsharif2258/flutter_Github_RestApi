import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_restapi/data/app_exception.dart';

class NetworkApiService {
  final dio = Dio();

  Future getApi(String url) async {
    try {
      final res = await dio
          .get(url)
          .timeout(Duration(seconds: 10));

      return returnResponse(res);
    } on SocketException {
      throw InternetException();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw RequestTimeOut();
      } else {
        throw ServerExceptions();
      }
    }
  }

  Future postApi(dynamic data, String url) async {
    try {
      final res = await dio
          .post(url, data: data)
          .timeout(Duration(seconds: 10));

      return returnResponse(res);
    } on SocketException {
      throw InternetException();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw RequestTimeOut();
      } else {
        throw ServerExceptions();
      }
    }
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        return response.data;
      case 404:
        throw UserNotFoundException('User not found');
      case 500:
        throw ServerExceptions('Internal Server Error');
      default:
        throw RequestTimeOut(
          'Error Connected to Server ${response.statusCode.toString()}',
        );
    }
  }
}
