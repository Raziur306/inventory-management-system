import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management_system/pages/home_pages.dart';
import 'package:inventory_management_system/pages/login_page.dart';
import 'package:inventory_management_system/utils/routes.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: GoogleFonts.lato().fontFamily),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/login",
      routes: {
        MyRoutes.homeRoute:(context) => HomePage(),
        MyRoutes.loginROute:(context)=>LoginPage()
      },
    );
  }
}
