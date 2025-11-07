import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/models/responses/user.dart';
import 'package:my_app/services/auth_services.dart';

class AuthController extends ChangeNotifier {
  AuthServices authServices = AuthServices();
  UserInfo? userInfo;

  Future<ApiResponse> login(
      {required String username, required String password}) async {
    ApiResponse? response =
        await authServices.login(username: username, password: password);

    if (response.statusCode == 200) {
      setUserInfo(userInfo: response.data);

      saveTokenOnSharedPrefs(accessToken: userInfo!.accessToken!);
    }

    return response;
  }

  Future<ApiResponse> getUserInfo() async {
    ApiResponse? response = await authServices.getUserInfo();

    if (response.statusCode == 200) {
      setUserInfo(userInfo: response.data);
    }

    return response;
  }

  void setUserInfo({required UserInfo userInfo}) {
    this.userInfo = userInfo;

    notifyListeners();
  }

  void saveTokenOnSharedPrefs({required String accessToken}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("accessToken", accessToken);
  }
}
