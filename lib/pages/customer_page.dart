import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/model/customerModel.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

import '../utils/routes.dart';

//variable
List<customerDataModel> customerList = [];
final _formKey = GlobalKey<FormState>();
var loadingIcon = true;

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);
  @override
  State<CustomerPage> createState()=>_CustomerPage();


}

class _CustomerPage extends State<CustomerPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (customerList.isNotEmpty) {
      setState(() {
        loadingIcon = false;
      });
    }
    _getCustomerList();
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
              "Customer Management",
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
                              "Customer #ID",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Customer Name",
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
                              "Email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),


                        DataColumn(label: Text("")),
                      ],
                      rows: customerList
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
                          data.company,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.email,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Text(
                          data.phonenumber,
                          style: const TextStyle(fontSize: 15),
                        )),
                        DataCell(Row(
                          children: [
                            InkWell(
                                onTap: () => {
                                  _createNewOrUpdateCustomer(data)
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
      onPressed: () => {_createNewOrUpdateCustomer()},
    ),
  );

Future _getCustomerList() async {
  var map = await Firestore.instance.collection("customer").get();
  customerList.clear();
  List<customerDataModel> apiList = [];
  for (var element in map) {
    apiList.add(customerDataModel(
        element["id"],
        element.id,
        element["name"],
        element["company"],
        element["email"],
        element["phonenumber"]));
  }

  setState(() {
    customerList.clear();
    customerList = apiList;
    loadingIcon = false;
  });
}

//delete customer dialog
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
                  _deleteCustomer(firebaseId, context);
                  _popDialog(context);
                },
              ),
            ]));
  }

  //delete customer
  void _deleteCustomer(String firebaseId, context) async {
    Firestore.instance.collection("customer").document(firebaseId).delete();
    setState(() {
      loadingIcon = true;
    });
    _getCustomerList();
    _popDialog(context);
  }

  //new customer page
  void _createNewOrUpdateCustomer([customerDataModel? data]) {
    Map<String, dynamic> customerMap = {};
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
          Text(data == null ? "Add New Customer" : "Update Customer Data"),
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
                                    "Customer #ID: ${data?.id}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextFormField(
                                initialValue: data?.name,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    errorText: errorText,
                                    hintText: "Customer name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    customerMap["name"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.company,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.business),
                                    errorText: errorText,
                                    hintText: "Company"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    customerMap["company"] = value;
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
                                    customerMap["email"] = value;
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                initialValue: data?.phonenumber,
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
                                    customerMap["phonenumber"] = value;
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
                                    {_saveToDB(data, customerMap, context)}
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
  void _saveToDB(customerDataModel? data, Map<String, dynamic> customerMap,
      BuildContext context) async {
    if (data == null) {
      customerMap["id"] = DateTime.now().millisecondsSinceEpoch.toString();
      await Firestore.instance.collection("customer").add(customerMap);
      setState(() {
        loadingIcon = true;
      });
      _getCustomerList();
    } else {
      await Firestore.instance
          .collection("customer")
          .document(data.firebaseId)
          .update(customerMap);
      _getCustomerList();
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
      Navigator.pushReplacementNamed(context, MyRoutes.customerRoutes);
    }
  }
}

