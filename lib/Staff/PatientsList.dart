import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/crud.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'staffDetails.dart';
import 'package:shitf/searchService.dart';

StaffDetailsClass s=new StaffDetailsClass();


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


String pname;
String pprob;
String pphone;
String pgender;
String problem="";
String currentProblem="";
String staffName=s.getStaffName();
String staffEmail=s.getStaffEmail();
String specialPhone;
crudMethods c=new crudMethods();

String selectGender(){
  if(selectedValue==1){
    return 'Female';
  }else{
    return 'Male';
  }
}



String getProblem(){

  return problem;;
}

String getPhone(){
  return specialPhone;
}



class CallService{
  void _launchCaller(String number) async{
    var url="tel:${number.toString()}";
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not place a call';
    }

  }
}

GetIt locator=GetIt();

void set(){
  locator.registerSingleton(CallService());
}


class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}


class _PatientsListState extends State<PatientsList> {

  Stream patients;
  final CallService _service=locator<CallService>();


  @override
  void initState() {
    c.getPatientsList().then((results) {
      setState(() {
        patients = results;

      });
    });
    super.initState();
  }

  void deletePatient(){

    c.deleteData(selectedDoc);
  }

  Future<bool> specifiProblemDialog(BuildContext context){

//  int selectedValue=0;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),

            content:Container(
              padding: EdgeInsets.all(5.0),
              height: 150.0,
              child: Column(


                children: <Widget>[


                  Text(
                    "Enter the Problem",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,

                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(

                    decoration: InputDecoration(
                      hintText: 'Enter problem',
                    ),
                    onChanged: (val){
                      final problem=val;
                      print("!!!!!!!!!!111");
                      print("Problem is: "+problem);
                      print("!!!!!!!!!!111");
                    },
                  ),
                  SizedBox(height:20.0),

                ],
              ),

            ),
            actions: <Widget>[
              SizedBox(height: 20.0,),
              FlatButton(
                child: Text("Display"),
                color: Colors.cyan[200],
                textColor: Colors.white,
                onPressed: (){
//                      print(selectedValue);
                  Navigator.of(context).pop();
//                  specifiProblemDialog2(context);
                  getProblem();
                Navigator.of(context).pushNamed("/ProblemSpecificPatientsList");


                },

              ),
            ],
          );
        }
    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Text("Patient's List"),
        backgroundColor: Colors.cyan[600],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add),
            label:Text("Add"),
            onPressed: (){
              addDialog(context);
            },
          ),

          FlatButton(
            child:Icon(Icons.refresh),
//            label: Text("Refresh"),
            onPressed: (){
              c.getPatientsList().then((results) {
                setState(() {
                  patients = results;

                });
              });
            },
          )
        ],
      ),
      drawer: Drawer(

        child:ListView(
          children: <Widget>[

            UserAccountsDrawerHeader(
              accountName: Text(staffName),
              accountEmail: Text(staffEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyan[100],
                child:Text(staffName[0].toUpperCase()),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child:Text(staffName[staffName.length-1].toUpperCase()),
                ),
              ],
            ),
            ListTile(


              title: Text("Patients Having a specific Problem"),
              trailing: Icon(Icons.arrow_upward),
              subtitle: Text("All Patients"),
              leading: Icon(Icons.person),
              isThreeLine: true,
              onTap: (){
                Navigator.of(context).pop();
                specifiProblemDialog(context);
              },
            ),
            ListTile(
              title: Text("See All Patients Till Date"),
              trailing: Icon(Icons.arrow_upward),
              subtitle: Text("All Patients"),
              leading: Icon(Icons.person),
              onTap: (){
                Navigator.of(context).pushNamed("/AllPatientsTillDate");
              },
            ),
            ListTile(
              title: Text("Search Patients by name"),
              trailing: Icon(Icons.search),
              subtitle: Text("Waiting Patients"),
              leading: Icon(Icons.person),
              isThreeLine: true,
              onTap: (){
                Navigator.of(context).pushNamed("/SearchPatientsByName");
              },
            ),
            new Divider(),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: ()=>Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.close),
              onTap: ()=>Navigator.of(context).pop(),
            ),
          ],
        ),
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
                    elevation: 5.0,
                      child: ListTile(
                        onTap: () {
                          pname = snapshot.data.documents[i].data['name'];
                          pphone = snapshot.data.documents[i].data['phone'];
                          pprob = snapshot.data.documents[i].data['problem'];
                          pgender = snapshot.data.documents[i].data['gender'];
                          selectedDoc = snapshot.data.documents[i].documentID;
                          specialPhone=pphone;
                          options(context);

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
  Future<bool> dialogTrigger(BuildContext context)async{
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Job Done'),
            content: Text("Patient Added !!!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Alright"),
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

  Future<bool> patientDetailsDialog(BuildContext context, String pname, String pphone, String pprob, String pgender)async{
    String phoneNumber=pphone;
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Patient Details'),
            content:Container(
              height: 200.0,
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

                  RaisedButton.icon(
                      onPressed: (){
                        _service._launchCaller(phoneNumber);
                      },
                      icon: Icon(Icons.phone),
                    label: Text('Call Patient'),
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


  Future<bool> savePatient()async{
    Map<String, String> Patient={
      'name':patientName,
      'problem':patientProblem,
      'gender':selectGender(),
      'phone':patientPhone,
//      'Time Arrived':_dateTime.toString(),
      'Time Departed':_dateTime.toString(),

    };
    print("((((((((((((((((((((((");
    c.getDocumentId();
    print("((((((((((((((((((((((");

    print("*****************************");
    print(docRef.toString());
    print("*****************************");
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
              height: 200.0,
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
                      UpdateDialog(context, selectedDoc);
                    },
                    icon: Icon(Icons.update),
                    label: Text('Update Patient Profile'),
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

  Future<bool> addDialog(BuildContext context){

//  int selectedValue=0;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),

            content:Container(
              padding: EdgeInsets.all(5.0),
              height: 350.0,
              child: Column(


                children: <Widget>[


                  Text("Add Patient",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height:5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient name',
                    ),
                    onChanged: (val){
                      patientName=val;
                    },
                  ),
                  SizedBox(height: 2.0,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient problem',
                    ),
                    onChanged: (val){
                      patientProblem=val;
                    },
                  ),

                  SizedBox(height: 2.0,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient phone',
                    ),
                    onChanged: (val){
                      patientPhone=val;
                    },
                  ),

                  SizedBox(height: 2.0,),
                  Text("Chooose gender"),
                  SizedBox(height: 1.0,),
                  Text("Female"),
//                  SizedBox(width:5.0),
                  Radio(
                    value:1,
                    groupValue: selectedValue,
                    activeColor: Colors.cyan,
                    onChanged: (val){
                      selectedValue=1;
                    },

                  ),

//                  SizedBox(height: 2.0,),
                  Text("Male"),
//                  SizedBox(width:5.0),
                  Radio(
                    value:2,
                    groupValue: selectedValue,
                    activeColor: Colors.cyan,
                    onChanged: (val){
                      selectedValue=2;
                    },
                  ),


                ],


              ),



            ),

            actions: <Widget>[
              SizedBox(height: 20.0,),
              FlatButton(
                child: Text("Add"),
                color: Colors.cyan[200],
                textColor: Colors.white,
                onPressed: (){
//                      print(selectedValue);
                  Navigator.of(context).pop();
                  Map<String, String> Patient={
                    'name':patientName,
                    'problem':patientProblem,
                    'gender':selectGender(),
                    'phone':patientPhone,
                    'Time Arrived':DateTime.now().toString(),
                    'searchKey':patientName[0].toUpperCase(),


                  };
                  c.AddAllPatientsTillDate(Patient);
//                  final docRef = Firestore.instance.collection('All Patients').add({
//                    'name':patientName,
//                    'problem':patientProblem,
//                    'gender':selectGender(),
//                    'phone':patientPhone,
//                    'Time Arrived':_dateTime.toString(),
//                    'Time Departed':"",
//                  });

                  Map<String, String> waitingPatient={
                    'name':patientName,
                    'problem':patientProblem,
                    'gender':selectGender(),
                    'phone':patientPhone,
                    'Date Time Arrived':DateTime.now().toString(),
                    'Time':TimeOfDay.now().toString(),
                    'searchKey':patientName[0].toUpperCase(),

                  };
                  c.waitingPatients(waitingPatient).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print("&&&&&&&&&&&&&&&&");
                    print("Error in dialog"+e);
                    print("&&&&&&&&&&&&&&&&");
                  });


                },

              ),
            ],
          );
        }
    );

  }

  Future<bool> UpdateDialog(BuildContext context, selectedDoc){

//  int selectedValue=0;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0))),

            content:Container(
              padding: EdgeInsets.all(5.0),
              height: 350.0,
              child: Column(


                children: <Widget>[


                  Text("Update Patient",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height:5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient name',
                    ),
                    onChanged: (val){
                      patientName=val;
                    },
                  ),
                  SizedBox(height: 2.0,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient problem',
                    ),
                    onChanged: (val){
                      patientProblem=val;
                    },
                  ),

                  SizedBox(height: 2.0,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter patient phone',
                    ),
                    onChanged: (val){
                      patientPhone=val;
                    },
                  ),

                  SizedBox(height: 2.0,),
                  Text("Chooose gender"),
                  SizedBox(height: 1.0,),
                  Text("Female"),
//                  SizedBox(width:5.0),
                  Radio(
                    value:1,
                    groupValue: selectedValue,
                    activeColor: Colors.cyan,
                    onChanged: (val){
                      selectedValue=1;
                    },

                  ),

//                  SizedBox(height: 2.0,),
                  Text("Male"),
//                  SizedBox(width:5.0),
                  Radio(
                    value:2,
                    groupValue: selectedValue,
                    activeColor: Colors.cyan,
                    onChanged: (val){
                      selectedValue=2;
                    },
                  ),


                ],


              ),



            ),
            actions: <Widget>[
              SizedBox(height: 20.0,),
              FlatButton(
                child: Text("Update"),
                color: Colors.cyan[200],
                textColor: Colors.white,
                onPressed: (){
//                      print(selectedValue);
                  Navigator.of(context).pop();
                  Map<String, String> waitingPatient={
                    'name':patientName,
                    'problem':patientProblem,
                    'gender':selectGender(),
                    'phone': patientPhone,
                  };
                  c.updateData(selectedDoc,waitingPatient).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print("AAAAAAAAAAAAAAAAAAAa");
                    print("Error in dialog"+e);
                    print("AAAAAAAAAAAAAAAAAAAa");
                  });

                },

              ),
            ],
          );
        }
    );

  }


}
