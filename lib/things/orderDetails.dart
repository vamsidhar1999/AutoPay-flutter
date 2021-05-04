import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Color primaryColor = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 44, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text("Arriving Date", style: TextStyle(color: primaryColor, fontSize: 15)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 7),
                    child: Text("06 May, 2021", style: TextStyle(fontSize: 25),),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.85,
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
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
                          padding: const EdgeInsets.fromLTRB(20, 5,20,20),
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
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: Image(image: AssetImage("images/detergent.jpg"))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("SurfExcel Liquid 1L", style: TextStyle(color: Colors.white,fontSize: 18),),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("84 Diem", style: TextStyle(color: Colors.white,fontSize: 18),),
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
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
