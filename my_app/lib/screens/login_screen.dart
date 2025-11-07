import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/core/constant/app_colors.dart';
import 'package:my_app/core/constant/navigator_utils.dart';
import 'package:my_app/models/responses/api_response.dart';
import 'package:my_app/widgets/custom_elevated_button.dart';
import 'package:my_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Info",
          style: TextStyle(color: AppColors.titleAppBarColor),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            CustomTextField(
              controller: usernameController,
              labelText: "Username",
              prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
            ),
            SizedBox(
              height: h * 0.015,
            ),
            CustomTextField(
              controller: passwordController,
              labelText: "Password",
              prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            CustomElevatedButton(
              text: "Login",
              onPressed: () {
                login();
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);

    ApiResponse apiResponse = await authController.login(
        username: usernameController.text, password: passwordController.text);

    if (apiResponse.statusCode == 200) {
      NavigatorUtils.navigateToHomeScreen(context);
    } else {
      print("//////////////// ${apiResponse.message}");
    }
  }
}
