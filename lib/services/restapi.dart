import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Map> createWallet(currency) async {
  var uri = Uri.parse("https://"+currency+"api.herokuapp.com/createaccount");
  var response = await http
      .get(uri);
  Map data = jsonDecode(response.body);
  return data;
}

Future<Map> getBalance() async {
  var uri = Uri.parse("https://diemapi.herokuapp.com/getbalance/5c5947348376d30888af6b013903a8ff3d8501a7afbb0b96089f25f9b6dccc88");
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