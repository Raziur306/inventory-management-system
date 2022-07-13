import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/routes.dart';
import '../utils/platform.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _changeButton = false;
  final _fromKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_fromKey.currentState!.validate()) {
      setState(() {
        _changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await  Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      setState(() {
        _changeButton = false;
      });
      // _fromKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/login_image.png", width: 500,),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: Target.isPc() ? 500 : MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
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
                        width: Target.isPc() ? 500 : MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
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
