//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import files
import 'get_user_dishes.dart';
import '../views/auth_view.dart';
import 'nav_bar.dart';

class MyAccount extends StatelessWidget {
  Future _deleteAccount(context) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => new NavBar()),
            (Route<dynamic> route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          'My Account',
          style: TextStyle(
            fontSize: 24,
            fontFamily: '.SF Pro Display',
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(120, 115, 115, 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text('Delete Account'),
            onPressed: () => _deleteAccount(context),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFFFFFFF),
                const Color(0xFFF7F0DD),
              ],
              stops: [
                0,
                1
              ]),
        ),
      ),
    );
  }
}
