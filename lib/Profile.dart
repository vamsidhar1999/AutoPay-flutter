import 'package:autopayflutter/ProfileListItem.dart';
import 'package:autopayflutter/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Column(
      children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 2),
        Text(
          'Nicolas Adams',
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
                    color: const Color(0xff6361f3),
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
                    icon: Icons.account_circle_outlined,
                    text: 'Name',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.mail_outline,
                    text: 'mail',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.phone,
                    text: 'mobile',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.calendar,
                    text: 'Birthday',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.wallet_membership,
                    text: 'wallet',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.logout,
                    text: 'Logout',
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
    Paint paint = Paint()..color = const Color(0xff6361f3);
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
