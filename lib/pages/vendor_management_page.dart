import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/model/vendorModel.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../utils/routes.dart';

//variable
List<VendorDataModel> vendorList = [];
final _formKey = GlobalKey<FormState>();
var loadingIcon = true;

class VendorManagementPage extends StatefulWidget {
  const VendorManagementPage({Key? key}) : super(key: key);

  @override
  State<VendorManagementPage> createState() => _VendorManagementPage();
}

class _VendorManagementPage extends State<VendorManagementPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (vendorList.isNotEmpty) {
      setState(() {
        loadingIcon = false;
      });
    }
    _getVendorList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const DrawerMenuWidget(),
        appBar: AppBar(
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
        body: Column(
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
                  "Vendor Management",
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
                              "Name",
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
                              "Phone",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "Company Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "Company Website",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "Country",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            DataColumn(label: Text("")),
                          ],
                          rows: vendorList
                              .map((data) => DataRow(cells: [
                                    DataCell(Text("#${data.id}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ))),
                                    DataCell(Text(
                                      data.name,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data.email,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data.phone,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data.companyName,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data.companyWebsite,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Text(
                                      data.country,
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                    DataCell(Row(
                                      children: [
                                        InkWell(
                                            onTap: () => {
                                                  _createNewOrUpdateVendor(data)
                                                },
                                            child: const Icon(Icons.edit,
                                                color: Colors.green)),
                                        const SizedBox(width: 10),
                                        InkWell(
                                            onTap: () => {
                                                  _showDeleteConfirmDialog(
                                                      data.firebaseId, context)
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
            Visibility(
              visible: loadingIcon,
              child: const CircularProgressIndicator(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {_createNewOrUpdateVendor()},
        ),
      );

  Future _getVendorList() async {
    var map = await Firestore.instance.collection("vendors").get();
    vendorList.clear();
    List<VendorDataModel> apiList = [];
    for (var element in map) {
      apiList.add(VendorDataModel(
          element.id,
          element["id"],
          element["name"],
          element["email"],
          element["phone"],
          element["company"],
          element["website"],
          element["country"]));
    }

    setState(() {
      vendorList.clear();
      vendorList = apiList;
      loadingIcon = false;
    });
  }

  //delete vendor dialog
  void _showDeleteConfirmDialog(String firebaseId, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text(
                  "Are you sure?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: const Text(
                  "Would you like to delete?",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      _popDialog(context);
                    },
                  ),
                  TextButton(
                    child: const Text("Confirm"),
                    onPressed: () {
                      _deleteVendor(firebaseId, context);
                      _popDialog(context);
                    },
                  ),
                ]));
  }

  //delete vendor
  void _deleteVendor(String firebaseId, context) async {
    Firestore.instance.collection("vendors").document(firebaseId).delete();
    setState(() {
      loadingIcon = true;
    });
    _getVendorList();
    _popDialog(context);
  }

  //new VendorDialog
  void _createNewOrUpdateVendor([VendorDataModel? data]) {
    Map<String, dynamic> vendorMap = {};
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  Text(data == null ? "Add New Vendor" : "Update Vendor Data"),
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
                                  visible: data != null,
                                  child: Text(
                                    "Vendor #ID: "
                                    "${data?.id}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextFormField(
                                initialValue: data?.name,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    errorText: errorText,
                                    hintText: "Vendor name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    vendorMap["name"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.email,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    errorText: errorText,
                                    hintText: "Email"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    vendorMap["email"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.phone,
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
                                    vendorMap["phone"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.companyName,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.card_membership),
                                    errorText: errorText,
                                    hintText: "Company name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    vendorMap["company"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.companyWebsite,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.web),
                                    errorText: errorText,
                                    hintText: "Company website"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    vendorMap["website"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.country,
                                decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.sports_basketball_outlined),
                                    hintText: "Country"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    vendorMap["country"] = value;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {_saveToDB(data, vendorMap, context)}
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.all(20)),
                                child: Text(
                                  data == null ? "Submit" : "Update",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          )),
                    ]),
                  ),
                ]);
              }),
            ));
  }

  void _saveToDB(VendorDataModel? data, Map<String, dynamic> vendorMap,
      BuildContext context) async {
    if (data == null) {
      vendorMap["id"] = DateTime.now().millisecondsSinceEpoch.toString();
      await Firestore.instance.collection("vendors").add(vendorMap);
      setState(() {
        loadingIcon = true;
      });
      _getVendorList();
    } else {
      await Firestore.instance
          .collection("vendors")
          .document(data.firebaseId)
          .update(vendorMap);
      _getVendorList();
      setState(() {
        loadingIcon = true;
      });
    }
    _popDialog(context);
  }

 void _popDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.pushReplacementNamed(context, MyRoutes.vendorManagementRoute);
    }
  }
}
