import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/icon_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shitf/User.dart';
import 'package:shitf/services/authentication.dart';
import 'mapping.dart';
import 'package:auto_size_text/auto_size_text.dart';


AuthImplementation auth;


class Register extends StatefulWidget {

  Register({
    this.auth,
    this.onSignedIn,
});


  AuthImplementation auth;
  final VoidCallback onSignedIn;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _error;
  final formKey = GlobalKey<FormState>();
  String email;
  String password;
  String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  final GoogleSignIn googleSignIn = new GoogleSignIn();

  User _userFromFirebase(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
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

  Future registerWithEmailAndPassword(String email, String password) async{

    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
//      await DatabaseService(uid:user.uid).updateUserData(email, password);


      return _userFromFirebase(user);

    }catch(e){
      print(e);
      setState(() {
        _error=e.message;
      });
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



  void SnackBarPage(){
    final snackBar = SnackBar(
        content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
    // Some code to undo the change.
    },
    )
    );
  }


  void _changeFormToLogin(){

    print("User registered!!!");
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed("/Login");
  }



  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Verify your account"),
          content: Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            FlatButton(
              child: Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();


//                Navigator.of(context).pushNamed("/Login");

              },
            ),
          ],
        );
      },
    );
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
                    'Register',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                  child:Text(
                    ' Here',
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
                  child: Form(
                    key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: EmailValidator.validate,
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
                        validator: PasswordValidator.validate,
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
                      SizedBox(height: 5.0),

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
                              if(validate()){
                                dynamic result=registerWithEmailAndPassword(email, password);
                                if(_error==null){
                                  if(result==null){
                                    final snackBar = SnackBar(
                                        content: Text('Cannot Register!'),
                                        action: SnackBarAction(
                                          label: 'Dismiss',
                                          onPressed: () {
                                            // Some code to undo the change.
                                            Navigator.of(context).pop();
                                          },
                                        )
                                    );
                                    setState(() {
                                      snackBar;
                                      Scaffold.of(context).showSnackBar(snackBar);
                                    });

                                  }else{
//                                    widget.auth.sendEmailVerification();
//                                    _showVerifyEmailSentDialog();
                                    Navigator.of(context).pushNamed("/Login");



                                  }
                                }
                                }



                            },
                            child:Center(
                              child:Text(

                                'REGISTER',
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
                                    child:Text('Register with Google',
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
                                child:Text('Register with Phone',
                                    style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
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
                )
              ],
            ),
          ),

          SizedBox(height: 40.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Already Registered?',
                  style:TextStyle(fontWeight: FontWeight.bold,
                    color:Colors.blueAccent[300],)
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/Login");
                },
                child:Text(
                  'Login',
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
      ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'User.dart';




// class RegisterShow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Register(),

//     );
//   }
// }

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   var _formKey=GlobalKey<FormState>();
//   String email;
//   String password;

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   User _userFromFirebase(FirebaseUser user){
//       return user!=null?User(uid:user.uid):null;
//     }

//     Future registerWithEmailAndPassword(String email, String password) async{
//     try{

//       AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       FirebaseUser user=result.user;

//       return _userFromFirebase(user);

//     }catch(e){
//         print(e.toString());
//         return null;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:Form(
//         key: _formKey,
//         child:Column(
//           children: <Widget>[

//                 Material(
//                   // padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
//                   child:Text(
//                     'Register',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 Container(
//                   padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
//                   child:Text(
//                     ' Here',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(240.0, 120.0, 0.0, 0.0),
//                   child:Text(
//                     '.',
//                     style: TextStyle(
//                       color: Colors.blue[300],
//                       fontSize: 80.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                 ),

//                 Container(
//                   padding: EdgeInsets.only(top: 250.0, left:20.0, right:20.0),
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         validator: (val)=>val.isEmpty?'Enter a valid email':null,
//                         onChanged: (val)=>email=val,
//                         decoration: InputDecoration(
//                           labelText: 'EMAIL',
//                           labelStyle: TextStyle(
//                             color:Colors.grey,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           focusedBorder:UnderlineInputBorder(
//                             borderSide:BorderSide(color:Colors.blue[300]),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 20.0),
//                       TextFormField(
//                         obscureText: true,
//                         validator: (val)=>val.length>6?'Enter a password of length > 6 characters':null,
//                         onChanged: (val)=>password=val,
//                         decoration: InputDecoration(

//                           labelText: 'PASSWORD',
//                           labelStyle: TextStyle(
//                             color:Colors.grey,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           focusedBorder:UnderlineInputBorder(
//                             borderSide:BorderSide(color:Colors.blue[300]),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 5.0),
//                       Container(
//                         height: 40.0,
//                         child:Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.blueAccent,
//                           color: Colors.blue[300],
//                           elevation: 7.0,
//                           child:RaisedButton(
//                             onPressed:()async{
//                                 // if(_formKey.currentState.validate()){
//                                     dynamic result= await registerWithEmailAndPassword(email, password);
//                                     if(result==null){
//                                       setState(() {
//                                         print("No user");
//                                         // Fluttertoast.showToast(
//                                         //     msg: "Username or Password Incorrect",
//                                         //     toastLength: Toast.LENGTH_SHORT,
//                                         //     gravity: ToastGravity.CENTER,
//                                         //     // timeInSecForIos: 1,
//                                         //     backgroundColor: Colors.red,
//                                         //     textColor: Colors.white,
//                                         //     fontSize: 16.0
//                                         // );
//                                       });

//                                 }else{
//                                   print("User Registered");
//                                 }

//                             },
//                             child:Center(
//                               child:Text(
//                                 'REGISTER',
//                                 style: TextStyle(
//                                   color:Colors.white,
//                                   fontWeight: FontWeight.bold,

//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//           ],
//         ),

//       ),

//               ],

//       )));

//   }
// }