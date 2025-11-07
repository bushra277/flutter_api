import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/models/responses/product_by_category_response.dart';
import 'package:my_app/models/responses/user.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:my_app/services/home_services.dart';
import 'package:my_app/services/product_services.dart';

class ProductController extends ChangeNotifier {
  ProductServices productServices = ProductServices();
  List<Product> products = [];

  Future<void> getAllProducts({required String? categoryName}) async {
    ApiResponse<List<Product>>? response =
        await productServices.getAllProducts(categoryName: categoryName);

    if (response.statusCode == 200) {
      setAllProductsList(response.data!);
    }
  }

  Future<void> deleteProduct({required int? productId}) async {
    ApiResponse? response =
        await productServices.deleteProduct(productId: productId);

    deleteProductFromList(productId!);
  }

  Future<void> addProduct({required String? title}) async {
    ApiResponse<Product>? response =
        await productServices.addProduct(title: title);

    if (response.statusCode == 201) {
      addProductToList(response.data!);
    }
  }

  void setAllProductsList(List<Product> products) {
    this.products = products;

    notifyListeners();
  }

  void deleteProductFromList(int productId) {
    products.removeWhere(
      (product) => product.id == productId,
    );

    notifyListeners();
  }

  void addProductToList(Product product) {
    products.add(product);

    notifyListeners();
  }

  Future<void> updateProduct({
  required int id,
  required String? title,
}) async {
  ApiResponse<Product>? response =
      await productServices.updateProduct(id: id, title: title);

  if (response?.statusCode == 200 && response?.data != null) {
    updateProductInList(response!.data!);
  } else {
    print('Failed to update product. Status code: ${response?.statusCode}');
  }
}


void updateProductInList(Product updatedProduct) {
  final index = products.indexWhere((product) => product.id == updatedProduct.id);

  if (index != -1) {
    products[index] = updatedProduct;
    notifyListeners();
  }
}

}
