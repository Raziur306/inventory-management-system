import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Inventory Management System" ,style: TextStyle(color: Colors.black),),
          actions: AppbarActionMenu.actionFun(context)),
      body: const Center(
          child: Text(
        "From Home Page",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      )),
      drawer: const DrawerMenuWidget(),
    );
  }
}
