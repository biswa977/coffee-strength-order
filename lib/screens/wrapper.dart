import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//authenticate ki home ma lane yei bata tha huncha
    final user = Provider.of<User>(context);    //user login gare user vanne variable ma bascha
                                
    //return either home or authenticate widget

    if(user == null){
      return Aunthenticate();
    }
    else{
        return Home();          //user null chaina i.e kei value cha vane homescreen ma jancha
    }
   
  }
}