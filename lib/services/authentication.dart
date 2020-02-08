import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shitf/User.dart';
import 'package:google_sign_in/google_sign_in.dart';


String uid;
User _userFromFirebase(FirebaseUser user){
  return user!=null?User(uid:user.uid):null;
}

abstract class AuthImplementation{
  Future registerWithEmailAndPassword(String email, String password);
  Future signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUser();
  Future<bool> isEmailVerified();
  Future<void> sendEmailVerification();

}

class Auth implements AuthImplementation{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(String email, String password) async{

    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
//      await DatabaseService(uid:user.uid).updateUserData(email, password);


      return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  String sendUid(){
    return uid;
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future<void> signOut() async{
    _auth.signOut();
  }

  Future<String> getCurrentUser() async{
    FirebaseUser user=await _auth.currentUser();
    return user.uid;
  }
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

}

class EmailValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Password can't be empty";
    }
    if(value.length<6){
      return "Password should be atleast 6 characters long";
    }
    return null;
  }
}