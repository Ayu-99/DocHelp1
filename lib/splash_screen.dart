import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shitf/utils/my_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToMapping(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child:Icon(
                          Icons.healing,
                          color:Colors.blueAccent,
                          size: 50.0,

                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top:10.0),),
                      Text("DocHelp",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,

                        ),)
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.white,),
                    Padding(padding: EdgeInsets.only(top: 20.0),),

                    Text("Be first, get \ntreated first!!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight:FontWeight.bold,
                      ),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}