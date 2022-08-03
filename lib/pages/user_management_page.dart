import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/utils/user_tiles.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _ManagementState();
}

//variables
var isAdmin = true;
var map;

class _ManagementState extends State<UserManagementPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const DrawerMenuWidget(),
        appBar: AppBar(
          title: const Text("User Management"),
          actions: AppbarActionMenu.actionFun(context),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            UserTilesClass.userTiles(
                context, "4654654", "My Name", "My Email", true)
          ]),
        ),
    floatingActionButton: FloatingActionButton(
      child:const Icon(CupertinoIcons.add),
      onPressed: (){

      },

    ),
      );
}
