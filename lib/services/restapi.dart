import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<Map> createWallet(currency) async {
  var uri = Uri.parse("https://"+currency+"api.herokuapp.com/createaccount");
  var response = await http
      .get(uri);
  Map data = jsonDecode(response.body);
  return data;
}

Future<Map> getBalance(String thing) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  var snapShot = await FirebaseFirestore.instance.collection("user").doc(uid)
      .collection("thing").where("thing", isEqualTo: thing).get();
  String currency = snapShot.docs[0].data()["currency"];
  String key = "";
  var uri;
  if(currency=="eth"){
    key = snapShot.docs[0].data()["address"];
    uri = Uri.parse("https://ethapi.herokuapp.com/getbalance/$key");
  }else{
    key = snapShot.docs[0].data()["publickey"];
    uri = Uri.parse("https://diemapi.herokuapp.com/getbalance/$key");
  }
  var response = await http
      .get(uri);
  Map data = jsonDecode(response.body);
  print(data);
  return data;
}

Future<Map> makeTransaction() async {
  var uri = Uri.parse("https://ethapi.herokuapp.com/maketransaction");
  var body = jsonEncode({
    "sender":"0x1adad368f62d64bb4a6f7af8327ba03dfd7d319a",
    "privatekey": "556ac69c822e339bc6443d5b58cfe45aadfe1b197293a16c30be59134895b879",
    "receiver": "0x62697b036fb68B61e15746eCf8950A823a1849F4",
    "amount": 500
  });
  var response = await http
      .post(uri, body: body, headers: {"Content-Type": "application/json"});
  Map data = jsonDecode(response.body);
  print(data);
  return data;
}