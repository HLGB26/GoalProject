import 'package:flutter/material.dart';
import 'package:solens/views/signin.dart';
import 'package:solens/views/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    showSignIn = !showSignIn;
    setState((){}); 
 }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView);
    }else{
      return SignUp(toggleView);
    }
  }
}
