import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/routes.dart';

class AppbarActionMenu {
  static actionFun(BuildContext context) {
    return [
      Container(
        margin: const EdgeInsets.only(left: 10.0, right: 40.0),
        child: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            MyRoutes.selectedIndex=-1;
            Navigator.pushReplacementNamed(context, MyRoutes.productsRoute);
          },
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
          onPressed: () {
            MyRoutes.selectedIndex=-1;
            Navigator.pushReplacementNamed(context, MyRoutes.customerRoutes);
          },
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
          onPressed: () {
            MyRoutes.selectedIndex=-1;
            Navigator.pushReplacementNamed(context, MyRoutes.vendorManagementRoute);
          },
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

}
