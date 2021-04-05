
import 'package:autopayflutter/things/transactiondesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  FirebaseAuth _auth = FirebaseAuth.instance;
   var uid;



   getUser() async {
    await Firebase.initializeApp();
     uid = FirebaseAuth.instance.currentUser.uid;
     print(uid);
     return uid;
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUser();
  }

  // data() async{
  //   var results=await Firestore.instance.collection('donor').where('places', arrayContains:"Krishna" ).getDocuments();
  //   results.documents.forEach((res) {
  //     print(res.data['name']);
  //   });
  //   print(results.documents[0].data['name']);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[500],
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: Column(
            children: <Widget>[

              Flexible(
                  child: FutureBuilder(
                    future: getUser(),
                    builder: (context, snapshot) {
                      print(uid);
                      if (snapshot.hasData) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('user').doc(uid).collection("thing").doc("AP278098").collection('transactions').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                List<Widget> usersList = [];
                                final docs = snapshot.data.docs;
                                print(docs);
                                for (var document in docs) {
                                 print(document.data);
                                 var data=document.data();
                                   var address = data['address'];
                                   var amount = data['amount'];
                                   var currency=data['currency'];
                                   var timestamp=data['timestamp'];
                                   var to=data['to'];
                                   var hash=data['hash'];
                                   var status=data['status'];
                                   if(true) {
                                     usersList.add(
                                         TransactionDesign(
                                             amount: amount.toString(),
                                             status: status,
                                             timestamp: timestamp,
                                             currency: currency,
                                             to: to,
                                             hash: hash,
                                             address: address
                                         ),
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
                                  children: usersList,
                                );
                              }
                              return Container();
                            });
                      }
                      return Container();
                    },
                  ))
            ],
          )),
    );
  }
}
