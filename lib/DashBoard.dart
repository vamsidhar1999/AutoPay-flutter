import 'package:autopayflutter/car/transactionsboard.dart';
import 'package:autopayflutter/maps/screens/search.dart';
import 'package:autopayflutter/services/restapi.dart';
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
  List<String> title = [];
  List<double> amount = [];
  List<String> thing = [];
  String name = "";
  _getDetails() async {
    // await Firebase.initializeApp();
    final uid = FirebaseAuth.instance.currentUser.uid;
    var snapShot =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    setState(() {
      name = snapShot.data()["name"].toString();
    });
    return snapShot;
  }

  @override
  void initState() {
    super.initState();
  }

  _card(String title, double amount, String thing) {
    Color color = Colors.white;
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

  dynamic listView = Container();
  _set() {
    setState(() {
      listView = _pending_transactions(title, amount, thing);
    });
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
                    height: 450.0,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                ),
                Center(child: BalanceCard()),
                Padding(
                  padding: EdgeInsets.only(top: 180.0, right: 25.0, left: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 300.0,
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
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Board()));
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
                                    color: Colors.blue.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(FontAwesomeIcons.lightbulb),
                                      color: Colors.blue,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Electricity',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.orange.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.qr_code_scanner),
                                      color: Colors.orange,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Pay',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.pink.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.tv),
                                      color: Colors.pink,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('OTT',
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
                                      onPressed: () {},
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
                                      onPressed: () {},
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
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
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
                    stream: FirebaseFirestore.instance.collection("user").doc("zk4jxpIE6VFrtjPVB023").collection("pending").where("status", isEqualTo: "unpaid").snapshots(),
                        builder:(context, snapShot){
                          if (snapShot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapShot.hasData) {
                            List<Widget> usersList = [];
                            final docs = snapShot.data.docs;
                            print(docs);
                            for (var document in docs) {
                              print(document.data);
                              var data=document.data();
                              var title = data["to"];
                              var thing = data["thing"];
                              var amount = data["amount"];
                              Color color = Colors.white;
                              if(thing == "car")
                                color = Colors.purple;
                              else
                                color = Colors.orange;
                              usersList.add(UpcomingCard(title: title, value: amount, color: color,));
                            }
                            if (usersList.isEmpty) {
                              return Container();
                            }
                            return ListView(
                              children: usersList,
                            );
                          }
                          return Container();
                        }
                    );
                  }
                  return Container();
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

    path.lineTo(0.0, 450.0 - 200);
    path.quadraticBezierTo(size.width / 2, 340, size.width, 450.0 - 200);
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
                    var snapShot = await FirebaseFirestore.instance
                        .collection("user")
                        .doc("zk4jxpIE6VFrtjPVB023")
                        .collection("pending")
                        .where("to", isEqualTo: title)
                        .get();
                    var snapShot1 = snapShot.docs[0];
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc("zk4jxpIE6VFrtjPVB023")
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
