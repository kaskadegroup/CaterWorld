//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastea/views/my_account.dart';

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

  void goToAccount(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAccount()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
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
                          tileColor: Color.fromRGBO(252, 252, 246, 0.5),
                        ),
                        margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25)),
                    Card(
                        child: ListTile(
                          title: Text('Account'),
                          onTap: () => goToAccount(context),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Color.fromRGBO(252, 252, 246, 0.5),
                        ),
                        margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 25)),
                    Card(
                      child: ListTile(
                        title: Text('Sign out'),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                        tileColor: Color.fromRGBO(252, 252, 246, 0.5),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
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
    );
  }
}
