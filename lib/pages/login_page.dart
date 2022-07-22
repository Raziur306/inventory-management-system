import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/data.dart';
import 'package:inventory_management_system/utils/firestore_keys.dart';
import 'package:inventory_management_system/utils/routes.dart';
import '../utils/platform.dart';
import 'package:firedart/firedart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final _firestore = Firestore(SavedData.projectId);
  String _userName = "";
  String _userPass = "";

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var map = await Firestore.instance.collection("users").get();
      if (map.isEmpty) {
        print("not found");
      } else {
        for (var element in map) {
          if (element[DataKey.userName] == _userName &&
              element[DataKey.password] == _userPass) {
            SavedData.name = element[DataKey.name];
            SavedData.admin = element[DataKey.name] == "true";
            SavedData.email = element[DataKey.email];
            SavedData.userId = element[DataKey.userId];
            SavedData.documentId = element.id;
            setState(() {
              _changeButton = true;
            });
            await Future.delayed(Duration(seconds: 1));
            await Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
            setState(() {
              _changeButton = false;
            });
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/login_image.png",
                  width: 500,
                ),
                // ignore_for_file: prefer_const_constructors
                SizedBox(
                  height: 20.0,
                ),
                Text("Welcome",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 26,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: Target.isPc()
                            ? 500
                            : MediaQuery.of(context).size.width,
                        child: TextFormField(
                          onChanged: (value) {
                            _userName = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Enter your username",
                              label: Text("Username:")),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: Target.isPc()
                            ? 500
                            : MediaQuery.of(context).size.width,
                        child: TextFormField(
                          onChanged: (value) {
                            _userPass = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            label: Text("Password"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32.0),
                        color: Colors.deepPurple,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () => moveToHome(context),
                          child: AnimatedContainer(
                            color: Colors.transparent,
                            duration: Duration(seconds: 1),
                            height: 50,
                            width: _changeButton ? 50 : 150,
                            alignment: Alignment.center,
                            child: _changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
