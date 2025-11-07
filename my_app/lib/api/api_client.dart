import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const baseUrl = "https://dummyjson.com/";

  static Future<Dio> getDio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${prefs.getString("accessToken")}"
        });

    Dio dio = Dio(options);

    return dio;
  }
}
