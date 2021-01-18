import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: Text(
          "Sign out",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
