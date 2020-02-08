import 'package:flutter/material.dart';
import 'package:shitf/signIn.dart';
import 'signIn.dart';
import 'signUp.dart';
import 'homePage.dart';
import 'package:shitf/services/authentication.dart';


class MappingPage extends StatefulWidget {
  AuthImplementation auth;
  MappingPage({this.auth});
  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {

  AuthStatus authStatus=AuthStatus.notSignedIn;

  @override
  void initState() {

    super.initState();

    widget.auth.getCurrentUser().then((firebaseUSerId){
      setState(() {
        authStatus=firebaseUSerId==null?AuthStatus.notSignedIn:AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus=AuthStatus.signedIn;
    });
  }


  void _signedOut(){
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:return MyHomePage(
        auth:widget.auth,
        onSignedIn:_signedIn,
      );

      case AuthStatus.signedIn:
        return Home(
          auth:widget.auth,
          onSignedOut:_signedOut,
        );
    }
  }
}
