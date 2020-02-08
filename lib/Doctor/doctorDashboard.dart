import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/crud.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
//import 'staffDetails.dart';

//StaffDetailsClass s=new StaffDetailsClass();
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
String currentProblem;

crudMethods c=new crudMethods();

String selectGender(){
  if(selectedValue==1){
    return 'Female';
  }else{
    return 'Male';
  }
}

String getProblem(){
  return currentProblem;
}





class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}


class _DoctorListState extends State<DoctorList> {

  Stream patients;

//  final CallService _service=locator<CallService>();

  @override
  void initState() {
    c.getPatientsList().then((results) {
      setState(() {
        patients = results;
      });
    });
    super.initState();
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

  Widget _listOfPatients() {
    if (patients != null) {
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
                        options(context);
//                      patientDetailsDialog(context, pname, pphone, pprob, pgender);
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
    } else {
      return Text("Loading.. Please Wait");
    }
  }
  void deletePatient(){

    c.deleteData(selectedDoc);
  }

  Future<bool> savePatient()async{
    Map<String, String> Patient={
      'name':patientName,
      'problem':patientProblem,
      'gender':selectGender(),
      'phone':patientPhone,
      'Time Arrived':_dateTime.toString(),
      'Time Departed':"",

    };

    await c.updatePatientInAllPatients(docRef.toString(), Patient);
    deletePatient();

  }

  Future<void> DeleteDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
//          title: Text('Do u want to save the Patient before deleting it?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do u want to save the Patient before deleting it?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                savePatient();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                deletePatient();

              },
            ),
          ],
        );
      },
    );
  }




  Future<bool> options(BuildContext context)async{
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Choose'),
            content:Container(
              height: 150.0,
              child: Column(
                children: <Widget>[

                  RaisedButton.icon(
                    onPressed: (){
                      Navigator.of(context).pop();
                      patientDetailsDialog(context, pname, pphone, pprob, pgender);
                    },
                    icon: Icon(Icons.person),
                    label: Text('View Patient Profile'),
                  ),
                  SizedBox(height: 15.0,),

                  RaisedButton.icon(
                    onPressed: (){
                      Navigator.of(context).pop();
//                      deletePatient();
                      DeleteDialog(context);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Delete Patient'),
                  ),


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

  Future<bool> patientDetailsDialog(BuildContext context, String pname,
      String pphone, String pprob, String pgender) async {
    String phoneNumber = pphone;
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Patient Details'),
            content: Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Text("Patient's Name: " + pname),
                  SizedBox(height: 5.0,),
                  Text("Patient's Gender: " + pgender),
                  SizedBox(height: 5.0,),
                  Text("Patient's Phone: " + pphone),
                  SizedBox(height: 5.0,),
                  Text("Patient's Problem: " + pprob),
                  SizedBox(height: 10.0,),


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                textColor: Colors.cyan,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }

    );
  }


}