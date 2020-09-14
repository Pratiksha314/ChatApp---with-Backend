import 'package:flutter/material.dart';

InputDecoration textDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}

TextStyle textFieldStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle styleText() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}