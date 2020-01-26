import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Dashboard"),
        elevation: debugDefaultTargetPlatformOverride==TargetPlatform.android?5.0:0.0,

      ),

      drawer: Drawer(
        child:ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Ayushi Sharma"),
              accountEmail: Text("ayushisharma5141@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyan[100],
                child:Text("P"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child:Text("S"),
                ),
              ],
            ),
            ListTile(
              title: Text("Page One"),
              trailing: Icon(Icons.arrow_upward),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/NewPage");
              },
            ),
            ListTile(
              title: Text("Page Two"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new Divider(),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: ()=>Navigator.of(context).pop(),
            ),
          ],
        ),
      ),


      body: new Container(
        child:Center(
          child:Text("Dashboard"),
        ),
      ),
    );
  }
}
