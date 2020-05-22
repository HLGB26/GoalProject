import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:solens/services/auth.dart';
import 'package:solens/services/database.dart';
import 'package:solens/helper/helperFunction.dart';
import 'package:solens/constants/appbarChoice.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  _SignUpState createState()=> _SignUpState();

}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods databaseMethods =new DataBaseMethods();


  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController= new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signMeUp() async {
      await authMethods.signUpwithEmailAndPassword(userNameController.text,emailController.text,
          passwordController.text).then((result){
        if(result != null){

          Map<String,String> userDataMap = {
            "name" : userNameController.text,
            "email" : emailController.text
          };

          databaseMethods.uploadUserInfo(userDataMap);

          HelperFunction.saveUserLoggedInSharedPreference(true);
          HelperFunction.saveUserNameSharedPreference(userNameController.text);
          HelperFunction.saveUserEmailSharedPreference(emailController.text);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
      if(formKey.currentState.validate()){
        setState(() {
          isLoading = true;
        });
    }
  }

  Widget build(context){
    return Scaffold(
       appBar: AppBarMain(context),
       body: isLoading ? Container (
         child: Center(child: CircularProgressIndicator())
       ) : SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height - 50,
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
                              return val.isEmpty || val.length < 4 ? "Username not valid  ": null;
                           },
                           controller: userNameController,
                           style: fieldStyle(),
                           decoration: textfieldInputDecoration('Username'),
                         ),
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
                   SizedBox(height: 12,),
                   GestureDetector(
                     onTap: signMeUp,
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
                       child: Text('Sign Up', style: clickStyle() ),
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
                         Image.asset("assets/images/google.png"),
                         Text('Sign Up with Google', style: TextStyle(
                           color: Colors.black87,
                           fontSize: 17
                       )
                       )],
                     ),
                   ),
                   SizedBox(height: 16,),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Already have a account? " , style: clickStyle(),),
                         GestureDetector(
                           onTap: widget.toggle,
                           child: Container(
                             padding: EdgeInsets.symmetric(vertical: 8),
                             child: Text('SignIn now',style: TextStyle(
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