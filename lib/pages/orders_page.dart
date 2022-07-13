import 'package:flutter/material.dart';

import '../widget/drawer_widget.dart';
class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    drawer: const MenuWidget(),
    appBar: AppBar(
      title: const Text("Orders"),
    ),

  );
}