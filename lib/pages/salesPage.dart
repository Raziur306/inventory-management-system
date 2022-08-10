import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_system/model/customerModel.dart';
import 'package:inventory_management_system/model/inventoryModel.dart';
import 'package:inventory_management_system/model/slaesDataModel.dart';
import 'package:inventory_management_system/pages/vendor_management_page.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';
import '../utils/routes.dart';

//global variable
final _formKey = GlobalKey<FormState>();
List<customerDataModel> customerList = [];
List<InventoryDataModel> inventoryList = [];
List<SalesDataModel> salesList = [];
int editabeQuantity = 0;
int totalAmountState = 0;
int profitPerUnit = 0;
int perUnitPrice = 0;
int existingQuantity = 0;
String inventoryFireId="";

class SalesManagementPage extends StatefulWidget {
  const SalesManagementPage({Key? key}) : super(key: key);

  @override
  State<SalesManagementPage> createState() => _SalesManagementPage();
}

class _SalesManagementPage extends State<SalesManagementPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (customerList.isNotEmpty) loadingIcon = false;
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
                  "Sales",
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
                            "#Seles ID",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Date",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Product #ID",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Product Name",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Customer #ID",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Customer Name",
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
                          DataColumn(
                              label: Text(
                            "Profit Per Unit",
                            style: TextStyle(fontSize: 18),
                          )),
                          DataColumn(
                              label: Text(
                            "Total Price",
                            style: TextStyle(fontSize: 18),
                          )),
                        ],
                        rows: salesList
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
                                  DataCell(Text("#${data.productId}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ))),
                                  DataCell(Text(
                                    data.productName,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text("#${data.customerID}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                      ))),
                                  DataCell(Text(
                                    data.customerName,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.quantitiy,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.unitPrice,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.profit,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(
                                    data.totalPrice,
                                    style: const TextStyle(fontSize: 15),
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
          onPressed: () => {_createNewOrUpdateInventory()},
        ),
      );

  void _createNewOrUpdateInventory() {
    Map<String, dynamic> salesMap = {};
    InventoryDataModel? selectedProductItem;
    customerDataModel? selectedCustomerItem;
    editabeQuantity = 0;
    totalAmountState = 0;
    profitPerUnit = 0;
    perUnitPrice = 0;
     existingQuantity = 0;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add New Sales"),
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
                              Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text("Customer: "),
                                    const SizedBox(width: 20),
                                    DropdownButton(
                                        hint: const Text("Select Customer"),
                                        value: selectedCustomerItem,
                                        items: customerList
                                            .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                    "${item.name} (#ID ${item.id})")))
                                            .toList(),
                                        onChanged: (item) => {
                                              setState(() {
                                                selectedCustomerItem =
                                                    item as customerDataModel?;
                                              }),
                                              salesMap["Customer_iD"] =
                                                  (item as customerDataModel)
                                                      .id,
                                              salesMap["customer_name"] =
                                                  (item).name
                                            }),
                                  ]),
                              Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text("Products: "),
                                    const SizedBox(width: 20),
                                    DropdownButton(
                                        hint: const Text("Select Product"),
                                        value: selectedProductItem,
                                        items: inventoryList
                                            .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                    "${item.name} (#ID ${item.id})")))
                                            .toList(),
                                        onChanged: (item) => {
                                              setState(() {
                                                editabeQuantity=0;
                                                selectedProductItem =
                                                    item as InventoryDataModel;
                                                perUnitPrice =
                                                    int.parse(item.unitPrice);
                                                existingQuantity = int.parse(item.items);
                                              }),
                                              salesMap["product_id"] =
                                                  (item as InventoryDataModel)
                                                      .id,
                                              salesMap["unit_price"] =
                                                  item.unitPrice,
                                              salesMap["product_name"] =
                                                  (item).name,
                                          inventoryFireId=item.firebaseId,
                                            }),
                                  ]),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.attach_money),
                                    errorText: errorText,
                                    hintText: "Per unit profit"),
                                onChanged: (value) => {
                                  setState(() {
                                    profitPerUnit = int.parse(value);
                                    totalAmountState =
                                        ((editabeQuantity * perUnitPrice)) +
                                            ((profitPerUnit * editabeQuantity));
                                  })
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty";
                                  } else {
                                    profitPerUnit = int.parse(value);
                                    salesMap["profit"] = value;
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  const Text("Quantity: "),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      setState(() {
                                        if (editabeQuantity != 0) {
                                          --editabeQuantity;
                                        }
                                        totalAmountState = ((editabeQuantity *
                                                perUnitPrice)) +
                                            ((profitPerUnit * editabeQuantity));
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
                                      onChanged: (value) => {
                                        editabeQuantity = int.parse(value),
                                        setState(() {
                                          totalAmountState = ((editabeQuantity *
                                                  perUnitPrice)) +
                                              ((profitPerUnit *
                                                  editabeQuantity));
                                        })
                                      },
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
                                        if (editabeQuantity < existingQuantity) {
                                          ++editabeQuantity;
                                        }
                                        totalAmountState = ((editabeQuantity *
                                                perUnitPrice)) +
                                            ((profitPerUnit * editabeQuantity));
                                      })
                                    },
                                    child:
                                        const Icon(Icons.add_circle_outlined),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "Total Amount: " +
                                        (totalAmountState).toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {_saveToDB(salesMap), _popDialog(context)}
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.all(20)),
                                child: const Text(
                                  "Submit",
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

  //get vendor item
  Future _getInventoryList() async {
    _getSalesList();
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
          element["quantity"].toString(),
          element["vendorId"],
          element["unitPrice"].toString()));
    }
    setState(() {
      loadingIcon = false;
      inventoryList.clear();
      inventoryList = apiList;
    });
  }

  void _saveToDB(Map<String, dynamic> salesMap) async {
    salesMap["id"] = DateTime.now().millisecondsSinceEpoch.toString();
    salesMap["profit"] = profitPerUnit;
    salesMap["total_price"] = totalAmountState;
    salesMap["date"] = getDate();
    salesMap["quantity"] = editabeQuantity;
    await Firestore.instance.collection("sales").add(salesMap);
    _updateInventory();
    setState(() {
      loadingIcon = true;
    });
  }

  Future _getCustomerList() async {
    var map = await Firestore.instance.collection("customer").get();
    _getInventoryList();
    List<customerDataModel> apiList = [];
    for (var element in map) {
      apiList.add(customerDataModel(
          element["id"],
          element.id,
          element["name"],
          element["company"],
          element["email"],
          element["phonenumber"],
          element["totaltransaction"]));
    }
    setState(() {
      customerList.clear();
      customerList = apiList;
      loadingIcon = false;
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
void _updateInventory() async {
    Map<String,dynamic> myMap = {};
    myMap["quantity"]=  existingQuantity- editabeQuantity;
    await Firestore.instance.collection("inventory").document(inventoryFireId).update(myMap);
    _getSalesList();
}

  void _getSalesList() async {
    var map = await Firestore.instance.collection("sales").get();
    // _getInventoryList();
    List<SalesDataModel> apiList = [];
    for (var element in map) {
      apiList.add(SalesDataModel(
          element["id"],
          element.id,
          element["Customer_iD"],
          element["customer_name"],
          element["date"],
          element["product_id"],
          element["product_name"],
          element["quantity"].toString(),
          element["unit_price"].toString(),
          element["total_price"].toString(),
          element["profit"].toString()));
    }
    setState(() {
      salesList.clear();
      salesList = apiList;
      loadingIcon = false;
    });
  }

//getDate
  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
