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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text("Please Sign-in to use this option",
              style: TextStyle(
                fontSize: 18,
                fontFamily: '.SF Pro Display',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(120, 115, 115, 1),
              )),
        ),
        Padding(padding: EdgeInsets.all(5)),
        ElevatedButton(
          onPressed: () => goToAuth(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(120, 115, 115, 0.5),
            ),
            elevation: MaterialStateProperty.all(0.4),
          ),
          child: Text(
            "Sign in",
            style: TextStyle(
              fontSize: 20,
              fontFamily: '.SF Pro Display',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
