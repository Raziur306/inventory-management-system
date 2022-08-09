import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/model/salesModel.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';
import 'package:inventory_management_system/utils/routes.dart';

//variable
List<salesDataModel> salesList = [];
final _formKey = GlobalKey<FormState>();
var loadingIcon = true;


class salesManagementPage extends StatefulWidget {
  const salesManagementPage({Key? key}) : super(key: key);

  @override
  State<salesManagementPage> createState() => _salesManagementPage();
}

class _salesManagementPage extends State<salesManagementPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (salesList.isNotEmpty) {
      setState(() {
        loadingIcon = false;
      });
    }
    _getSalesList();
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
              "Sales Management",
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
                              "#Sales ID",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Product Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Unit Price",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Quanity",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Customer Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),

                        DataColumn(label: Text("")),
                      ],
                      rows: salesList
                          .map((data) => DataRow(cells: [
                        DataCell(Text("#${data.id}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ))),
                        DataCell(Text(
                          data.productname,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.quantity,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.unitprice,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.total,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.customer,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Row(
                          children: [
                            InkWell(
                                onTap: () => {
                                  _createNewOrUpdateSales(data)
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
      onPressed: () => {_createNewOrUpdateSales()},
    ),
  );

Future _getSalesList() async {
  var map = await Firestore.instance.collection("sales").get();
  salesList.clear();
  List<salesDataModel> apiList = [];
  for (var element in map) {
    apiList.add(salesDataModel(
        element.id,
        element["id"],
        element["productname"],
        element["quantity"].toString(),
        element["unitprice"],
        element["total"],
        element["customer"]));
  }


  setState(() {
    salesList.clear();
    salesList = apiList;
    loadingIcon = false;
  });
}

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
                _deleteSales(firebaseId, context);
                _popDialog(context);
              },
            ),
          ]));
}

//delete sales
void _deleteSales(String firebaseId, context) async {
  Firestore.instance.collection("sales").document(firebaseId).delete();
  setState(() {
    loadingIcon = true;
  });
  _getSalesList();
  _popDialog(context);
}

//new SalesDialog
void _createNewOrUpdateSales([salesDataModel? data]) {
  Map<String, dynamic> SalesMap = {};
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
                                  "Sales #ID: "
                                      "${data?.id}",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextFormField(
                              initialValue: data?.productname,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  errorText: errorText,
                                  hintText: "Product name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  SalesMap["productname"] = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: data?.quantity,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  errorText: errorText,
                                  hintText: "Quanity"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  SalesMap["quanity"] = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: data?.unitprice,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.money_rounded),
                                  errorText: errorText,
                                  hintText: "Unit Price"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  SalesMap["unitprice"] = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: data?.total,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.equalizer_rounded),
                                  errorText: errorText,
                                  hintText: "Total"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  SalesMap["total"] = value;
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: data?.customer,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  errorText: errorText,
                                  hintText: "Customer Name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  SalesMap["customer"] = value;
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
                                  {_saveToDB(data, SalesMap, context)}
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

void _saveToDB(salesDataModel? data, Map<String, dynamic> SalesMap,
    BuildContext context) async {
  if (data == null) {
    SalesMap["id"] = DateTime.now().millisecondsSinceEpoch.toString();
    await Firestore.instance.collection("sales").add(SalesMap);
    setState(() {
      loadingIcon = true;
    });
    _getSalesList();
  } else {
    await Firestore.instance
        .collection("sales")
        .document(data.firebaseId)
        .update(SalesMap);
    _getSalesList();
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
    Navigator.pushReplacementNamed(context, MyRoutes.salesRoute);
  }
}
}
