import 'package:shitf/displayingPatient.dart';
import 'package:shitf/PatientDetails.dart';
import 'package:shitf/Staff/AllPatientsWithSpecificProblem.dart';
import 'package:shitf/Staff/PatientsList.dart';
import 'package:shitf/Staff/PatientsWithSpecificProblem.dart';
import 'package:shitf/Staff/SearchPatient.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/Staff/staffDetails.dart';
import 'package:shitf/doctorDashboard.dart';
import 'package:shitf/doctorDetails.dart';
import 'package:shitf/homePage.dart';
import 'package:shitf/logInPhone.dart';
import 'package:shitf/navigationDrawer.dart';
import 'package:shitf/newPage.dart';
import 'package:shitf/signIn.dart';
import 'package:shitf/signUp.dart';
import 'package:flutter/material.dart';
// import 'package:attempt/signIn.dart';
// import 'auth.dart';

void main(){
  set();
  runApp(new MyApp());

}
class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
       theme: new ThemeData(
         primarySwatch: Colors.blue,
       ),

      // navigatorObservers: <NavigatorObserver>[observer],
      // home: new WallScreen(analytics: analytics, observer: observer),
      // home: new CrudSample(),
      home:MyHomePage(),
      // home:DoctorDetails(),

      routes: <String, WidgetBuilder>{
        "/Register":(BuildContext  context) => new Register(),
        "/Login":(BuildContext context) => new MyHomePage(),
        "/LoginPhone":(BuildContext context)=>new LoginPhone(),
        "/HomePage":(BuildContext context)=>new Home(),
        "/DoctorDetails":(BuildContext context)=>new DoctorDetails(),
        "/DoctorDashboard":(BuildContext context)=>new DoctorList(),
        "/NewPage":(BuildContext context)=>new NewPage(),
        "/PatientDetails":(BuildContext context)=>new PatientDetails(),
        "/StaffDetails":(BuildContext context)=> new StaffDetails(),
        "/PatientsList":(BuildContext context)=> new PatientsList(),
        "/ProblemSpecificPatientsList":(BuildContext context)=>new ProblemSpecificPatientsList(),
        "/AllPatientsTillDate":(BuildContext context)=>new AllPatientsTillDate(),
        "/ProblemSpecificAllPatientsList":(BuildContext context)=> new ProblemSpecificAllPatientsList(),
        "/SearchPatientsByName":(BuildContext context)=>new SearchPatient(),
        "/DisplayingSinglePatient":(BuildContext context)=>new DisplaySinglePatient(),
      },
    );
  }
}