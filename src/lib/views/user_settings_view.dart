//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import files
import 'get_user_dishes.dart';
import '../views/auth_view.dart';

class UserSettings extends StatelessWidget {
  void getUserDishes(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => GetUserDishes()));
  }

  void goToAuth(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthView()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (_, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.data == null) {
              return ListView(children: <Widget>[
                Card(
                  child: ListTile(
                      title: Text('Sign in'),
                      onTap: () => goToAuth(context),
                      trailing: Icon(Icons.arrow_forward_ios)),
                )
              ]);
            } else {
              return ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text('My dishes'),
                      onTap: () => getUserDishes(context),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  Card(
                    child: ListTile(
                        title: Text('Sign out'),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        trailing: Icon(Icons.arrow_forward_ios)),
                  ),
                ],
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
