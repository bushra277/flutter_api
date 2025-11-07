import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/core/constant/navigator_utils.dart';
import 'package:my_app/models/responses/api_response.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }

  void checkUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString("accessToken");

    if (accessToken != null) {
      getUserInfo();
    } else {
      NavigatorUtils.navigateToLoginScreen(context);
    }
  }

  void getUserInfo() async {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);

    ApiResponse apiResponse = await authController.getUserInfo();

    print("//// ${apiResponse.statusCode}");

    if (apiResponse.statusCode == 200) {
      NavigatorUtils.navigateToHomeScreen(context);
    } else {
      NavigatorUtils.navigateToLoginScreen(context);
    }
  }
}
