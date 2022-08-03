import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class UserTilesClass {
  static Container userTiles(BuildContext context, String id, String name,
      String email, bool isAdmin) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Text(
            id,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            email,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            "******",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            "******",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
         Text(isAdmin?"Admin":"Not an Admin"),
          const Spacer(),
          const Text(
            "Edit",
            style: TextStyle(
                color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
