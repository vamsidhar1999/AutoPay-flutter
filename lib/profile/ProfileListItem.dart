import 'package:autopayflutter/models/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final int email_font;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.email_font,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 6.0,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 3,
      ).copyWith(
        bottom: kSpacingUnit.w * 2.5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5.0,
          ),
        ]
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit.w * 3.5,
            color: Colors.black,
          ),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: kSpacingUnit.w * 2.0,
              color: Colors.black,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.chevron_right,
              size: kSpacingUnit.w * 2.5,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}