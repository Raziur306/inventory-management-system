import 'package:firedart/firestore/firestore.dart';
import '../utils/firestore_keys.dart';

class UserDataModel {
  String name;
  String password;
  String adminPass;
  bool isAdmin;
  String userId;
  String email;
  String phone;
  String userName;
  String firebaseId;

  UserDataModel(this.name, this.password, this.adminPass, this.isAdmin,
      this.userId, this.email, this.phone, this.userName,this.firebaseId);
}

