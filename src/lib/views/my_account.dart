//import packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// import files
import 'nav_bar.dart';

class MyAccount extends StatelessWidget {
  Future _deleteAccount(context) async {
    final user = FirebaseAuth.instance.currentUser;
    final userPersonalData =
        FirebaseFirestore.instance.collection('users').doc(user?.uid);
    await FirebaseFirestore.instance
        .collection('dishInfo')
        .where('userId', isEqualTo: user?.uid)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection('dishInfo')
            .doc(docSnapshot.id)
            .delete();
      }
    });

    await userPersonalData.delete();
    await user?.delete();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => new NavBar()),
        (Route<dynamic> route) => false);
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete'),
        content: const Text('This will also delete all your dishes!'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => _deleteAccount(context),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future _getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    final userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    return userInfo;
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
      body: FutureBuilder(
          future: _getUserInfo(),
          builder: (ctx, userInfoSnapshot) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 90,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Center(child:
                    // userInfoSnapshot.data['email']
                        Text(
                          'User Name: ${userInfoSnapshot.data['username']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: '.SF Pro Display',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(120, 115, 115, 1),
                          ),
                        ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        'Email: ${userInfoSnapshot.data['email']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: '.SF Pro Display',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CupertinoButton(
                      child: Text('Delete Account'),
                      onPressed: () => _showAlertDialog(context),
                      // pressedOpacity: 0.2,
                    ),
                  ),
                ],
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
            );
          }),
    );
  }
}
