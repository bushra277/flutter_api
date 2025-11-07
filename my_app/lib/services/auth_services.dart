import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_app/api/api_client.dart';
import 'package:my_app/models/requests/login_request.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/user.dart';

class AuthServices {
  Dio? dio;

  // AuthServices() async {
  //   dio = ApiClient.getDio();
  // }

  Future<ApiResponse<UserInfo>> login(
      {required String username, required String password}) async {
    dio = await ApiClient.getDio();

    try {
      LoginRequest loginRequest =
          LoginRequest(username: username, password: password);

      final loginRequestJson = jsonEncode(loginRequest.toJson());

      final response = await dio!.post("/auth/login", data: loginRequestJson);

      if (response.statusCode == 200) {
        UserInfo userInfo = UserInfo.fromJson(response.data);

        return ApiResponse(
            data: userInfo,
            statusCode: response.statusCode,
            message: response.statusMessage);
      } else {
        return ApiResponse(
            statusCode: response.statusCode, message: response.statusMessage);
      }
    } catch (e) {
      if (e is DioException) {
        return ApiResponse(
            statusCode: e.response!.statusCode,
            message: e.response!.data['message']);
      }

      return ApiResponse(statusCode: 0, message: "Something went wrong");
    }
  }

  Future<ApiResponse<UserInfo>> getUserInfo() async {
    dio = await ApiClient.getDio();

    try {
      final response = await dio!.get("/auth/me");

      if (response.statusCode == 200) {
        UserInfo userInfo = UserInfo.fromJson(response.data);

        return ApiResponse(
            data: userInfo,
            statusCode: response.statusCode,
            message: response.statusMessage);
      } else {
        return ApiResponse(
            statusCode: response.statusCode, message: response.statusMessage);
      }
    } catch (e) {
      if (e is DioException) {
        return ApiResponse(
            statusCode: e.response!.statusCode,
            message: e.response!.data['message']);
      }

      return ApiResponse(statusCode: 0, message: "Something went wrong");
    }
  }
}
