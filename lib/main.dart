import 'dart:async';

import 'package:shitf/Doctor/doctorSignIn.dart';
import 'package:shitf/Patient/all_patients_screen.dart';
import 'package:shitf/Patient/signIn.dart';
import 'package:shitf/PaymentHomePage.dart';
import 'package:shitf/ResetPassword.dart';
import 'package:shitf/displayingPatient.dart';
import 'package:shitf/Patient/PatientDetails.dart';
import 'package:shitf/Staff/AllPatientsWithSpecificProblem.dart';
import 'package:shitf/Staff/PatientsList.dart';
import 'package:shitf/Staff/PatientsWithSpecificProblem.dart';
import 'package:shitf/Staff/SearchPatient.dart';
import 'package:shitf/Staff/allPatientsTillDate.dart';
import 'package:shitf/Staff/staffDetails.dart';
import 'package:shitf/Doctor/doctorDashboard.dart';
import 'package:shitf/Doctor/doctorDetails.dart';
import 'package:shitf/homePage.dart';
import 'package:shitf/home_screen.dart';
import 'package:shitf/introScreen.dart';
import 'package:shitf/logInPhone.dart';
import 'package:shitf/mapping.dart';
import 'package:shitf/navigationDrawer.dart';
import 'package:shitf/newPage.dart';
import 'package:shitf/signIn.dart';
import 'package:shitf/signUp.dart';
import 'package:flutter/material.dart';
import 'package:shitf/splash_screen.dart';
import 'services/authentication.dart';
//import 'mapping.dart';
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
      home:PaymentHomePage(),
      // home:DoctorDetails(),

      routes: <String, WidgetBuilder>{
//        "/home": (BuildContext context) => HomeScreen(),
        "/intro": (BuildContext context) => IntroScreen(),
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
        "/ResetPassword":(BuildContext context)=>new ResetPassword(),
        "/mapping":(BuildContext context)=>new MappingPage(auth:Auth()),
        "/AllOnlineConsultationPatients":(BuildContext context)=>AllPatientScreen(),
      },
    );
  }
}
//
//
//class SplashScreen extends StatefulWidget {
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Timer(Duration(seconds: 5), (){
//      Navigator.of(context).pushNamed("/Register");
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        fit: StackFit.expand,
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              color: Colors.blueAccent,
//            ),
//
//          ),
//          Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Expanded(
//                flex: 2,
//                child: Container(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      CircleAvatar(
//                        backgroundColor: Colors.white,
//                        radius: 50.0,
//                        child:Icon(
//                            Icons.healing,
//                        color:Colors.blueAccent,
//                          size: 50.0,
//
//                        ),
//                      ),
//                      Padding(padding: EdgeInsets.only(top:10.0),),
//                      Text("DocHelp",
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 24.0,
//                        fontWeight: FontWeight.bold,
//
//                      ),)
//                    ],
//                  ),
//                ),
//              ),
//
//              Expanded(
//                flex: 1,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    CircularProgressIndicator(backgroundColor: Colors.white,),
//                    Padding(padding: EdgeInsets.only(top: 20.0),),
//
//                    Text("Be first, get \ntreated first!!",
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 18.0,
//                      fontWeight:FontWeight.bold,
//                    ),),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
