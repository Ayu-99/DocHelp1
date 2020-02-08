import 'package:flutter/material.dart';
import 'package:shitf/Doctor/doctor.dart';
import 'package:shitf/Patient/all_patients_screen.dart';
import 'package:shitf/Patient/patient.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'doctorDetails.dart';

String nameDoctor;
String emailDoctor;
String photoUrlDoctor;


String uidOfDoctor;
FirebaseUser userDoctor;
class HomePageForDoctor extends StatefulWidget {
  _HomePageForDoctorState createState() => _HomePageForDoctorState();
}

class _HomePageForDoctorState extends State<HomePageForDoctor> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  doctorDetails1 _doctorDetails = doctorDetails1();
  DocumentReference _documentReference;

  var mapData = Map<String, String>();


  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
    await _signInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);

    AuthResult result = await _firebaseAuth.signInWithCredential(authCredential);

    FirebaseUser user = result.user;
    userDoctor=user;

    //FirebaseUser user = await _firebaseAuth.signInWithCredential(authCredential);
    return user;
  }

  void addDataToDb(FirebaseUser user) {
//    doctorDetails _doctorDetails = doctorDetails();

    _doctorDetails.name = user.displayName;
    _doctorDetails.emailId = user.email;
    _doctorDetails.photoUrl = user.photoUrl;
    _doctorDetails.uid = user.uid;
    nameDoctor=user.displayName;
    emailDoctor=user.email;
    photoUrlDoctor=user.photoUrl;

    mapData = _doctorDetails.toMap(_doctorDetails);

    print("NAme is : ${user.displayName}");
    print("EMail is: ${user.email}");
    print("Photourl is: ${user.photoUrl}");
    print("uid is: ${user.uid}");
    uidOfDoctor = user.uid;

    print("UID is $uidOfDoctor");
    print("MAP data is: $mapData");
    _documentReference = Firestore.instance.collection("Doctors").document(uidOfDoctor);

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => AllPatientScreen()));
      } else {
        _documentReference.setData(mapData).whenComplete(() {
          print("Users Colelction added to Database");
//          Navigator.pushReplacement(context,
//              new MaterialPageRoute(builder: (context) => AllPatientScreen()));
        }).catchError((e) {
          print("Error adHomding collection to Database $e");
        });
      }
    });

    Navigator.of(context).pushNamed("/DoctorDetails");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HR Connect'),
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome HR Connect',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
            ),
            RaisedButton(
              elevation: 8.0,
              padding: EdgeInsets.all(8.0),
              shape: StadiumBorder(),
              textColor: Colors.black,
              color: Colors.lime,
              child: Text('Sign In'),
              splashColor: Colors.red,
              onPressed: () {
                signIn().then((FirebaseUser user) {
                  addDataToDb(user);
                });
              },
            )
          ],
        ),

    );
  }
}
