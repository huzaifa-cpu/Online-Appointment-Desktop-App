import 'package:flutter/material.dart';
import 'package:side_hospital_desktop_app/constraints/custom_colors.dart';

class CustomTextLight extends StatelessWidget {
  String name;
  CustomTextLight({this.name});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontFamily: "CenturyGothic",
        color: _colors.purple,
      ),
    );
  }
}
