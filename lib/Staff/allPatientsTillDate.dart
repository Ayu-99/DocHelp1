import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/crud.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'staffDetails.dart';

StaffDetailsClass s=new StaffDetailsClass();
//String staffName=s.getStaffName();
//String staffPhone=s.getStaffPhone();

DocumentReference documentReference;
DateTime _dateTime;
DateTime _dateTimeDeparted=DateTime.now();
TimeOfDay _time;

final int docRef=0;
int selectedValue=0;
String patientName="Patient";
String patientProblem="Patient Problem";
String patientPhone="hhhh";
String selectedDoc;
String staffEmail="example.com";
String staffName="Jennie";

String pname;
String pprob;
String pphone;
String pgender;
String problem;

crudMethods c=new crudMethods();

String selectGender(){
  if(selectedValue==1){
    return 'Female';
  }else{
    return 'Male';
  }
}




class AllPatientsTillDate extends StatefulWidget {
  @override
  _AllPatientsTillDateState createState() => _AllPatientsTillDateState();
}


class _AllPatientsTillDateState extends State<AllPatientsTillDate> {

  Stream patients;

  @override
  void initState() {
    c.getAllPatients().then((results) {
      setState(() {
        patients = results;

      });
    });
    super.initState();
  }

  void deletePatient(){

    c.deleteData(selectedDoc);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient's List"),
        backgroundColor: Colors.cyan[300],

      ),



      body: _listOfPatients(),


    );
  }

  Widget _listOfPatients(){
    if(patients!=null) {
      return StreamBuilder(
          stream: patients,
          builder: (context, snapshot) {
            return ListView.builder(

                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        pname = snapshot.data.documents[i].data['name'];
                        pphone = snapshot.data.documents[i].data['phone'];
                        pprob = snapshot.data.documents[i].data['problem'];
                        pgender = snapshot.data.documents[i].data['gender'];
                        selectedDoc = snapshot.data.documents[i].documentID;
                        patientDetailsDialog(context, pname, pphone, pprob, pgender);
//                        options(context);

                      },
                      title: Text(snapshot.data.documents[i].data['name']),
                      subtitle: Text(
                          snapshot.data.documents[i].data['problem']),
                      leading: Icon(Icons.person),


                    ),
                  );


                }
            );
          }

      );
    }else{
      return Text("Loading.. Please Wait");
    }

  }


  Future<bool> patientDetailsDialog(BuildContext context, String pname, String pphone, String pprob, String pgender)async{
    String phoneNumber=pphone;
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Patient Details'),
            content:Container(
              height: 150.0,
              child: Column(
                children: <Widget>[
                  Text("Patient's Name: "+ pname),
                  SizedBox(height: 5.0,),
                  Text("Patient's Gender: "+ pgender),
                  SizedBox(height: 5.0,),
                  Text("Patient's Phone: "+ pphone),
                  SizedBox(height: 5.0,),
                  Text("Patient's Problem: "+ pprob),
                  SizedBox(height: 10.0,),


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                textColor: Colors.cyan,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }

    );
  }








  }




//import 'package:flutter/material.dart';
//import 'package:shitf/crud.dart';
//
//String pname;
//String pprob;
//String pphone;
//String pgender;
//String problem;
//
//String selectedDoc1="";
//
//crudMethods c=new crudMethods();
//class AllPatientsTillDate extends StatefulWidget {
//  @override
//  _AllPatientsTillDateState createState() => _AllPatientsTillDateState();
//}
//
//class _AllPatientsTillDateState extends State<AllPatientsTillDate> {
//  Stream patients;
//
//  @override
//  void initState() {
//    c.getAllPatients().then((results) {
//      setState(() {
//        patients = results;
//
//      });
//    });
//    super.initState();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      appBar: AppBar(
//        title: Text("Patient's till date"),
//      ),
//      body:allPatientsList(),
//
//    );
//  }
//
//  Future<bool> patientDetailsDialog(BuildContext context, String pname, String pphone, String pprob, String pgender)async{
//    String phoneNumber=pphone;
//    return showDialog(
//        barrierDismissible: true,
//        context: context,
//        builder: (BuildContext context){
//          return AlertDialog(
//            title: Text('Patient Details'),
//            content:Container(
//              height: 200.0,
//              child: Column(
//                children: <Widget>[
//                  Text("Patient's Name: "+ pname),
//                  SizedBox(height: 5.0,),
//                  Text("Patient's Gender: "+ pgender),
//                  SizedBox(height: 5.0,),
//                  Text("Patient's Phone: "+ pphone),
//                  SizedBox(height: 5.0,),
//                  Text("Patient's Problem: "+ pprob),
//                  SizedBox(height: 10.0,),
//
//                ],
//              ),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("Close"),
//                textColor: Colors.cyan,
//                onPressed: (){
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        }
//
//    );
//  }
//
//
//  Widget allPatientsList(){
//    if(patients!=null) {
//      return StreamBuilder(
//          stream: patients,
//          builder: (context, snapshot) {
//            return ListView.builder(
//                itemCount: snapshot.data.documents.length,
//                padding: EdgeInsets.all(5.0),
//                itemBuilder: (context, i) {
//                  return Card(
//                    child: ListTile(
//                      onTap: () {
//                        final pname = snapshot.data.documents[i].data['name'];
//                        final pphone = snapshot.data.documents[i].data['phone'];
//                        final pprob = snapshot.data.documents[i].data['problem'];
//                        final pgender = snapshot.data.documents[i].data['gender'];
//                        final selectedDoc1= snapshot.data.documents[i].documentID;
//                        patientDetailsDialog(context, pname, pphone, problem, pgender);
////                        options(context);
//                      },
//                      title: Text(snapshot.data.documents[i].data['name']),
//                      subtitle: Text(
//                          snapshot.data.documents[i].data['problem']),
//                      leading: Icon(Icons.person),
//
//
//                    ),
//                  );
//                }
//            );
//          }
//
//      );
//    }else{
//      return Text("Loading.. Please Wait");
//    }
//
//  }
//  }
//
