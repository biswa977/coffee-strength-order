import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  
  final Function toggleView;            //authenticate vanne class ma vako toggle function lai ya use gareko
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();

  
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();   // authservice class ko object banako _auth

  final _formKey = GlobalKey<FormState>();    //global key vanne flutter ko validator wala system ho

  bool loading = false;

  String email = ' ';
    String password = '';
    String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(                                           //appbar muni raised button 
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign Up to brew crew"),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign In'),
                onPressed: (){
                  widget.toggleView();
                },
            ),
          ],
          ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
          child: Form(
            key: _formKey,            //key vanne le _formkey vanne validator ko rup ma use garna milcha
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                  validator: (val) => val.isEmpty ? 'enter an email' : null,
                  onChanged: (val){         //everytime value in form field changes this function is called
                    setState(() {           //email vanne mathi ko string ma gayera value bascha
                      email = val;          // val vaneko j type garyo tei nai value huncha
                    });
                    
                  },
                ),
                 SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6.0  ? 'enter at least 6+ digit password' : null,
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
                     'Register',
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () async{
                      // print(email);           //mathi email string vanera banako cha @override vanda mathi
                      // print(password);        //email rapassword j niyei print huncha

                      if(_formKey.currentState.validate())      // validator use gareko validate garna lai
                      {
                            // print(email);
                            // print(password);
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                            if(result == null){

                              setState(() => error = 'please supply a valid email');
                              loading = false;
                            }

                      }
                   },

                 ),
                 SizedBox(height: 12.0,),

                 Text(
                   error , style: TextStyle(color: Colors.red, fontSize: 14.0),
                 ),

              ],
            ),
          ),
        ),
    );
  }
}