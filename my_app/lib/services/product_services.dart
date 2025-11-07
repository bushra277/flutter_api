import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_app/api/api_client.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/models/responses/product_by_category_response.dart';
import 'package:my_app/models/responses/user.dart';

class ProductServices {
  Dio? dio;

  // AuthServices() async {
  //   dio = ApiClient.getDio();
  // }

  Future<ApiResponse<List<Product>>> getAllProducts(
      {String? categoryName}) async {
    dio = await ApiClient.getDio();

    try {
      final response = await dio!.get("/products/category/$categoryName");

      if (response.statusCode == 200) {
        ProductByCategoryResponse productByCategoryResponse =
            ProductByCategoryResponse.fromJson(response.data);

        return ApiResponse(
            data: productByCategoryResponse.products,
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

  Future<ApiResponse> deleteProduct({int? productId}) async {
    dio = await ApiClient.getDio();

    try {
      final response = await dio!.delete("/products/$productId");

      if (response.statusCode == 200) {
        return ApiResponse(
            statusCode: response.statusCode, message: response.statusMessage);
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

  Future<ApiResponse<Product>> addProduct({String? title}) async {
    dio = await ApiClient.getDio();

    try {
      final addProductRequestJson = jsonEncode({
        "title" : title
      });

      final response = await dio!.post("/products/add",data: addProductRequestJson);

      print("//// ${response}");

      if (response.statusCode == 201) {
        print("////");

        Product addedProduct = Product.fromJson(response.data);

        print("////");

        return ApiResponse(
            data: addedProduct,
            statusCode: response.statusCode,
            message: response.statusMessage);
      } else {
        return ApiResponse(
            statusCode: response.statusCode, message: response.statusMessage);
      }
    } catch (e) {
      print("//// ${e}");

      if (e is DioException) {
        return ApiResponse(
            statusCode: e.response!.statusCode,
            message: e.response!.data['message']);
      }

      return ApiResponse(statusCode: 0, message: "Something went wrong");
    }
  }

  Future<ApiResponse<Product>> updateProduct({
  required int id,
  required String? title,
}) async {
  try {
    final response = await dio!.put(
      '/products/$id',
      data: {'title': title},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      final product = Product.fromJson(response.data);
      return ApiResponse(statusCode: 200, data: product);
    } else {
      return ApiResponse(statusCode: response.statusCode ?? 400, data: null);
    }
  } catch (e) {
    print('Error updating product: $e');
    return ApiResponse(statusCode: 500, data: null);
  }
}

}
