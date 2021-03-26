import 'package:autopayflutter/maps/screens/search.dart';
import 'package:autopayflutter/services/restapi.dart';
import 'package:autopayflutter/things/CarRegister.dart';
import 'package:autopayflutter/things/FridgeRegister.dart';
import 'package:autopayflutter/things/ThingsDashboard.dart';
import 'package:autopayflutter/things/WasherRegister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/BalanceCard.dart';
import 'models/color.dart';
import 'models/my_flutter_app_icons.dart';
import 'profile/Profile.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  String uid = "";
  String name = "";
  _getDetails() async {
    await Firebase.initializeApp();
    uid = FirebaseAuth.instance.currentUser.uid;
    // var snapShot =
    //     await FirebaseFirestore.instance.collection("user").doc(uid).get();
    // setState(() {
    //   name = snapShot.data()["name"].toString();
    // });
    return uid;
  }

  @override
  void initState() {
    super.initState();
  }

  _card(String title, double amount, String thing) {
    Color color = Colors.purple;
    switch (thing) {
      case "car":
        color = Colors.purple;
        break;
      case "washing machine":
        color = Colors.orange;
        break;
    }
    return UpcomingCard(
      title: title,
      value: amount,
      color: color,
    );
  }

  Widget _pending_transactions(title, amount, thing) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 200,
        width: double.maxFinite,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: title.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _card(title[index], amount[index], thing[index])
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
        SizedBox(width: 15),
        Text(
          "Hello,",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(' $name',
            style: GoogleFonts.muli(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: LightColor.navyBlue2)),
        Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
            child: Icon(
              Icons.local_parking,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.purple;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor, border: Border.all(color: primaryColor)),
              child: Padding(
                  padding: EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10.0, right: 0, left: 0),
                    child: _appBar(),
                  )),
            ),
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 350.0,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.0, right: 25.0, left: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 180.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 15.0)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purple.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(FontAwesomeIcons.car),
                                      color: Colors.purple,
                                      iconSize: 30.0,
                                      onPressed: () async {
                                        var user = FirebaseAuth.instance.currentUser.uid;
                                        var snapShot = await FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(user)
                                            .collection('thing')
                                            .where('thing', isEqualTo: 'car')
                                            .get();
                                        if(snapShot.size>0){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ThingsDashBoard('car')));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CarRegister()));
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Car',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon:
                                      Icon(MyFlutterApp.smart_refrigerator),
                                      color: Colors.deepPurple,
                                      iconSize: 30.0,
                                      onPressed: () async {
                                        var user = FirebaseAuth.instance.currentUser.uid;
                                        var snapShot = await FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(user)
                                            .collection('thing')
                                            .where('thing', isEqualTo: 'fridge')
                                            .get();
                                        if(snapShot.size>0){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ThingsDashBoard('fridge')));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FridgeRegister()));
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Refrigerator',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(MyFlutterApp.washer),
                                      color: Colors.blueAccent,
                                      iconSize: 30.0,
                                      onPressed: () async {
                                        var user = FirebaseAuth.instance.currentUser.uid;
                                        var snapShot = await FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(user)
                                            .collection('thing')
                                            .where('thing', isEqualTo: 'washer')
                                            .get();
                                        if(snapShot.size>0){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ThingsDashBoard('washer')));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WasherRegister()));
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Washer',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
              child: Text(
                'Pending Transactions',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            FutureBuilder(
              future: _getDetails(),
                builder: (context, snapShot){
                  if(snapShot.hasData){
                    return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("user").doc(uid).collection("pending").where("status", isEqualTo: "unpaid").snapshots(),
                        builder:(context, snapShot){
                          if (snapShot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapShot.hasData) {
                            List<String> titles = [];
                            List<double> amounts = [];
                            List<String> things = [];
                            List<Widget> usersList = [];
                            final docs = snapShot.data.docs;
                            print(docs);
                            for (var document in docs) {
                              print(document.data);
                              var data = document.data();
                              var title = data["to"];
                              var thing = data["thing"];
                              var amount = data["amount"].toDouble();
                              titles.add(title);
                              things.add(thing);
                              amounts.add(amount);
                            }
                            if(titles.isNotEmpty) {
                              return _pending_transactions(
                                  titles, amounts, things);
                            }else{
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      '🙁 No pending transactions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return Container(
                            child: Center(
                              child: Text(
                                '🙁 No pending transactions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey),
                              ),
                            ),
                          );
                        }
                    );
                  }
                  return Container(
                    child: Center(
                      child: Text(
                        '🙁 No pending transactions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 350.0 - 200);
    path.quadraticBezierTo(size.width / 2, 340, size.width, 350.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class UpcomingCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  UpcomingCard({this.title, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Container(
        width: 120.0,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 30.0),
              Text('$value',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Container(
                width: 60,
                child: RaisedButton(
                  child: Text("Pay"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    String uid = FirebaseAuth.instance.currentUser.uid;
                    var snapShot = await FirebaseFirestore.instance
                        .collection("user")
                        .doc(uid)
                        .collection("pending")
                        .where("to", isEqualTo: title)
                        .get();
                    var snapShot1 = snapShot.docs[0];
                    String thing = snapShot1.data()["thing"];
                    Map temp = await getBalance(thing);
                    int balance = temp["balance"];
                    int amount = snapShot1.data()["amount"];
                    String currency= snapShot1.data()["currency"];
                    if(balance > amount){
                      String sender = snapShot1.data()["address"];
                      String privatekey = snapShot1.data()["privatekey"];
                      String receiver = snapShot1.data()["receiver"];
                      if(currency=="eth"){
                        makeTransaction(sender, privatekey, receiver, amount,currency);
                      }
                      else{
                        makeTransaction(privatekey,privatekey,receiver,amount,currency);
                      }
                    }
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc(uid)
                        .collection("pending")
                        .doc(snapShot1.id)
                        .update({"status": "paid"}).then((value) {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}