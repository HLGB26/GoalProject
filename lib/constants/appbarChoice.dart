import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Chat', icon: Icons.chat),
  const Choice(title: 'Profile', icon: Icons.account_circle),
  const Choice(title: 'Settings',icon: Icons.settings),
  const Choice(title: 'Logout',icon: Icons.exit_to_app),
];

InputDecoration textfieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
  );
}

TextStyle fieldStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 16
  );
}

TextStyle clickStyle() {
  return TextStyle(color: Colors.white,
      fontSize: 17
  );
}