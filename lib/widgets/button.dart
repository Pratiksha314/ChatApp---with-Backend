import 'package:chatsapp/widgets/styles.dart';
import 'package:flutter/material.dart';

Widget submitButton(String text, Function func, BuildContext context) {
  return GestureDetector(
    onTap: func,
    child: Container(
      alignment: Alignment.center,
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color.fromRGBO(43, 84, 140, 0.41),
            const Color.fromRGBO(43, 109, 110, 0.7),
          ]),
          borderRadius: BorderRadius.circular(32)),
      child: Text(
        text,
        style: styleText(),
      ),
    ),
  );
}
