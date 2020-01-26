import 'package:flutter/material.dart';
import 'package:shitf/crud.dart';


crudMethods c=new crudMethods();
class ProblemSpecificAllPatientsList extends StatefulWidget {
  @override
  _ProblemSpecificAllPatientsListState createState() => _ProblemSpecificAllPatientsListState();
}

String pname;
String pprob;
String pphone;
String pgender;



class _ProblemSpecificAllPatientsListState extends State<ProblemSpecificAllPatientsList> {

  Stream patients;

  @override
  void initState() {
    c.getPatientsWithSpecificProblem().then((results) {
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
        title: Text("Patient's with Problem $problem"),
      ),

      body: _listOfPatientsWithSpecifiProblem(),
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


  Widget _listOfPatientsWithSpecifiProblem() {
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
//                        selectedDoc = snapshot.data.documents[i].documentID;
                        patientDetailsDialog(context, pname, pphone, pprob, pgender);
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


}

