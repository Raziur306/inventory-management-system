import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

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
                    child: DataTable(columns: const [
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
                    ], rows: []),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {},
        ),
      );
}
