import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'crud.dart';
import 'AuthService.dart';


crudMethods c=new crudMethods();


class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  Future<void> EmailLinkDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
//          title: Text('Do u want to save the Patient before deleting it?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('A password email link is send to your mail id: $email',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  print("email send");
                  Navigator.of(context).pushNamed("/Login");
                });
              },
            ),

          ],
        );
      },
    );
  }

  String email;
  @override
  Widget build(BuildContext context) {
//    final AuthService auth = Provider.of(context).auth;

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
                      'Reset ',
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                    child:Text(
                      ' Password',
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(290.0, 105.0, 0.0, 0.0),
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
                          validator: (val)=>val.length>0?'Enter a valid email':null,
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
                              elevation: 5.0,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blueAccent)),
                              color: Colors.blueAccent,
                              onPressed:() async{
                                await c.sendPasswordResetLink(email);
                                EmailLinkDialog(context);
                              },
                              child:Center(
                                child:Text(

                                  'RESET',
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