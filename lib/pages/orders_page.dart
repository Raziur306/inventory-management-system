import 'package:flutter/material.dart';

import '../utils/appbar_actions_menu.dart';
import '../widget/drawer_menu_widget.dart';
class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    drawer: const DrawerMenuWidget(),
    appBar: AppBar(
      title: const Text("Orders"),
    actions: AppbarActionMenu.actionFun(context),
    ),


  );
}