import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountEmail: Text("example@gmail.com"),
                  accountName: Text("Md Raziur Rahaman Ronju",style: TextStyle(fontWeight: FontWeight.bold),),
                  currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/avatar.jpg")))),
          ListTile(
            leading: Icon(CupertinoIcons.home),
            title: Text("Dashboard",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.checkmark_shield),
            title: Text("Inventory",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.gear),
            title: Text("Vendor Management",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.cart),
            title: Text("Orders",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(CupertinoIcons.person_2),
            title: Text("User Management",style: TextStyle(fontWeight: FontWeight.bold),),
          )
          , ListTile(
            leading: Icon(CupertinoIcons.lock_open)
            ,title: Text("Log out",style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
