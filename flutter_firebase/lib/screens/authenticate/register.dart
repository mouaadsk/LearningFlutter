import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/loading_page.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';


class RegisterPage extends StatefulWidget {
  final Function togglePage;
  RegisterPage({this.togglePage});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  String email ,password ;
  // our formkey variable 
  final _formKey = GlobalKey<FormState>(); 
  bool loading_state = false;
  @override
  Widget build(BuildContext context) {
    return loading_state ? LoadingPage():  Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        elevation: 0.0,
        title: Text('Sign UP To The Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(''),
            onPressed: (){
              this.widget.togglePage();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: inputFormStyle.copyWith(hintText: 'Enter Your Email'),
                  validator: (value) => !EmailValidator.validate(email.trim(), true)? 'Enter A Valid Email' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: inputFormStyle.copyWith(hintText: 'Enter Your Password'),
                  validator: (value) => value.length < 6 ? 'Enter Password Length > 6' : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(height: 20.0), 
                RaisedButton(
                  color: Colors.amber,
                  child: Text(
                    'Sign UP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async  {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading_state = true;
                      });
                      dynamic result = await _auth.signUpWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          loading_state = false;
                          print('there is a problem in registering');
                        });
                      }
                    }
                    
                  },
                ),
              ],
            ),
          )),
    );
  }
}