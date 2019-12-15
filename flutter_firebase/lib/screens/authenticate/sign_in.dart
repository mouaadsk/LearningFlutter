import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/loading_page.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SignInPage extends StatefulWidget {
  final Function togglePage;
  SignInPage({this.togglePage});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  // variables of signing in
  String email = '', password = '';
  // te global form key
  final _formKey = GlobalKey<FormState>();
  bool loading_state = false;
  @override
  Widget build(BuildContext context) {
    return loading_state
        ? LoadingPage()
        : Scaffold(
            backgroundColor: Colors.brown,
            appBar: AppBar(
              backgroundColor: Colors.brown[600],
              elevation: 0.0,
              title: Text('Sign In To The Brew Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person_add),
                  label: Text(''),
                  onPressed: () {
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
                        decoration: inputFormStyle.copyWith(
                            hintText: 'Enter Your Email'),
                        validator: (value) =>
                            !EmailValidator.validate(email, true)
                                ? 'Enter A Valid Email'
                                : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: inputFormStyle.copyWith(
                            hintText: 'Enter Your Password'),
                        validator: (value) => value.length < 6
                            ? 'Enter Password Length > 6'
                            : null,
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
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading_state = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading_state = false;
                                print('please enter a valid account')
;                              });
                            } else {
                              print('sign in succefully');
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
