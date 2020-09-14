import 'package:chatsapp/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Auth {

  final FirebaseAuth _auth = FirebaseAuth.instance ;
  User _userFromFireBaseUser (FirebaseUser user) {
     return user != null ? User(userId:user.uid) : null;
  }

  Future signIn(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: pass);
      FirebaseUser firebaseUser = result.user;
      return _userFromFireBaseUser(firebaseUser);
    } catch(e){ print(e.toString());}
  }

  Future signUp( String email, String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,
       password: pass);
       FirebaseUser firebaseUser = result.user;
       return _userFromFireBaseUser(firebaseUser);
    }
    catch(e){print(e.toString());}
  }
  
  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){print(e.toString());}
  }

  Future signout() async {
    try{
     return await _auth.signOut();
    }catch(e){print(e.toString());}
  }

}