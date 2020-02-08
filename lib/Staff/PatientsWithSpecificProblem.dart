import 'package:flutter/material.dart';
import 'package:shitf/crud.dart';
import 'package:shitf/crud.dart' as prefix0;
import 'package:shitf/Doctor/doctorDashboard.dart';


crudMethods c=new crudMethods();
class ProblemSpecificPatientsList extends StatefulWidget {
  @override
  _ProblemSpecificPatientsListState createState() => _ProblemSpecificPatientsListState();
}

String pname;
String pprob;
String pphone;
String pgender;
String problem=getProblem();



class _ProblemSpecificPatientsListState extends State<ProblemSpecificPatientsList> {

  Stream patientsSpecific;

  @override
  void initState() {
    c.getPatientsWithSpecificProblem().then((results) {
      setState(() {
        print(results);
        patientsSpecific = results;
        print(patientsSpecific);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient's with Problem:$problem"),
      ),

      body: _listOfPatientsWithSpecificProblem(),
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


  Widget _listOfPatientsWithSpecificProblem() {
    print("Hi Hello");
    if (patientsSpecific != null) {
      return StreamBuilder(
          stream: patientsSpecific,
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

