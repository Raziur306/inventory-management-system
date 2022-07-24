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
        padding: const EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
                    borderRadius: BorderRadius.circular(20)
                ),
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white12),
                                    child: const Icon(CupertinoIcons.news,
                                        size: 50),
                                  )
                                ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Total Shelfs",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
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
      drawer: const DrawerMenuWidget(),
    );
  }
}
