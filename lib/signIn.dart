// import 'package:attempt/logInPhone.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:attempt/signUp.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shitf/User.dart';
import 'package:shitf/services/authentication.dart';
import 'services/authentication.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'mapping.dart';

AuthImplementation  auth;
class MyHomePage extends StatefulWidget {
 MyHomePage({
   this.auth,
   this.onSignedIn,
 });
  AuthImplementation auth;
  final VoidCallback onSignedIn;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  String _error;
  String email;
  String password;
  String phoneNo;
  String smsCode;
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  User _userFromFirebase(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }

  Future registerWithEmailAndPassword(String email, String password) async{
    try{

      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      print("User is:$user");

      return _userFromFirebase(user);

    }catch(e){
      setState(() {
        _error=e.message;
      });
      print(e.toString());
      return null;
    }
  }
  Widget showAlert(){
    if(_error!=null){
      return Container(
        color: _error==""?Colors.white24:Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(_error, maxLines:3,),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  setState(() {
                    _error=null;

                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(height:8.0);
  }


  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    print("signed in " + user.displayName);
    return user;
  }

  bool validate(){
    final form=formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            child:Stack(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                  child:Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                  child:Text(
                    ' There',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(240.0, 120.0, 0.0, 0.0),
                  child:Text(
                    '.',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),

                Container(
                  padding: EdgeInsets.only(top: 250.0, left:20.0, right:20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Form(
                          key: formKey,
                          child:Column(
                            children: <Widget>[
                              TextFormField(
                                validator:EmailValidator.validate,
                                onChanged: (val)=>email=val,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(

                                    color:Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide:BorderSide(color:Colors.blue[300]),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.0),
                              TextFormField(
                                obscureText: true,
                                validator:PasswordValidator.validate,
                                onChanged: (val)=>password=val,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),

                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    color:Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide:BorderSide(color:Colors.blue[300]),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ),
                      ),

                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top:15.0, left:20.0),
                        child:InkWell(
                          child:FlatButton(
                            child:  Text('Forgot Password?',
                              style:TextStyle(
                                color:Colors.blue[300],
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed:() {
                              Navigator.of(context).pushNamed("/ResetPassword");
                            },

                          ),

                        ),
                      ),
                      SizedBox(height: 40.0,),
                      Container(
                        height: 40.0,
                        child:Material(


                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue[300],
                          elevation: 7.0,
                          child:RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)),
                            color: Colors.blueAccent,
                            onPressed:(){
                              // if(_formKey.currentState.validate()){
                              dynamic result=signInWithEmailAndPassword(email, password);
                              if(validate()){
                                if(_error!=null){
                                  if(result==null){
                                    setState(() {
                                        print("There is error");

                                    });

                                  }else{
                                    Navigator.of(context).pushNamed("/HomePage");

                                    print("User Logged in!!");
                                    widget.onSignedIn;
//                                widget.onSignedIn();
                                  }
                                }
                              }



                            },
                            child:Center(
                              child:Text(

                                'LOGIN',
                                style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0,),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            border:Border.all(color: Colors.black,
                              style:BorderStyle.solid,
                              width: 1.0,),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Center(
                              //   child: IconButton(
                              //     icon:
                              //   ),
                              // ),
                              SizedBox(width: 1.0,),
                              Center(
                                child:FlatButton(
                                    onPressed: (){
                                      _handleSignIn()
                                          .then((FirebaseUser user) => print(user))
                                          .catchError((e) => print(e));
                                    },
                                    child:Text('Log in with Google',
                                        style:TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ))),
                              ),
                            ],
                          ),

                        ),


                      ),
                      SizedBox(height: 30.0,),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            border:Border.all(color: Colors.black,
                              style:BorderStyle.solid,
                              width: 1.0,),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Center(
                                child:FlatButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed("/LoginPhone");
                                  },
                                  child:Text('Log in with Phone',
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),

                              ),
                              SizedBox(width: 0.05,),
                              Center(
                                child:IconButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed("/LoginPhone");                                  },
                                  icon:Icon(Icons.phone),
                                ),
                              ),

                            ],
                          ),

                        ),


                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'New to DocHelp?',
                  style:TextStyle(fontWeight: FontWeight.bold,
                    color:Colors.blueAccent[300],)
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/Register");
                },
                child:Text(
                  'Register',
                  style:TextStyle(
                    color:Colors.blue[300],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          showAlert(),

        ],),
    );
  }
}
