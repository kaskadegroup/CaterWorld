//import packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import files
import './views/nav_bar.dart';
import './views/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // future: _initialization,
        stream: FirebaseFirestore.instance.collection('dishInfo').snapshots(),
        builder: (context, appSnapshot) {
          return MaterialApp(
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return NavBar();
                  }
                  return AuthView();
                }),
          );
        });
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: NavBar(),
  //   );
  //}
}
