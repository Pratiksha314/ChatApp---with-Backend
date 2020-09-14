import 'package:flutter/material.dart';

Widget search(TextEditingController sControl, Function tap) {
  return Container (
            color: Color.fromRGBO(88, 102, 122,0.55),
            padding:  EdgeInsets.only(top:7,left:24,right:10,bottom:7),
            child: Row (
              children: <Widget>[             
                Expanded ( 
                  child: TextFormField (
                    controller: sControl,
                    style: TextStyle (
                      color: Colors.white,
                    ),
                      decoration: InputDecoration (
                      border: InputBorder.none,
                      hintText: "Search Username",
                      hintStyle: TextStyle ( color: Colors.white54, ),
                    ),
                  ),
                ),
               IconButton ( icon: 
               Icon (Icons.search,color: Colors.white54,size: 25,), 
               onPressed:tap ),            
              ],
            ),
  );
}
