import 'dart:collection';
import 'package:autopayflutter/models/my_flutter_app_icons.dart';
import 'package:toast/toast.dart';
import 'package:toast/toast.dart';

import 'package:autopayflutter/DashBoard.dart';
import 'package:autopayflutter/services/restapi.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/color.dart';
import '../profile/Profile.dart';

class WasherRegister extends StatefulWidget {
  @override
  _WasherRegisterState createState() => _WasherRegisterState();
}

class _WasherRegisterState extends State<WasherRegister> {
  TextEditingController number = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController model=TextEditingController();
  int gender_value = 0;


  _register() async {
    var currency=_value == 0 ? "diem" : "eth";
    print('hi');
    var wallet= await createWallet(currency);
    print(wallet['publicKey']);
    final user = FirebaseAuth.instance.currentUser;
       Map<String, dynamic> data = <String, dynamic>{
      "id": number.text,
      "address": wallet['address'],
      "privatekey":wallet['privateKey'] ,
      "publickey": wallet['publicKey'],
      'company':company.text,
       "model": model.text,
      "currency": currency,
      "thing":"washer",
       "status": "off"
    };
       print(data);
    // print(user.uid);
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .collection('thing')
        .doc(number.text)
        .set(data)
        .then((value) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    });
  }

  textField(String text, var controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: TextField(
          controller: controller,
          cursorColor: Colors.purple,
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            focusColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20, color: Colors.black),
            labelText: text,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }

  DateTime _selectedDate;
  TextEditingController date = TextEditingController();
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.purple,
                onPrimary: Colors.white,
                surface: Colors.purple,
                onSurface: Colors.purple,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      date
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: date.text.length, affinity: TextAffinity.upstream));
    }
  }

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Column(
      children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 2),
        Text(
          'Auto Pay',
          style: kTitleTextStyle.copyWith(color: Colors.white, fontSize: 25),
        ),
        Container(
          height: kSpacingUnit.w * 10,
          width: kSpacingUnit.w * 10,
          margin: EdgeInsets.only(top: 20),
          child: Stack(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: kSpacingUnit.w * 5,
                 child:  Icon(MyFlutterApp.washer,),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: profileInfo,
              ),
              SizedBox(height: kSpacingUnit.w * 2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
                  child: ListView(
                    children: <Widget>[
                      textField("WashingMachine_ID", number),
                      textField("Brand_Name", company),
                      textField("Model", model),
                     
                      
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => setState(() => _value = 0),
                              child: Container(
                                  // height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: _value == 0
                                        ? const Color(0xffeda5f0)
                                        : Colors.transparent,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Image(
                                          image: AssetImage("images/diem.jpeg"),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('Diem', style: kTitleTextStyle.copyWith(
                                          color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),),
                                    ],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _value = 1),
                              child: Container(
                                  // height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: _value == 1
                                        ? const Color(0xffeda5f0)
                                        : Colors.transparent,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Image(
                                            image: AssetImage("images/eth.jpeg"),
                                          ),
                                        ),
                                        Text('Ethereum', style: kTitleTextStyle.copyWith(
                                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: Container(
                          height: 50,
                          width: 30,
                          child: RaisedButton(
                            onPressed: (){
                              print(number.text);
                              if(number.text==""||model.text==""||company.text==""){
                                Toast.show("Please enter all the fields", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              }
                              else {
                                print('hii');
                                _register();
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.purple,
                            child: Text(
                              "Submit",
                              style: kTitleTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}