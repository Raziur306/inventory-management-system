import 'package:flutter/material.dart';
import 'package:inventory_management_system/widget/drawer_widget.dart';
class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    drawer: const MenuWidget(),
    appBar: AppBar(
      title: const Text("Inventory"),
    ),

  );
}