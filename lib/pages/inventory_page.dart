import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';
class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    drawer: const DrawerMenuWidget(),
    appBar: AppBar(
      title: const Text("Inventory"
      ),
      actions: AppbarActionMenu.actionFun(context),
    ),

  );
}