// package import
import 'package:flutter/material.dart';

// file import
import '../views/auth_view.dart';

class SignIn extends StatelessWidget {
  void goToAuth(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthView()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("Not Signed in"),
        ),
        ElevatedButton(
          onPressed: () => goToAuth(context),
          child: Text("test"),
        ),
      ],
    );
  }
}
