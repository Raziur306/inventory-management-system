import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management_system/pages/customer_page.dart';
import 'package:inventory_management_system/pages/home_pages.dart';
import 'package:inventory_management_system/pages/inventory_page.dart';
import 'package:inventory_management_system/pages/login_page.dart';
import 'package:inventory_management_system/pages/purchasePage.dart';
import 'package:inventory_management_system/pages/salesPage.dart';
import 'package:inventory_management_system/pages/user_management_page.dart';
import 'package:inventory_management_system/pages/vendor_management_page.dart';
import 'package:inventory_management_system/utils/data.dart';
import 'package:inventory_management_system/utils/routes.dart';

void main(List<String> args) {
  Firestore.initialize(SavedData.projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: GoogleFonts.lato().fontFamily,
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black))),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/login",
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.inventoryRoute: (context) => const InventoryPage(),
        MyRoutes.userManagementRoute: (context) => const UserManagementPage(),
        MyRoutes.vendorManagementRoute: (context) => const VendorManagementPage(),
        MyRoutes.salesRoute: (context) => const SalesManagementPage(),
        MyRoutes.customerRoutes: (context) => const CustomerPage(),
        MyRoutes.purchaseRoute:(context)=>const PurchasePage()
      },
    );
  }
}
