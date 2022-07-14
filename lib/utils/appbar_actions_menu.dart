import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarActionMenu {
  static var action = [
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
  ];
}
