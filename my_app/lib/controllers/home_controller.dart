import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/models/responses/user.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:my_app/services/home_services.dart';

class HomeController extends ChangeNotifier {
  HomeServices homeServices = HomeServices();
  List<Category> categories = [];

  Future<void> getAllCategories() async {
    ApiResponse<List<Category>>? response = await homeServices.getAllCategories();

    print("//// ${response.statusCode}");

    if (response.statusCode == 200) {
      setAllCategoriesList(response.data!);
    }
  }

  void setAllCategoriesList(List<Category> categories) {
    this.categories = categories;

    notifyListeners();
  }
}
