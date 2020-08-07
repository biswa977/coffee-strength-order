import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {

final AuthService _auth = AuthService();          //authservice class ko object banako _auth

  @override
  Widget build(BuildContext context) {

      void _showSettingsPanel(){

        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        });
      }


    return StreamProvider<List<Brew>>.value(
          value: DatabaseService().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('brew crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async{
                await _auth.signOut();          //onp pressing logout button authservice vanne class ko signout call huncha
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
         
          decoration: BoxDecoration(
            image: DecorationImage(

              image: AssetImage('lib/assets/cup.png'),
              fit: BoxFit.cover,
              )
              
          ),
           child: BrewList(),
          ),

          
      ),
    );
  }
}