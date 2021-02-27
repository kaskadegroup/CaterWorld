//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import files
import 'get_user_dishes.dart';

class UserSettings extends StatelessWidget {

  void getUserDishes(BuildContext context) {
    Navigator.push(context,  new MaterialPageRoute(builder: (context) => GetUserDishes()));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(
              'Sign out'
            ),
            onTap: () async{
              await FirebaseAuth.instance.signOut();
              },
              trailing: Icon(Icons.arrow_forward_ios)
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
                'My dishes'
            ),
            onTap: () => getUserDishes(context),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}
