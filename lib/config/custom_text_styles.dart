import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle title(BuildContext context) {
    return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);
  }
}
