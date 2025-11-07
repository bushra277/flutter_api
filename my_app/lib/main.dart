import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/controllers/home_controller.dart';
import 'package:my_app/controllers/products_controller.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider<ProductController>(
          create: (context) => ProductController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
