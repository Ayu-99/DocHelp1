import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'chat_screen.dart';
import 'package:shitf/main.dart';
String doc;
bool showDustbin=false;

class AllPatientScreen extends StatefulWidget {
  @override
  _AllPatientScreenState createState() => _AllPatientScreenState();
}

class _AllPatientScreenState extends State<AllPatientScreen> {

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> userList;
  final CollectionReference _collectionReference =
  Firestore.instance.collection("Online Consulting patients");

  deleteData(docId){
    print(docId);
    Firestore.instance.collection('Online Consulting patients').document(docId)
        .delete().catchError((e){
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription=_collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        userList=datasnapshot.documents;
        print("Patients List ${userList.length}");
      });

    });
  }
  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Patients"),
          actions: <Widget>[
//            Dustbin(),
//            SizedBox(width: 5.0,),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: ()async{
                await firebaseAuth.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                print("Signed out");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
              },



            )
          ],
        ),
        body:userList!=null?Container(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: ((context, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].data['photoUrl'],

                  ),
                ),
                title: Text(userList[index].data['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(userList[index].data['emailId'],
                    style: TextStyle(
                      color: Colors.grey,
                    )),

                onLongPress: (){
                  doc=userList[index].data['uid'];
//                  showDustbin=true;
                dialogTrigger(context);
                },
                onTap: ((){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              name: userList[index].data['name'],
                              photoUrl: userList[index].data['photoUrl'],
                              receiverUid:
                              userList[index].data['uid'])));
                }),

              );

            }),
          ),
        ):Center(
          child: CircularProgressIndicator(),
        )

    );
  }

  Future<bool> dialogTrigger(BuildContext context)async{
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Delete Patient ?'),
            content: Text("Do u want to delete patient ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                textColor: Colors.cyan,
                onPressed: (){
                  Navigator.of(context).pop();
                  deleteData(doc);
                },
              ),
              FlatButton(
                child: Text("No"),
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
  Widget Dustbin(){
    if(showDustbin==true){
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: ()async{

        },
      );
    }else{
      IconButton(
        icon: Icon(Icons.check),
        onPressed: ()async{
          deleteData(doc);
        },
      );
    }
  }
}



