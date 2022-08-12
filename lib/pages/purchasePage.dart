import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_system/pages/vendor_management_page.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../model/inventoryModel.dart';
import '../model/purchaseModel.dart';
import '../model/vendorModel.dart';
import '../utils/routes.dart';

//global variable
final _formKey = GlobalKey<FormState>();
List<PurchaseModel> purchaseList = [];
List<VendorDataModel> vendorList = [];
int editabeQuantity = 0;

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePage();
}

class _PurchasePage extends State<PurchasePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (purchaseList.isNotEmpty) loadingIcon = false;
    _getPurchaseList();
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
                  "Purchase",
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
                            "Date",
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
                            "Country of Origin",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Items",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Unit Price",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(label: Text("")),
                        ],
                        rows: purchaseList
                            .map((data) => DataRow(cells: [
                                  DataCell(Text("#${data.id}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ))),
                                  DataCell(Text(
                                    data.date,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.model,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.productName,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.description,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.vendorName,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.country,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.quantity,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(data.unitPrice)),
                                  DataCell(Row(
                                    children: [
                                      InkWell(
                                          onTap: () => {
                                                editabeQuantity =
                                                    int.parse(data.quantity),
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
          onPressed: () => {editabeQuantity = 0, _createNewOrUpdateInventory()},
        ),
      );

  void _createNewOrUpdateInventory([PurchaseModel? data]) {
    Map<String, dynamic> inventoryMap = {};
    VendorDataModel? selectedVendor = data != null
        ? vendorList.firstWhere((element) => element.id == data.vendorId)
        : null;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  data == null ? "Add New Purchase" : "Update Purchase Data"),
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
                                initialValue: data?.productName,
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
                              TextFormField(
                                initialValue: data?.unitPrice,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.attach_money),
                                    errorText: errorText,
                                    hintText: "Unit Price"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    inventoryMap["unitPrice"] = value;
                                  }
                                  return null;
                                },
                              ),
                              Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text("Vendor: "),
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
                                  const Text("Quantity: "),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      setState(() {
                                        if (editabeQuantity != 0)
                                          --editabeQuantity;
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
                                    width: 50,
                                    child: TextFormField(
                                      onChanged: (value) =>
                                          {editabeQuantity = int.parse(value)},
                                      key: Key(editabeQuantity.toString()),
                                      textAlign: TextAlign.center,
                                      initialValue: editabeQuantity.toString(),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          editabeQuantity = 0;
                                        } else {
                                          editabeQuantity = int.parse(value);
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
                                        ++editabeQuantity;
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
    _getPurchaseList();
  }

  //delete inventory item
  void _deleteInventoryItem(String firebaseId) async {
    Firestore.instance.collection("purchase").document(firebaseId).delete();
    setState(() {
      loadingIcon = true;
    });

    purchaseList.clear();
    _getVendorList();
    _getPurchaseList();
  }

  void _saveToDB(PurchaseModel? data, Map<String, dynamic> purchaseItem) async {
    purchaseItem["date"] = getDate();
    purchaseItem["quantity"] = editabeQuantity;
    if (data == null) {
      purchaseItem["id"] = DateTime.now().millisecondsSinceEpoch.toString();
      await Firestore.instance.collection("purchase").add(purchaseItem);
      _saveInventory(purchaseItem, false);
      setState(() {
        loadingIcon = true;
      });
    } else {
      await Firestore.instance
          .collection("purchase")
          .document(data.firebaseId)
          .update(purchaseItem);
      _saveInventory(purchaseItem, true);
      setState(() {
        loadingIcon = true;
      });
    }
  }

  //fetching inventory data
  Future _getPurchaseList() async {
    var map = await Firestore.instance.collection("purchase").get();
    purchaseList.clear();
    List<PurchaseModel> apiList = [];
    apiList.clear();
    for (var element in map) {
      apiList.add(PurchaseModel(
          element.id,
          element["id"],
          element["model"],
          element["name"],
          element["quantity"].toString(),
          element["unitPrice"],
          element["vendor"],
          element["vendorId"],
          element["description"],
          element["country"],
          element["date"]));
    }
    setState(() {
      loadingIcon = false;
      purchaseList.clear();
      purchaseList = apiList;
    });
  }

  void _popDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.pushReplacementNamed(context, MyRoutes.inventoryRoute);
    }
  }

  //saveToInventory
  void _saveInventory(Map<String, dynamic> purchaseItem, bool bool) async {
    _getVendorList();
    if (bool) {
      var map = await Firestore.instance.collection("inventory").get();
      for (var element in map) {
        if (element["model"].toString() == purchaseItem["model"].toString()) {
          await Firestore.instance
              .collection("inventory")
              .document(element.id)
              .update(purchaseItem);
        }
      }
    } else {
      await Firestore.instance.collection("inventory").add(purchaseItem);
    }
  }
  //getDate
  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
