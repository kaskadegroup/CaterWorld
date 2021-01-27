//import packages

import 'package:flutter/material.dart';


//import files
import 'auth_view.dart';

class SignInOptions extends StatelessWidget {
  final String facebookLogin = 'assets/icons/facebooklogin.svg';
  final String googleLogin = 'assets/icons/googlelogin.svg';

  void _signInWithEmail(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AuthView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    "Sign Up to CaterWorld to contact a chef, sell your dishes and so much more!"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Sign in with Apple"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Sign in with FaceBook"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Sign in with Google"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Sign in with Email"),
              ),
              RaisedButton(
                onPressed: null,
                child: Text("Sign in with Phone Number"),
              ),
              RaisedButton(
                  onPressed: () => _signInWithEmail(context),
                  child: Text("Sign in with email"))
            ]),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFF7F0DD),
            ],
          ),
        ),
      ),
    );
  }
}
