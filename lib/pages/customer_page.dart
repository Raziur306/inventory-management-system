import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';
class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: AppbarActionMenu.actionFun(context),
      ),
    drawer: const DrawerMenuWidget(),
    );
  }
}

