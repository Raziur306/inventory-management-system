import 'dart:async';
import 'dart:ffi';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/generated/google/protobuf/struct.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/model/userModel.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../utils/firestore_keys.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _ManagementState();
}

//variables
var isAdmin = true;
List<UserDataModel> userList = <UserDataModel>[];

class _ManagementState extends State<UserManagementPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const DrawerMenuWidget(),
        appBar: AppBar(
          title: const Text("User Management"),
          actions: AppbarActionMenu.actionFun(context),
        ),
        body: getBody(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            userEditDialog(context,"",-1);
          },
        ),
      );
}

getBody(BuildContext context) {
  return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "#ID",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "User Name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Full Name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Admin Permission",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
              child: FutureBuilder(
                  future: _getUserList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (userList.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userList[index].userId,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userList[index].userName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userList[index].name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userList[index].email,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(userList[index].isAdmin.toString()),
                                  InkWell(
                                    onTap: () => {
                                      userEditDialog(
                                          context,
                                          userList[index].firebaseId,
                                          index)
                                    },
                                    child: const Icon(CupertinoIcons.pencil,
                                        size: 30),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
        ],
      ));
}

//fetching data
Future _getUserList() async {
  var map = await Firestore.instance.collection("users").get();
  userList.clear();
  for (var element in map) {
    userList.add(UserDataModel(
        element[DataKey.name],
        element[DataKey.password],
        element[DataKey.adminPass],
        element[DataKey.admin] == "true",
        element[DataKey.userId],
        element[DataKey.email],
        element[DataKey.phone],
        element[DataKey.userName],
        element.id));
  }
}

//user edit dialog
userEditDialog(BuildContext context, id, int index) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(id.isEmpty ? "Add New User" : "Update User Data"),
            content: Wrap(children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: Column(children: [
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        initialValue: userList[index].userName,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            errorText: errorText,
                            hintText: "User name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: userList[index].name,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            errorText: errorText,
                            hintText: "Full name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: userList[index].phone,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            errorText: errorText,
                            hintText: "Phone number"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: userList[index].password,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            errorText: errorText,
                            hintText: "Password"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
                  Visibility(
                    visible: loginFailed,
                    child: const Text(
                      "Invalid User/Password",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ]),
          ));
}
