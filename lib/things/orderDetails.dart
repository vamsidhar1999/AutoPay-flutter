import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  final String url;
  const OrderDetails({
    Key key,
    this.url
});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Color primaryColor = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height:20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("Arriving Date", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight:FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 7),
                      child: Text("09 May, 2021", style: TextStyle(fontSize: 25,color: Colors.green)),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.65,
                        padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(0.0, 0.3),
                                  blurRadius: 15.0)
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 2,20,0),
                              child: Text("Your Order Details", style: TextStyle(color: Colors.white, fontSize: 17),),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 2,20,0),
                              child: Text("Your product details(order 430-120-102)", style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5,20,20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.purple.shade400,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0.0, 0.3),
                                          blurRadius: 15.0)
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 100,
                                          width: 100,
                                          child: Image(image: AssetImage("images/Ariel.jpg"))),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Ariel Top Load , 1 Kg", style: TextStyle(color: Colors.white,fontSize: 18),),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("250 Diem", style: TextStyle(color: Colors.white,fontSize: 18),),
                                              ],
                                            ),
                                          )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 2,20,0),
                              child: Text("Your Shipping Address", style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20,20,20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.purple.shade400,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0.0, 0.3),
                                          blurRadius: 15.0)
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Text("Amaravati\nNear Secratairat,\nVelagapudi,\nAndhra Pradesh,\nIndia",
                                        style: TextStyle(color: Colors.white,fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 2,20,0),
                              child: GestureDetector(
                                   onTap: ()async {
                                     if(await canLaunch(widget.url)) {
                                       launch(
                                         widget.url,
                                         forceSafariVC: false,
                                         forceWebView: true,
                                       );
                                     }

                                   },
                                  child: Text("Transaction Details", style: TextStyle(color: Colors.blueAccent,fontSize: 20,decoration: TextDecoration.underline),)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
