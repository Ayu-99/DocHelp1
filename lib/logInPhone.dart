import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatefulWidget {
  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {


  String phoneNo;
  String smsCode;
  String verificationCode;

  Future<void> verifyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve =(String verId){
      this.verificationCode=verId;


    };
    final PhoneCodeSent smsCodeSent=(String verId, [int forceCodeResend]){
      this.verificationCode=verId;
      smsCodeDialog(context).then((value){
        print("Signed In");
      });
    };


    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user){
      print('Phone Verification Completed');
    };

    PhoneVerificationFailed verifiedFailed(AuthException exception){
      print('${exception.message}');
      return null;

    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );

  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text("Enter sms code"),
            content: TextField(
              onChanged: (val){
                this.smsCode=val;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text("Done"),
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user){
                    if(user!=null){
//                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("/HomePage");

                    }else{
//                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        }
    );
  }

  signIn(){
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode,
        smsCode: smsCode);

    FirebaseAuth.instance.signInWithCredential(credential).then((user){
      Navigator.of(context).pushNamed('/HomePage');
    }).catchError((e){
      print('Auth Credential Error : $e');
    });
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
                    'Login Via',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                  child:Text(
                    ' Phone',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 120.0, 0.0, 0.0),
                  child:Text(
                    '.',
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
                      TextFormField(
                        validator: (val)=>val.length<10?'Enter a valid phoneNo':null,
                        onChanged: (val)=>phoneNo=val,
                        decoration: InputDecoration(
                          labelText: 'PHONE',
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
                                side: BorderSide(color: Colors.red)),
                            color: Colors.blueAccent,
                            onPressed:(){
                              verifyPhone();
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
                    ],
                  ),
                ),],),

          )],),
    );



  }






}