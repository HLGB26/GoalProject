import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:solens/services/auth.dart';
import 'package:solens/services/database.dart';
import 'package:solens/helper/helperFunction.dart';
import 'package:solens/constants/appbarChoice.dart';

class SignIn extends StatefulWidget{
    final Function toggle;
    SignIn(this.toggle);

    @override
   _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods databaseMethod =new DataBaseMethods();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() async {
        await authMethods
            .signInwithEmailAndPassword(
            emailController.text, passwordController.text)
            .then((result) async {
          if (result != null)  {
            QuerySnapshot userInfoSnapshot =
            await databaseMethod.getUsersByEmail(emailController.text);

            HelperFunction.saveUserLoggedInSharedPreference(true);
            HelperFunction.saveUserNameSharedPreference(
                userInfoSnapshot.documents[0].data["userName"]);
            HelperFunction.saveUserEmailSharedPreference(
                userInfoSnapshot.documents[0].data["userEmail"]);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Chatroom()));
          }
        });
        if (formKey.currentState.validate()) {
          setState(() {
            isLoading = true;
          });
      }
    }

  @override
  Widget build(context) {
    return Scaffold(
       appBar: appBarMain(context),
       body: SingleChildScrollView(
           child: Container(
             height: MediaQuery.of(context).size.height-50,
             alignment: Alignment.bottomCenter,
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 24.0),
               child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: <Widget>[
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val){
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val) ? null: "Email is not valid";
                              },
                              controller: emailController,
                              style: fieldStyle(),
                              decoration: textfieldInputDecoration('email'),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val){
                                return val.length > 6 && isAlphanumeric(val) ? null : "invalid password";
                              },
                              controller: passwordController,
                              style: fieldStyle(),
                              decoration: textfieldInputDecoration('password'),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 8),
                     Container(
                       alignment: Alignment.centerRight,
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text('Forget Password',
                           style: fieldStyle()
                       ),
                    )
                 ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: signIn,
                      child: Container(
                       alignment: Alignment.center,
                       width: MediaQuery.of(context).size.width,
                       padding: EdgeInsets.symmetric(vertical: 20.0),
                       decoration: BoxDecoration(
                        gradient: LinearGradient(
                           colors: [
                             const Color(0xff007EF4),
                             const Color(0xff4E57FF)
                           ],
                       ),
                       borderRadius: BorderRadius.circular(30.0)
                   ),
                           child: Text('Sign In', style: clickStyle() ),
                        ),
                    ),
                 SizedBox(height: 16,),
                 Container(
                   alignment: Alignment.center,
                   width: MediaQuery.of(context).size.width,
                   padding: EdgeInsets.symmetric(vertical: 20.0),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(30.0)
                   ),
                   child: Row(
                     children: [
                        Image.asset("assets/images/google.png", height: 12),
                        Center(
                          child: Text('Sign In with Google', style: TextStyle(
                             color: Colors.black87,
                             fontSize: 17
                       )
                     ),
                        ),
                   ]
                   ),
                 ),
                     SizedBox(height: 16,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                       Text("Don't have a account? " , style: clickStyle(),),
                        GestureDetector(
                          onTap: widget.toggle(),
                          child: Container(
                           padding: EdgeInsets.symmetric(vertical: 8),
                           child: Text('Register now',style: TextStyle(
                             color: Colors.white,
                             fontSize: 17,
                             decoration: TextDecoration.underline
                            ),
                      ),
                       ),
                        ),
                   ]
                 ),
                     SizedBox(height: 50,),
               ],
             )
            ),
           ),
         ),
    );
  }
}