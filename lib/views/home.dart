import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:solens/initials/appbar.dart';
import 'package:solens/initials/bottomnav.dart';

import '../constants/appbarChoice.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Choice _selectedChoice;

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Scaffold(
          appBar: AppBarMain(_select, choices),
         body: Container(),
         floatingActionButton: FloatingActionButton(
             child: Icon(Icons.home, color: Colors.black, size: 30),
             backgroundColor: Colors.deepOrangeAccent,
             tooltip: 'Increment',
             elevation: 2.0,
             onPressed: null),
         bottomNavigationBar: bottomNavBar(context),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       ),
    );
  }
}
