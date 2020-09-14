import 'package:chatsapp/helper/authenticate.dart';
import 'package:chatsapp/helper/sharedFunction.dart';
import 'package:chatsapp/views/chatsscreen.dart';
import 'package:chatsapp/views/convo.dart';
import 'package:chatsapp/views/search.dart';
import 'package:chatsapp/views/signUp.dart';
import 'package:chatsapp/views/signin.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() { 
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async {
    await SharedFunctions.getUserLoggedInSP().then((value) {
      setState(() {
        userIsLoggedIn = value ;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
      ),
      home: userIsLoggedIn ? ChatRoom() : Authenticate() ,
     
      routes: {
        ChatRoom.routeName : (ctx) => ChatRoom(),
        SignIn.routeName : (ctx) => SignIn(),
        SearchScreen.routeName : (ctx) => SearchScreen(),
        Conversation.routeName : (ctx) => Conversation(),
        SignUp.routeName :(ctx)=> SignUp(),
      },
    );
  }
} 