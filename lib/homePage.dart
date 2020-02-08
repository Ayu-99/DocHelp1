import 'package:flutter/material.dart';
import 'services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  Home({
    this.auth,
    this.onSignedOut,

});
  @override
  _HomeState createState() => _HomeState();
}
String phoneNo;
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signOut() async{
  _auth.signOut();
}

class _HomeState extends State<Home> {

  void _logoutUser() async{
    try{
      await signOut();
      widget.onSignedOut;
      Navigator.of(context).pushNamed("/Login");
    }catch(e){
      print(e.toString());
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
                    'You',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                  child:Text(
                    ' Are a',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 120.0, 0.0, 0.0),
                  child:Text(
                    '....',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 250.0, left:20.0, right:20.0),
                  child: Column(
                    children: <Widget>[



                      SizedBox(height: 20.0),

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
                              Navigator.of(context).pushNamed("/PatientDetails");
                              // verifyPhone();
                              // if(_formKey.currentState.validate()){
                              //     msg: "Username or Password Incorrect",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     // timeInSecForIos: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                            },
                            child:Center(
                              child:Text(

                                'PATIENT',
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
                              Navigator.of(context).pushNamed("/DoctorDetails");

                              // verifyPhone();
                              // if(_formKey.currentState.validate()){
                              //     msg: "Username or Password Incorrect",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     // timeInSecForIos: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                            },
                            child:Center(
                              child:Text(

                                'DOCTOR',
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
                              Navigator.of(context).pushNamed("/StaffDetails");
                              // verifyPhone();
                              // if(_formKey.currentState.validate()){
                              //     msg: "Username or Password Incorrect",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     // timeInSecForIos: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                            },
                            child:Center(
                              child:Text(

                                'STAFF',
                                style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                              _logoutUser();
//                              Navigator.of(context).pushNamed("/DoctorDetails");

                              // verifyPhone();
                              // if(_formKey.currentState.validate()){
                              //     msg: "Username or Password Incorrect",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     // timeInSecForIos: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                            },
                            child:Center(
                              child:Text(

                                'LOGOUT',
                                style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),],),

          )],),
    );
  }
}



