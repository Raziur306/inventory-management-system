import 'dart:async';
import 'dart:ffi';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:inventory_management_system/model/userModel.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../utils/firestore_keys.dart';
import '../utils/routes.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _ManagementState();
}

//variables
 var isAdmin=false;
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
          backgroundColor:  Colors.greenAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.purple, Colors.blue],
              ),
            ),
          ),
          actions: AppbarActionMenu.actionFun(context),
        ),
        body: getBody(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            userEditDialog(context, null);
          },
        ),
      );

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
   return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.purple, Colors.blue],
              ),
            ),
            padding: const EdgeInsets.only(top: 5, bottom: 17),
            child: const Text(
              "User Management",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text(
                                "#ID",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          DataColumn(
                              label: Text(
                                "Username",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          DataColumn(
                              label: Text(
                                "Full Name",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          DataColumn(
                              label: Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          DataColumn(
                              label: Text(
                                "Admin Permission",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          DataColumn(
                              label: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                          ),
                        ],
                        rows: userList.map((data) => DataRow(cells: [
                          DataCell(Text("#${data.userId}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ))),
                          DataCell(Text(
                            data.userName,
                            style: const TextStyle(fontSize: 15),
                          )),
                          DataCell(Text(
                            data.name,
                            style: const TextStyle(fontSize: 15),
                          )),
                          DataCell(Text(
                            data.email,
                            style: const TextStyle(fontSize: 15),
                          )),
                          DataCell(Text(
                            data.isAdmin.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                          ),
                          DataCell(Row(
                            children: [
                              InkWell(
                                  onTap: () => {
                                    userEditDialog(context,data)
                                  },
                                  child: const Icon(Icons.edit,
                                      color: Colors.green)),
                              const SizedBox(width: 10),
                              InkWell(
                                  onTap: () => {
                                    deleteUser(data.firebaseId)
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ))

                        ]))
                            .toList()),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  //user edit dialog
  userEditDialog(BuildContext context,[ UserDataModel? data]) {
    isAdmin = data?.isAdmin??false;
    bool errorMessageVisibility = false;
    Map<String, dynamic> userMap = {};
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(data==null? "Add New User" : "Update User Data"),
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
                                  visible: data!=null,
                                  child: Text(
                                    "User #ID: ${data?.userId}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextFormField(
                                initialValue: data?.userName,
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
                                initialValue:data?.name,
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
                                   data?.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                   data?.email,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    errorText: errorText,
                                    hintText: "Email"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.email] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.password,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    errorText: errorText,
                                    hintText: "Password"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    userMap[DataKey.password] = value;
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
                                  initialValue: data?.adminPass,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      errorText: errorText,
                                      hintText: "Admin Password"),
                                  validator: (value) {
                                    if (value!.isEmpty && isAdmin == true) {
                                      return "Can't be empty";
                                    } else {
                                      userMap[DataKey.adminPass] = value;
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
                                    visible: data!=null,
                                    child: ElevatedButton(
                                      onPressed: () => {
                                        deleteUser(data!.firebaseId)
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
                                        {saveOrUpdate(data, userMap, context)}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.all(20)),
                                    child: Text(
                                     data==null ? "Submit" : "Update",
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

  void saveOrUpdate(UserDataModel? data, Map<String, dynamic> userMap, context) async {
    if (data==null) {
      userMap[DataKey.userId] = DateTime.now().millisecondsSinceEpoch.toString();
      userMap[DataKey.admin] = isAdmin;
      await Firestore.instance.collection("users").add(userMap);
      _getUserList();
      _popDialog(context);
    } else {
      userMap[DataKey.admin] = isAdmin;
      await Firestore.instance
          .collection("users")
          .document(data.firebaseId)
          .update(userMap);
      _getUserList();
      _popDialog(context);
    }
  }

  void deleteUser(String firebaseId) async {
    Firestore.instance.collection("users").document(firebaseId).delete();
    _getUserList();
    _popDialog(context);
  }


  void _popDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.pushReplacementNamed(context, MyRoutes.userManagementRoute);
    }
  }

}



