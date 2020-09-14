import 'package:chatsapp/widgets/styles.dart';
import 'package:flutter/material.dart';

Widget textFormField(
    TextEditingController eControl, TextEditingController pControl) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: <Widget>[
        TextFormField(
          controller: eControl,
          style: textFieldStyle(),
          decoration: textDecoration("E-mail"),
          validator: (val) {
            if (val.isEmpty || !val.contains('@')) {
              return 'Enter valid Email Id';
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: pControl,
          style: textFieldStyle(),
          decoration: textDecoration("Password"),
          validator: (val) {
            if (val.isEmpty) {
              return 'Enter password';
            }
            return null;
          },
          obscureText: true,
        ),
      ],
    ),
  );
}

Widget username(TextEditingController userName) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: TextFormField(
      controller: userName,
      validator: (val) {
        return val.isEmpty || val.length < 3 ? 'incorrect' : null;
      },
      style: textFieldStyle(),
      decoration: textDecoration("Username"),
    ),
  );
}

Widget txtRow(String text, Function func, String txt) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 55,
      ),
      Text(
        text,
        style: styleText(),
      ),
      FlatButton(
          onPressed: func,
          child: Text(
            txt,
            style: styleText(),
          )),
    ],
  );
}
