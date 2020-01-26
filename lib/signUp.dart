import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:attempt/signUp.dart';
import 'package:shitf/User.dart';
//import 'DoctorDetails.dart';

// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner:false ,
//       home: MyHomePage(),

//     );
//   }
// }

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;
  String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  User _userFromFirebase(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }


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

  // Future registerWithFacebook(){
  //   try{


  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }






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
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val)=>val.isEmpty?'Enter a valid email':null,
                        onChanged: (val)=>email=val,
                        decoration: InputDecoration(
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
                        validator: (val)=>val.length>6?'Enter a password of length > 6 characters':null,
                        onChanged: (val)=>password=val,
                        decoration: InputDecoration(

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
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top:15.0, left:20.0),
                        child:InkWell(
                          child: Text('Forgot Password?',
                            style:TextStyle(
                              color:Colors.blue[300],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
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
                              dynamic result=registerWithEmailAndPassword(email, password);
                              if(result==null){
                                setState(() {
                                  print("No user");
                                  // Fluttertoast.showToast(
                                  //     msg: "Username or Password Incorrect",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     // timeInSecForIos: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0
                                  // );
                                });

                              }else{
                                print("User registered!!!");
                                Navigator.of(context).pushNamed("/Login");
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
                              Center(
                                child: ImageIcon(AssetImage('assets/facebook.png'),),
                              ),
                              SizedBox(width: 1.0,),
                              Center(
                                child:Text('Register with Facebook',
                                    style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                  onPressed: (){},
                                  icon:Icon(FontAwesomeIcons.phone),
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
                  'Already Registered?',
                  style:TextStyle(fontWeight: FontWeight.bold,
                    color:Colors.blueAccent[300],)
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/HomePage");
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

        ],),
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