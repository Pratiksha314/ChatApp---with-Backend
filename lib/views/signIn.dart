import 'package:chatsapp/helper/sharedFunction.dart';
import 'package:chatsapp/services/auth.dart';
import 'package:chatsapp/services/database.dart';
import 'package:chatsapp/widgets/button.dart';
import 'package:chatsapp/widgets/styles.dart';
import 'package:chatsapp/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  static const routeName = '/signIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth auth = Auth();
  DatabaseMethods dbm = DatabaseMethods();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo ;
  final GlobalKey<FormState> formkey = GlobalKey();

  void signIn() {
    if (formkey.currentState.validate()) {
      SharedFunctions.saveUserEmailSP(emailC.text);
      //get user by email
      dbm.getUserByEmail(emailC.text).then((val) {
        snapshotUserInfo = val;
        SharedFunctions.saveUserNameSP(
            snapshotUserInfo.documents[0].data['name']);
      });
      setState(() {
        isLoading = true;
      });
      auth.signIn(emailC.text, passC.text).then((value) {
        if (value != null) {
          SharedFunctions.saveUserLoggedInSP(true);
          Navigator.pushNamed(context, '/chatRoom');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
        //appBar: AppBar(title: Text("🅣🅐🅛🅚🅘🅔🅢"),),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.jpg',
                  ),
                  textFormField(emailC, passC),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: FlatButton(
                        onPressed: null,
                        child: Text(
                          'Forget Password ?',
                          style: styleText(),
                        )),
                  ),
                  submitButton('SignIn', signIn, context),
                  txtRow("Dont' have an account ?", () {
                   widget.toggle();
                  }, "Sign Up"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
