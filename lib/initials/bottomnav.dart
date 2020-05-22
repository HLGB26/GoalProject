import 'package:flutter/material.dart';

Widget bottomNavBar(context){
  return  BottomAppBar(
    color: Colors.blueAccent,
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: IconButton(
            icon: Icon(Icons.all_out, color: Colors.black, size: 25),
            onPressed: null,
          ),
        ),Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          margin: EdgeInsets.only(right:15),
          child: IconButton(
            icon: Icon(Icons.all_out, color: Colors.black, size: 25),
            onPressed: null,
          ),
        ),Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          margin: EdgeInsets.only(left: 15),
          child: IconButton(
            icon: Icon(Icons.all_out, color: Colors.black, size: 25),
            onPressed: null,
          ),
        ),Container(
          padding: EdgeInsets.only(left:12.0, right: 12.0),
          child: IconButton(
            icon: Icon(Icons.all_out, color: Colors.black, size: 25),
            onPressed: null,
          ),
        ),
      ],
    ),
  );
}