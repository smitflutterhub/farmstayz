import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDatabase {
  final _firestore = FirebaseFirestore.instance;

  void set(BuildContext context, String username, String email, String mobileno,
      String password) {
    _firestore.collection("User").add({
      "username" : username,
      "email": email,
      "mobileno": mobileno,
      "password": password,
    }).then((value) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("data inserted")));
    });
  }

  void setad(BuildContext context, String username, String email, String mobileno,
      String password) {
    _firestore.collection("Admin").add({
      "username" : username,
      "email": email,
      "mobileno": mobileno,
      "password": password,
    }).then((value) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("data inserted")));
    });
  }
}
