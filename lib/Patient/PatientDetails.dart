// import 'package:attempt/User.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'signUp.dart';
import '../crud.dart';


class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {

  QuerySnapshot doctors;

  crudMethods c=new crudMethods();



  @override
  Widget build(BuildContext context) {
    String name;
    String phone;
    String cdoctor;

//
//    void navigate(){
//      Navigator.of(context).pushNamed("/DoctorList");
//    }
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
                  onChanged: (val)=>name=val,
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
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val)=>val.length<10?'Enter a valid phone Number':null,
                  onChanged: (val)=>phone=val,
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
                SizedBox(height: 20.0,),

                TextFormField(
                  validator: (val)=>val.isEmpty?'Enter your doctor':null,
                  onChanged: (val)=>cdoctor=val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.add_alert),
                    labelText: 'CONSULTING DOCTOR',
                    labelStyle: TextStyle(
                      color:Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide:BorderSide(color:Colors.blue[300]),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
//                TextFormField(
//
//                  validator: (val)=>val.isEmpty?'Enter your problem':null,
//                  onChanged: (val)=>spec=val,
//                  decoration: InputDecoration(
//                    icon: Icon(Icons.plus_one),
//                    labelText: 'SPECIALIZATION',
//                    labelStyle: TextStyle(
//                      color:Colors.grey,
//                      fontWeight: FontWeight.bold,
//                    ),
//                    focusedBorder:UnderlineInputBorder(
//                      borderSide:BorderSide(color:Colors.blue[300]),
//                    ),
//                  ),
//                ),
//                SizedBox(height: 50.0,),
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
                        Map<String, String> patientDetails={'name':name, 'phone':phone, 'cdoctor':cdoctor};
                        c.addPatients(patientDetails).then((result){
                          print("Added");
//                          navigate();
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