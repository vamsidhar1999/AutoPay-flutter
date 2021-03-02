import 'package:autopayflutter/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextField extends StatefulWidget {
  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {

  TextEditingController name = TextEditingController();

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
      child: TextField(
        // controller: name,
      )
    );
  }
}
