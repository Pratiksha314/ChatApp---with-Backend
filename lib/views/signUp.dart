import 'package:chatsapp/helper/sharedFunction.dart';
import 'package:chatsapp/services/auth.dart';
import 'package:chatsapp/services/database.dart';
import 'package:chatsapp/widgets/button.dart';
import 'package:chatsapp/widgets/textField.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  static const routeName = '/signUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController userNameC = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> formkey = GlobalKey();
  Auth auth = Auth();
  DatabaseMethods dbm = DatabaseMethods();

  void signUp() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      setState(() {
        isLoading = true;
      });
      auth.signUp(emailC.text, passC.text).then((val) => print('${val.uid}'));
      Map<String, String> userInfoMap = {
      'name' : userNameC.text,
      'email' : emailC.text
      };
      SharedFunctions.saveUserNameSP(userNameC.text);
      SharedFunctions.saveUserEmailSP(emailC.text);
      dbm.uploadUserInfo(userInfoMap);
      SharedFunctions.saveUserLoggedInSP(true);
      Navigator.pushNamed(context, '/chatRoom');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(41, 60, 94, 0.61),
        body: isLoading ? Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
          child: Container(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.jpg',
                  ),
                  username(userNameC),
                  textFormField(emailC, passC),
                  SizedBox(
                    height: 11,
                  ),
                  submitButton('SignUp', signUp, context),
                  txtRow("Already have an account ?", () {
                   widget.toggle();
                  }, "Sign In"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
