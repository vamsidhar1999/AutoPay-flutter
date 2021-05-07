import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ACOrderDetails extends StatefulWidget {
  final String url;
  const ACOrderDetails({
    Key key,
    this.url
});
  @override
  _ACOrderDetailsState createState() => _ACOrderDetailsState();
}

class _ACOrderDetailsState extends State<ACOrderDetails> {
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
                /*child: Column(
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
                ),*/
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
                              child: Text("AC Servicing Details", style: TextStyle(color: Colors.white, fontSize: 17),),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            /*Padding(
                              padding: const EdgeInsets.fromLTRB(30, 2,20,0),
                              child: Text("Your product details(order 430-120-102)", style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),*/
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
                                          child: Image(image: AssetImage("images/ac.jpg"))),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Company Name: UrbanClap\n Agent Name: Aditya Narayan\n Mobile No: +917453469999", style: TextStyle(color: Colors.white,fontSize: 13),),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Total Amount: 300 Eth", style: TextStyle(color: Colors.white,fontSize: 13),),
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
                              child: Text("Your Home Address", style: TextStyle(color: Colors.white,fontSize: 15),),
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
                                      Text("4-3-81/7,\nNagarjuna Colony,\nGuntur,\nAndhra Pradesh,\nIndia,\n522403.",
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
