// import 'package:attempt/User.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shitf/signIn.dart';
import 'package:shitf/crud.dart';



String staffName;
String staffPhone;
String staffAddress;
String staffUdoctor;
String staffEmail;


class StaffDetailsClass{
  String getStaffName(){
    return staffName;
  }
  String getStaffUDoctor(){
    return staffUdoctor;
  }
  String getStaffPhone(){
    return staffPhone;
  }
  String getStaffAddress(){
    return staffAddress;
  }
  String getStaffEmail(){
    return staffEmail;
  }

}



class StaffDetails extends StatefulWidget {
  @override
  _StaffDetailsState createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {

  QuerySnapshot doctors;

  crudMethods c=new crudMethods();



  @override
  Widget build(BuildContext context) {




    return Scaffold(


      body:Column(
        children: <Widget>[

          Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(

                  padding: EdgeInsets.fromLTRB(2.0, 30.0, 0.0, 0.0),
                  child:Text(
                    'Enter your Details....',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),

                SizedBox(height: 20.0,),

                TextFormField(
                  validator: (val)=>val.isEmpty?'Enter a valid name':null,
                  onChanged: (val)=>staffName=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    // contentPadding: EdgeInsets.fromLTRB(50.0, 10.0, 20.0, 10.0),
                    labelText: 'NAME',
                    labelStyle: TextStyle(
                      color:Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder:UnderlineInputBorder(

                      borderSide:BorderSide(color:Colors.blue[300]),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  validator: (val)=>val.length<10?'Enter a valid phone Number':null,
                  onChanged: (val)=>staffPhone=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
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
                SizedBox(height: 10.0,),

                TextFormField(
                  validator: (val)=>val.isEmpty?'Enter your address':null,
                  onChanged: (val)=>staffAddress=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
                    labelText: 'ADDRESS',
                    labelStyle: TextStyle(
                      color:Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide:BorderSide(color:Colors.blue[300]),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  validator: (val)=>val.isEmpty?'Enter your email':null,
                  onChanged: (val)=>staffEmail=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
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
                SizedBox(height: 10.0,),
                TextFormField(

                  validator: (val)=>val.isEmpty?'Enter the name of doctor under which u work':null,
                  onChanged: (val)=>staffUdoctor=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.plus_one),
                    labelText: 'WORKING UNDER DOCTOR',
                    labelStyle: TextStyle(
                      color:Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide:BorderSide(color:Colors.blue[300]),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                Container(
                  width: 100.0,
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
                      onPressed:() {
                        Navigator.of(context).pop();
                        Map<String, String> staffDetails={'name':staffName, 'phone':staffPhone,
                          'address':staffAddress, 'udoctor':staffPhone};
                        c.addStaff(staffDetails).then((result){
                          print("Result");
                          Navigator.of(context).pushReplacementNamed("/PatientsList");
                        }).catchError((e){
                          print(e);
                        });
//                               print("User in firestore");
                        // uid=User.uid;
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

                          'NEXT',
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
          ),
        ],
      ),
    );
  }


}