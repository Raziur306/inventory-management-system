import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/data.dart';
import 'package:inventory_management_system/utils/firestore_keys.dart';
import 'package:inventory_management_system/utils/routes.dart';

final _formKey = GlobalKey<FormState>();

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountEmail: Text(SavedData.email),
                  accountName: Text(
                    SavedData.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  currentAccountPicture: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/avatar.jpg")))),
          ListTile(
            leading: const Icon(CupertinoIcons.home),
            title: const Text(
              "Dashboard",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: MyRoutes.selectedIndex == 0,
            onTap: () {
              MyRoutes.selectedIndex = 0;
              Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.checkmark_shield),
            title: const Text(
              "Inventory",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: MyRoutes.selectedIndex == 1,
            onTap: () {
              MyRoutes.selectedIndex = 1;
              Navigator.pushReplacementNamed(context, MyRoutes.inventoryRoute);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.gear),
            title: const Text(
              "Vendor Management",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: MyRoutes.selectedIndex == 2,
            onTap: () {
              MyRoutes.selectedIndex = 2;
              Navigator.pushReplacementNamed(
                  context, MyRoutes.vendorManagementRoute);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.cart),
            title: const Text(
              "Orders",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: MyRoutes.selectedIndex == 3,
            onTap: () {
              MyRoutes.selectedIndex = 3;
              Navigator.pushReplacementNamed(context, MyRoutes.ordersRoute);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.person_2),
            title: const Text(
              "User Management",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: MyRoutes.selectedIndex == 4,
            onTap: () {
              showAuthDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.lock_open),
            title: const Text(
              "Log out",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
              MyRoutes.selectedIndex = 0;
            },
          )
        ],
      ),
    );
  }

  //user auth dialog

  void showAuthDialog(BuildContext context) async {
    String userPassInput = "";
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Verify Yourself'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) {
                    _isFormValid();
                    userPassInput = value;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Authentication Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context, "Cancel");
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () async {
                    if (userPassInput.isEmpty) {
                    } else {
                      var map = await Firestore.instance
                          .collection("users")
                          .document(SavedData.documentId)
                          .get();
                      print(map);

                      Navigator.pop(context, "Confirm");
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.userManagementRoute);
                      MyRoutes.selectedIndex = 4;
                    }
                  },
                  child: const Text(
                    'CONFIRM',
                    style: (TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ));
  }

  //form key validation
  bool _isFormValid() {
    return _formKey.currentState!.validate();
  }
}
