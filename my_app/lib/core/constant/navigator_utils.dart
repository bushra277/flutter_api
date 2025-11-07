import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/products_screen.dart';

class NavigatorUtils {
  static void navigateToHomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  static void navigateToLoginScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static void navigateToProductsScreen(
      BuildContext context, String categoryName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsScreen(
                  categoryName: categoryName,
                )));
  }
}
