import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  _getNotificationToken(){
    return FirebaseMessaging().getToken();
  }

  _register(){
    final uid = FirebaseAuth.instance.currentUser.uid;
    Map<Object, Object> data = <Object, Object>{

    };
    FirebaseFirestore.instance.collection("user").doc(uid).set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
