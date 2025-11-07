import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_app/api/api_client.dart';
import 'package:my_app/models/requests/login_request.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/models/responses/user.dart';

class HomeServices {
  Dio? dio;

  // AuthServices() async {
  //   dio = ApiClient.getDio();
  // }

  Future<ApiResponse<List<Category>>> getAllCategories() async {
    dio = await ApiClient.getDio();

    try {
      final response = await dio!.get("/products/categories");

      if (response.statusCode == 200) {
        Iterable list = response.data;

        List<Category> categories = [];

        // for (int i = 0; i < list.length; i++) {
        //   categories.add(Category.fromJson(list.elementAt(i)));
        // }

        categories =
            list.map((model) => Category.fromJson(model)).toList();

        return ApiResponse(
            data: categories,
            statusCode: response.statusCode,
            message: response.statusMessage);
      } else {
        return ApiResponse(
            statusCode: response.statusCode, message: response.statusMessage);
      }
    } catch (e) {
      print("**/** ${e}");
      if (e is DioException) {
        return ApiResponse(
            statusCode: e.response!.statusCode,
            message: e.response!.data['message']);
      }

      return ApiResponse(statusCode: 0, message: "Something went wrong");
    }
  }
}
