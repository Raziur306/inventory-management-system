import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/model/inventoryModel.dart';
import 'package:inventory_management_system/pages/vendor_management_page.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../model/vendorModel.dart';
import '../utils/routes.dart';

//global variable
final _formKey = GlobalKey<FormState>();
List<InventoryDataModel> inventoryList = [];
List<VendorDataModel> vendorList = [];
int item = 0;

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPage();
}

class _InventoryPage extends State<InventoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inventoryList.isNotEmpty) loadingIcon = false;
    _getInventoryList();
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
                  "Inventory",
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
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Model",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Name",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Description",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Vendors",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Country/Origin",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Items",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Status",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(label: Text("")),
                        ],
                        rows: inventoryList
                            .map((data) => DataRow(cells: [
                                  DataCell(Text("#${data.id}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ))),
                                  DataCell(Text(
                                    data.model,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.name,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.description,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.vendor,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.country,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.items,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(int.parse(data.items) == 0
                                      ? (Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                "Out of Stock..",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ))
                                      : (int.parse(data.items) < 10
                                          ? Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width: 10,
                                                    height: 10,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "Low Stock..",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ))
                                          : (Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "In Stock..",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ))))),
                                  DataCell(Row(
                                    children: [
                                      InkWell(
                                          onTap: () => {
                                                item = int.parse(data.items),
                                                _createNewOrUpdateInventory(
                                                    data)
                                              },
                                          child: const Icon(Icons.edit,
                                              color: Colors.green)),
                                      const SizedBox(width: 10),
                                      InkWell(
                                          onTap: () => {
                                                _showDeleteConfirmDialog(
                                                    data.firebaseId)
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
            Visibility(
                visible: loadingIcon, child: const CircularProgressIndicator())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {item = 0, _createNewOrUpdateInventory()},
        ),
      );

  void _createNewOrUpdateInventory([InventoryDataModel? data]) {
    Map<String, dynamic> inventoryMap = {};
    VendorDataModel? selectedVendor = data != null
        ? vendorList.firstWhere((element) => element.id == data.vendorId)
        : null;

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
                                initialValue: data?.model,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(CupertinoIcons.gear),
                                    errorText: errorText,
                                    hintText: "Model number"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    inventoryMap["model"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.name,
                                decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.insert_drive_file_outlined),
                                    errorText: errorText,
                                    hintText: "Product name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    inventoryMap["name"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.description,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.info),
                                    errorText: errorText,
                                    hintText: "Product description"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    inventoryMap["description"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.country,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.card_membership),
                                    errorText: errorText,
                                    hintText: "Country of origin"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    inventoryMap["country"] = value;
                                  }
                                  return null;
                                },
                              ),
                              Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text("Vendor: "),
                                    const SizedBox(width: 20),
                                    DropdownButton(
                                        hint: const Text("Select Vendor"),
                                        value: selectedVendor,
                                        items: vendorList
                                            .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                    "${item.name} (#ID ${item.id})")))
                                            .toList(),
                                        onChanged: (item) => {
                                              setState(() {
                                                selectedVendor =
                                                    item as VendorDataModel?;
                                              }),
                                              inventoryMap["vendorId"] =
                                                  (item as VendorDataModel).id,
                                              inventoryMap["vendor"] =
                                                  (item).name
                                            }),
                                  ]),
                              Row(
                                children: [
                                  const Text("Items: "),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      setState(() {
                                        if (item != 0) --item;
                                      })
                                    },
                                    child: const Icon(
                                        Icons.remove_circle_outlined),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    width: 60,
                                    child: TextFormField(
                                      key: Key(item.toString()),
                                      textAlign: TextAlign.center,
                                      initialValue: item.toString(),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          item = 0;
                                        } else {
                                          item = int.parse(value);
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      setState(() {
                                        ++item;
                                      })
                                    },
                                    child:
                                        const Icon(Icons.add_circle_outlined),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      _saveToDB(data, inventoryMap),
                                      _popDialog(context)
                                    }
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

  void _showDeleteConfirmDialog(String firebaseId) {
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
                      _deleteInventoryItem(firebaseId);
                      _popDialog(context);
                    },
                  ),
                ]));
  }

  //get vendor item
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
      loadingIcon = false;
      vendorList.clear();
      vendorList = apiList;
    });
  }

  //delete inventory item
  void _deleteInventoryItem(String firebaseId) async {
    Firestore.instance.collection("inventory").document(firebaseId).delete();
    setState(() {
      loadingIcon = true;
    });

    inventoryList.clear();
    _getVendorList();
    _getInventoryList();
  }

  void _saveToDB(
      InventoryDataModel? data, Map<String, dynamic> vendorMap) async {
    vendorMap["items"] = item;
    if (data == null) {
      vendorMap["id"] = DateTime.now().millisecondsSinceEpoch.toString();
      await Firestore.instance.collection("inventory").add(vendorMap);
      setState(() {
        loadingIcon = true;
      });
      _getVendorList();
      _getInventoryList();
    } else {
      await Firestore.instance
          .collection("inventory")
          .document(data.firebaseId)
          .update(vendorMap);

      setState(() {
        loadingIcon = true;
      });
      _getVendorList();
      _getInventoryList();
    }
  }

  //fetching inventory data
  Future _getInventoryList() async {
    var map = await Firestore.instance.collection("inventory").get();
    inventoryList.clear();
    List<InventoryDataModel> apiList = [];
    apiList.clear();
    for (var element in map) {
      apiList.add(InventoryDataModel(
          element["id"],
          element.id,
          element["model"],
          element["name"],
          element["description"],
          element["vendor"],
          element["country"],
          element["items"].toString(),
          element["vendorId"]));
    }
    setState(() {
      print("Calling");
      loadingIcon = false;
      inventoryList.clear();
      inventoryList = apiList;
    });
  }

  void _popDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.pushReplacementNamed(context, MyRoutes.inventoryRoute);
    }
  }
}
