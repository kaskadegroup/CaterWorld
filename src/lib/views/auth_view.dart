//import packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import files
import '../widgets/auth_form.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _loginFailed = false;

  Future<bool> _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        final authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set(
                {'username': username, 'email': email, 'allFavorites': [],
                  'account':''});
      }
      _loginFailed = false;
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      _loginFailed = true;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('An error occurred, please check your credentials!'),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );


      setState(() {
        _isLoading = false;
      });
    }
    return _loginFailed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
