import "package:flutter/material.dart";
import 'package:get_storage/get_storage.dart';
import 'package:progmob/home_page.dart';
import 'package:progmob/login_page.dart';
import 'package:progmob/register_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      initialRoute: '/login', // Start the app with the login page
    );
  }
}
