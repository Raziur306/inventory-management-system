import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';

import '../widget/drawer_menu_widget.dart';
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    drawer: const DrawerMenuWidget(),
    appBar: AppBar(
      title: const Text("Products"),
      actions: AppbarActionMenu.actionFun(context),
    ),

  );
}