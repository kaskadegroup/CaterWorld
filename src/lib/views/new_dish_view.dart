//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/new_dish_form.dart';
import '../widgets/sign_in.dart';

class AddDishScreen extends StatefulWidget {
  @override
  _AddDishScreenState createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  @override
//   Widget build(BuildContext context) {
//     return NewDishForm();
//   }
// }
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (_, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.data == null) {
              return Scaffold(
                body: SignIn(),
              );
            } else {
              return Scaffold(body: NewDishForm());
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
