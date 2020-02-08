import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shitf/Patient/PatientDetails.dart';

import 'package:shitf/Staff/PatientsList.dart';
import 'package:shitf/Doctor/doctorDashboard.dart' as prefix0;

//PatientsList p=new PatientsList();
String problem=getProblem();
String phone=getPhone();
DocumentReference docRef;
String id;
class crudMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser()!=null){
      return true;

    }else{
      return false;
    }
  }

  Future<void> AddAllPatientsTillDate(patientDetails) async{
//    if(isLoggedIn()){
    docRef=await Firestore.instance.collection("All Patients").add(patientDetails).catchError((e) {
      print(e);
    });
//    }else{
//      print("You need to be logged in!!!!");
//    }
//  }
  }



   sendPasswordResetLink(String email) async{
    return _auth.sendPasswordResetEmail(email: email);
  }
  Future<void> addData(doctorDetails) {
//    if(isLoggedIn()){
    Firestore.instance.collection("Doctors").add(doctorDetails).catchError((e) {
      print(e);
    });
//    }else{
//      print("You need to be logged in!!!!");
//    }
//  }
  }

  Future<void> addPatients(PatientDetails) {
//    if(isLoggedIn()){
    Firestore.instance.collection("Patients").add(PatientDetails).catchError((e) {
      print(e);
    });

//    }else{
//      print("You need to be logged in!!!!");
//    }
//  }
  }
  Future<bool> addStaff(StaffDetails) async{
//    if(isLoggedIn()){
    Firestore.instance.collection("Staff").add(StaffDetails).then((val){
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
//    }else{
//      print("You need to be logged in!!!!");
//    }
//  }
  }

   getPatient()async{
    Firestore.instance.collection("All Patients").where('name', isEqualTo: pname).snapshots();
  }



  Future<bool> waitingPatients(PatientDetails) {
//    if(isLoggedIn()){
    Firestore.instance.collection("Waiting Patients").add(PatientDetails).then((val){
      return true;
    }).catchError((e) {
      print("Error in crud file" +e);
      return false;
    });
//    }else{
//      print("You need to be logged in!!!!");
//    }
//  }
  }

  getPatientsList() async{
    return await Firestore.instance.collection("Waiting Patients").orderBy('Time', descending:false).snapshots();
  }

  getAllPatients() async{
    return await Firestore.instance.collection("All Patients").snapshots();

  }

  getAllPatientsWithSpecificProblem() async{
    return await Firestore.instance.collection("All Patients").where('problem', isEqualTo: problem).snapshots();

  }


  getData() async{
    return await Firestore.instance.collection("Doctors").snapshots();
  }

  updateData(selectedDoc, newValues){
    Firestore.instance.collection("Waiting Patients").document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }

  updatePatientInAllPatients(selectedDoc, newValues){
    Firestore.instance.collection("All Patients").document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }

  updateDoctor(selectedDoc, newValues){
    Firestore.instance.collection("Doctors").document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }




  deleteData(docId){
    print(docId);
    Firestore.instance.collection('Waiting Patients').document(docId)
        .delete().catchError((e){
          print(e);
    });
  }

  getPatientsWithSpecificProblem()async{
    return  Firestore.instance.collection("Waiting Patients").where('problem', isEqualTo: problem).snapshots();
  }

  getDocumentId()async{
    print("--------------");
    print(Firestore.instance.collection("All Patients").where('phone', isEqualTo: phone).snapshots().forEach((response){

    }));
    print("--------------");
  }



}