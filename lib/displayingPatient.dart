import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/crud.dart';
import 'package:shitf/searchService.dart';
import 'dart:async';

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

SearchService s=new SearchService();

String selectGender(){
  if(selectedValue==1){
    return 'Female';
  }else{
    return 'Male';
  }
}




class DisplaySinglePatient extends StatefulWidget {
  @override
  _DisplaySinglePatientState createState() => _DisplaySinglePatientState();
}


class _DisplaySinglePatientState extends State<DisplaySinglePatient> {

  Stream patients;

  @override
  void initState() {
    s.getSpecificPatient().then((results) {
      setState(() {
        patients = results;
        if(patients==null){
          print("Siyappa");
        }

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

