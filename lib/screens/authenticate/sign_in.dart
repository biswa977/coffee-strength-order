import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});      //its constructor for widget

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();   // authservice class ko object banako _auth

    final _formKey = GlobalKey<FormState>();
    bool loading = false;


    String email = ' ';
    String password = '';
    String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(     //loading vaye loading dekhaune navaye scaffold 
        backgroundColor: Colors.brown[100],
        appBar: AppBar(                                           //appbar muni raised button 
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("sign in to brew crew"),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Register'),
                onPressed: (){
                     widget.toggleView();
                },
            ),
          ],
          ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                  validator: (val) => val.isEmpty ? 'enter an email': null,
                  onChanged: (val){         //everytime value in form field changes this function is called
                    setState(() {           //email vanne mathi ko string ma gayera value bascha
                      email = val;          // val vaneko j type garyo tei nai value huncha
                    });
                    
                  },
                ),
                 SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length <6 ? 'enter a password of 6+ characters': null,
                  obscureText: true,
                  onChanged: (val){         //everytime value in form field changes this function is called
                    setState(() {
                      password = val;
                    });
                    
                  },

                ),
                 SizedBox(height: 20.0,),

                 RaisedButton(
                   color: Colors.pink[400],
                   child: Text(
                     'sign in',
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () async{

                     if(_formKey.currentState.validate()){
                       setState(() {
                         loading = true;
                       });
                       dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                       if(result==null){
                         setState(() {
                           error = 'couldnot sign in with those credential';
                           loading = false;
                         });
                       }
                     }
                      // print(email);           //mathi email string vanera banako cha @override vanda mathi
                      // print(password);        //email rapassword j niyei print huncha
                   },
                 ),
                 SizedBox(height:12.0),
                 Text(
                   error,
                   style: TextStyle(color: Colors.red, fontSize: 14.0),
                 )
              ],
            ),
          ),
        ),
    );
  }
}