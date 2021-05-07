import 'dart:ui';

import 'package:autopayflutter/DashBoard.dart';
import 'package:autopayflutter/services/restapi.dart';
import 'package:autopayflutter/things/transactiondesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_switch/flutter_switch.dart';

class ThingsDashBoard extends StatefulWidget {
  String thing;
  ThingsDashBoard(this.thing);

  @override
  _ThingsDashBoardState createState() => _ThingsDashBoardState(thing);
}

class _ThingsDashBoardState extends State<ThingsDashBoard> {
  String thing;
  _ThingsDashBoardState(this.thing);

  Color primaryColor = Colors.white;

  String uid = "";
  String docID = "";
  String balance = "0.0";
  var currency = "";
  String thingname = "";
  String thingstatus = "";
  bool isswitchon = true;

  _getBalance() async {
    uid = FirebaseAuth.instance.currentUser.uid;
    var snapShot1 = await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("thing")
        .where("thing", isEqualTo: thing)
        .get();
    setState(() {
      currency = snapShot1.docs[0].data()["currency"];
    });
    setState(() {
      if (thing == 'car') {
        thingname = "Car status";
        thingstatus = "Active";
      } else if (thing == 'ac') {
        thingname = "AC status";
        thingstatus = "Active";
      } else {
        thingname = "Detergent Status";
        thingstatus = "Low";
      }
    });

    var balanceJson = await getBalance(thing);
    setState(() {
      if(currency=="eth")
      balance = (double.parse(balanceJson["balance"].toString()) / 10000000000000)
          .toStringAsFixed(2);
      else
        balance = (double.parse(balanceJson["balance"].toString()) / 1000)
            .toStringAsFixed(2);
    });
    print(balance);

  }

  Future _getDetails() async {
    // await Firebase.initializeApp();
    uid = FirebaseAuth.instance.currentUser.uid;
    var snapShot =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    var snapShot1 = await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("thing")
        .where("thing", isEqualTo: thing)
        .get();
    docID = snapShot1.docs[0].id;
    return snapShot;
  }

  @override
  void initState() {
    _getBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      ClickPerMonth('Jan', 30, Colors.purple),
      ClickPerMonth('Feb', 42, Colors.blue),
      ClickPerMonth('Mar', 54, Colors.purple),
      ClickPerMonth('Apr', 20, Colors.blue),
      ClickPerMonth('May', 76, Colors.purple),
      ClickPerMonth('Jun', 35, Colors.blue),
    ];
    bool isChecked = true;

    var series = [
      new charts.Series(
          id: 'Clicks',
          domainFn: (ClickPerMonth clickData, _) => clickData.month,
          measureFn: (ClickPerMonth clickData, _) => clickData.clicks,
          colorFn: (ClickPerMonth clickData, _) => clickData.color,
          data: data)
    ];

    var chart = new charts.BarChart(series,
        animate: true, animationDuration: Duration(milliseconds: 1500));

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(height: 180.0, child: chart),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 450.0,
              decoration: BoxDecoration(color: Colors.purple),
            ),
          ),
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_none),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  child: Text('Dashboard',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 370.0,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 0.3),
                              blurRadius: 15.0)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        balance,
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " $currency",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    'Available Balance',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.show_chart),
                                onPressed: () {},
                                color: Colors.purple,
                                iconSize: 30.0,
                              )
                            ],
                          ),
                        ),
                        chartWidget
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0.0, 0.3),
                                    blurRadius: 15.0)
                              ]),
                          height: 100,
                          width: (MediaQuery.of(context).size.width / 2) - 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(thingname),
                              Text(
                                thingstatus,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 25),
                              ),
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0.0, 0.3),
                                    blurRadius: 15.0)
                              ]),
                          height: 100,
                          width: (MediaQuery.of(context).size.width / 2) - 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Payment Mode"),
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   isChecked = !isChecked;
                                  // });
                                },
                                child: Center(
                                  child: FlutterSwitch(
                                    value: isswitchon,
                                    showOnOff: true,
                                    onToggle: (value) {
                                      setState(() {
                                        isswitchon = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: FutureBuilder(
                    future: _getDetails(),
                    builder: (context, snapshot) {
                      print(uid);
                      if (snapshot.hasData) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .doc(uid)
                                .collection("thing")
                                .doc(docID)
                                .collection('transactions')
                                .limit(5)
                                .orderBy("timestamp", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                List<Widget> usersList = [];
                                final docs = snapshot.data.docs;
                                // print(docs);
                                for (var document in docs) {
                                  print(document.data);
                                  var data = document.data();
                                  var address = data['address'];
                                  var amount = data['amount'];
                                  var currency = data['currency'];
                                  var timestamp = data['timestamp'];
                                  var to = data['to'];
                                  var hash = data['hash'];
                                  var status = data['status'];
                                  if (true) {
                                    usersList.add(
                                      TransactionDesign(
                                          amount: amount.toStringAsFixed(2),
                                          status: status,
                                          timestamp: timestamp,
                                          currency: currency,
                                          to: to,
                                          hash: hash.toString(),
                                          address: address),
                                    );
                                  }
                                }
                                if (usersList.isEmpty) {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                        '🙁 No Records Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  );
                                }
                                return ListView(
                                  shrinkWrap: true,
                                  children: usersList,
                                );
                              }
                              return Container();
                            });
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ClickPerMonth {
  final String month;
  final int clicks;
  final charts.Color color;

  ClickPerMonth(this.month, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class RecentTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: [
            Material(
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.purple.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'JO',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Load Activity',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Sent Money',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Text(
          '- 240.0',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Divider(),
        ),
      ],
    );
  }
}
