import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Aunthenticate extends StatefulWidget {
  @override
  _AunthenticateState createState() => _AunthenticateState();
}

class _AunthenticateState extends State<Aunthenticate> {

    bool showSighIn = true;

    void toggleView(){
      setState(() {
        showSighIn = !showSighIn;   //toggles value of show sign in from true to false and false to true
      });
    }

  @override
  Widget build(BuildContext context) {
    if (showSighIn){
      return SignIn(
        toggleView: toggleView
      );                    //gives sign in screen and toggle screen link to top
    }else{
      return Register(
        toggleView: toggleView
      );
    }
  }
}