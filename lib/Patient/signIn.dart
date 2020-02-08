import 'package:shitf/Patient/all_patients_screen.dart';
import 'package:shitf/Patient/patient.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  DocumentReference _documentReference;
  patientDetails _patientDetails = patientDetails();
  var mapData = Map<String, String>();
  String uid;

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
    await _signInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);

    AuthResult result = await _firebaseAuth.signInWithCredential(authCredential);

    FirebaseUser user = result.user;

    //FirebaseUser user = await _firebaseAuth.signInWithCredential(authCredential);
    return user;
  }

  void addDataToDb(FirebaseUser user) {
    _patientDetails.name = user.displayName;
    _patientDetails.emailId = user.email;
    _patientDetails.photoUrl = user.photoUrl;
    _patientDetails.uid = user.uid;
    mapData = _patientDetails.toMap(_patientDetails);

    print("NAme is : ${user.displayName}");
    print("EMail is: ${user.email}");
    print("Photourl is: ${user.photoUrl}");
    print("uid is: ${user.uid}");
    uid = user.uid;

    print("UID is $uid");
    print("MAP data is: $mapData");
    _documentReference = Firestore.instance.collection("Online Consulting patients").document(uid);

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => AllPatientScreen()));
      } else {
        _documentReference.setData(mapData).whenComplete(() {
          print("Users Colelction added to Database");
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => AllPatientScreen()));
        }).catchError((e) {
          print("Error adHomding collection to Database $e");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HR Connect'),
      ),
      body: Center(
        child: Column(
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
      ),
    );
  }
}
