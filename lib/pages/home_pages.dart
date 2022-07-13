import 'package:flutter/material.dart';
import 'package:inventory_management_system/widget/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Inventory Management System" ,style: TextStyle(color: Colors.black),),
        actions: [
          Container(
             margin: const EdgeInsets.only(left: 10.0, right: 40.0),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: const Text(
                "Products",
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
             margin: const EdgeInsets.only(left: 0.0, right: 40.0),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: const Text(
                "Customer",
                style: TextStyle(
                    //   color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, right: 50.0),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: const Text(
                "Vendor",
                style: TextStyle(
                    //  color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: const Center(
          child: Text(
            "From Home Page",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          )),
      drawer: const MenuWidget(),
    );
  }
}
