import 'package:autopayflutter/EnterMobile.dart';
import 'package:autopayflutter/ProfileListItem.dart';
import 'package:autopayflutter/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = "";
  String email = "";
  String mobile = "";
  String dob = "";
  String currency = "";
  String gender = "";

  _getDetails() async {
    await Firebase.initializeApp();
    final uid = FirebaseAuth.instance.currentUser.uid;
    var snapShot = await FirebaseFirestore.instance.collection("user").doc(uid).get();
    setState(() {
      name = snapShot.data()["name"].toString();
      email = snapShot.data()["email"].toString();
      mobile = snapShot.data()["mobile"].toString();
      gender = snapShot.data()["gender"].toString();
      dob = snapShot.data()["dob"].toString();
      currency = snapShot.data()["currency"].toString();
    });
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Column(
      children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 2),
        Text(
          name,
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
                  radius: kSpacingUnit.w * 5,
            backgroundImage: NetworkImage(
                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"),
          ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: kSpacingUnit.w * 2.5,
                  width: kSpacingUnit.w * 2.5,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    heightFactor: kSpacingUnit.w * 1.5,
                    widthFactor: kSpacingUnit.w * 1.5,
                    child: Icon(
                      CupertinoIcons.pen,
                      color: Colors.white,
                      size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      body: Stack(children: [
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
              child: ListView(
                children: <Widget>[
                  ProfileListItem(
                    icon: Icons.phone,
                    text: mobile,
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.mail_outline,
                    text: email,
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: FontAwesomeIcons.genderless,
                    text: gender,
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.calendar,
                    text: dob,
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.wallet_membership,
                    text: currency,
                    hasNavigation: false,
                  ),
                  GestureDetector(
                    child: ProfileListItem(
                      icon: Icons.logout,
                      text: 'Logout',
                    ),
                    onTap: (){
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.popUntil(context, (route) => false);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => EnterMobile()));
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purple;
    Path path = Path()
      ..relativeLineTo(0, 120)
      ..quadraticBezierTo(size.width / 2, 220.0, size.width, 120)
      ..relativeLineTo(0, -120)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
