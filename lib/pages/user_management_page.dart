import 'dart:async';
import 'dart:ffi';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
late var isAdmin;
List<UserDataModel> userList = <UserDataModel>[];
final _formKey = GlobalKey<FormState>();

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
            userEditDialog(context, "", -1);
          },
        ),
      );

  //fetching data
  Future _getUserList() async {
    var map = await Firestore.instance.collection("users").get();
    userList.clear();
    List<UserDataModel> apiList = [];
    for (var element in map) {
      apiList.add(UserDataModel(
          element[DataKey.name],
          element[DataKey.password],
          element[DataKey.adminPass] ?? "",
          element[DataKey.admin],
          element[DataKey.userId],
          element[DataKey.email],
          element[DataKey.phone],
          element[DataKey.userName],
          element.id));
    }
    setState(() {
      userList.clear();
      userList = apiList;
    });
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
                                        userEditDialog(context,
                                            userList[index].firebaseId, index)
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

  //user edit dialog
  userEditDialog(BuildContext context, id, int index) {
    //isAdmin
    isAdmin = index != -1 ? userList[index].isAdmin : false;
    //userName Exist
    String errorMessage = "Invalid Username";
    bool errorMessageVisibility = false;
    Map<String, dynamic> userMap = {};

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(id.isEmpty ? "Add New User" : "Update User Data"),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Wrap(alignment: WrapAlignment.start, children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Visibility(
                                  visible: index != -1,
                                  child: Text("User #ID: "
                                      "${index != -1 ? userList[index].userId : null}")),
                              TextFormField(
                                initialValue: index != -1
                                    ? userList[index].userName
                                    : null,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    errorText: errorText,
                                    hintText: "User name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.userName] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue:
                                    index != -1 ? userList[index].name : null,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.perm_identity),
                                    errorText: errorText,
                                    hintText: "Full name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.name] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue:
                                    index != -1 ? userList[index].phone : null,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    errorText: errorText,
                                    hintText: "Phone number"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.phone] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue:
                                    index != -1 ? userList[index].email : null,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    errorText: errorText,
                                    hintText: "Email"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.email] = value ?? "";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: index != -1
                                    ? userList[index].password
                                    : null,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    errorText: errorText,
                                    hintText: "Password"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.password] = value ?? "";
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  const Text("Admin Status: "),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FlutterSwitch(
                                    width: 60,
                                    height: 30,
                                    value: isAdmin,
                                    borderRadius: 30.0,
                                    onToggle: (val) {
                                      setState(() {
                                        isAdmin = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: isAdmin,
                                child: TextFormField(
                                  initialValue: index != -1
                                      ? userList[index].adminPass
                                      : null,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      errorText: errorText,
                                      hintText: "Admin Password"),
                                  validator: (value) {
                                    if (value!.isEmpty && isAdmin == true) {
                                      return "Can't be empty";
                                    } else {
                                      userMap[DataKey.adminPass] = value ?? "";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: index != -1,
                                    child: ElevatedButton(
                                      onPressed: () => {
                                        deleteUser(userList[index].firebaseId)
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                          shape: const StadiumBorder(),
                                          padding: const EdgeInsets.all(20)),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () => {
                                      if (_formKey.currentState!.validate())
                                        {saveOrUpdate(index, userMap, context)}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.all(20)),
                                    child: Text(
                                      index == -1 ? "Submit" : "Update",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      Visibility(
                        visible: errorMessageVisibility,
                        child: const Text(
                          "Invalid User/Password",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ),
                ]);
              }),
            ));
  }

  void saveOrUpdate(int existing, Map<String, dynamic> userMap, context) async {
    if (existing == -1) {
      userMap["user_id"] = DateTime.now().millisecondsSinceEpoch.toString();
      userMap[DataKey.admin] = isAdmin;
      await Firestore.instance.collection("users").add(userMap);
      _getUserList();
      Navigator.pop(context);
    } else {
      userMap[DataKey.admin] = isAdmin;
      await Firestore.instance
          .collection("users")
          .document(userList[existing].firebaseId)
          .update(userMap);
      _getUserList();
      Navigator.pop(context);
    }
  }

  void deleteUser(String firebaseId) async {
    Firestore.instance.collection("users").document(firebaseId).delete();
    _getUserList();
    Navigator.pop(context);
  }
}
