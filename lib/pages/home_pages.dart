import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/appbar_actions_menu.dart';
import 'package:inventory_management_system/widget/drawer_menu_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Inventory Management System" ,style: TextStyle(color: Colors.black),),
          actions: AppbarActionMenu.actionFun(context)),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .50,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200,
                    crossAxisCount: 4,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                children: [
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.cube_box_fill,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total Shelfs",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.group_solid,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Suppliers",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.person_solid,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total Buyers",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.cart_badge_minus,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total Sells",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.cart_badge_plus,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Number of Purchase",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.money_dollar_circle,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total Purchase Amount",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.money_dollar_circle_fill,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total sell Amount",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "+10",
                                          style: TextStyle(
                                              fontSize: 80,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white12),
                                          child: const Icon(CupertinoIcons.bag_fill_badge_plus,
                                              size: 50),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Total Profit",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "LOW STOCK ITEM LIST",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                  ),
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
                          "Product Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Model Number",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total Quality",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Selling Price",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Buying Price",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const DrawerMenuWidget(),
    );
  }
}
