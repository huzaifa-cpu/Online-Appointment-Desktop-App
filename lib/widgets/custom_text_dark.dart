import 'package:flutter/material.dart';
import 'package:side_hospital_desktop_app/constraints/custom_colors.dart';

class CustomTextDark extends StatelessWidget {
  String name;
  CustomTextDark({this.name});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        color: _colors.purple,
        fontFamily: "CenturyGothic",
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
