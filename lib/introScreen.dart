import 'package:flutter/material.dart';
import 'package:shitf/utils/my_navigator.dart';
import 'package:shitf/Widgets/walkthrough.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == 3) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF448AFF),
      padding: EdgeInsets.all(10.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                Walkthrough(
                  title: "WELCOME",
                  content: "DocHelp is a medium through which patients and doctors can both save their time",
                  imageIcon:Icons.local_pharmacy,
                ),
                Walkthrough(
                  title: "MANAGE PATIENTS",
                  content: "Manage patients in the first come first order \n With best app",
                  imageIcon: Icons.list,

                ),
                Walkthrough(
                  title: "FOR DOCTOR,STAFF & PATIENT USE",
                  content:"Everyone can use this app \n be it doctor, patient or staff",
                  imageIcon: Icons.star,

                ),
                Walkthrough(
                  title:"TIME AND EFFORT FRIENDLY",
                  content: "We Will manage your patients\n and make it easy for you",
                  imageIcon: Icons.check,

                ),
              ],
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(lastPage ? "" : "SKIP",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () =>
                  lastPage ? null : MyNavigator.goToHome(context),
                ),
                FlatButton(
                  child: Text(lastPage ? "GOT IT": "NEXT",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? MyNavigator.goToHome(context)
                      : controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}