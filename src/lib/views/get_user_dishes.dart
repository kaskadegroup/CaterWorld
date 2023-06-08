//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';

class GetUserDishes extends StatelessWidget {
  bool isAdmin = false;
  Future _checkuserdishes() async {
    final user =  FirebaseAuth.instance.currentUser;
    final userInfo =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    if (userInfo['account'] == '') {
      final dishesData = await FirebaseFirestore.instance
          .collection('dishInfo')
          .where('userId', isEqualTo: user!.uid)
          .get();
      isAdmin = false;
      return dishesData;
    } else if (userInfo['account'] == 'admin') {
      final dishesData = await FirebaseFirestore.instance
          .collection('dishInfo')
          .where('status', isEqualTo: 'PENDING')
          .get();
      isAdmin = true;
      return dishesData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            'My dishes',
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
          child: FutureBuilder(
              future: _checkuserdishes(),
              builder: (ctx, userDishesSnapshot) {
                switch (userDishesSnapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    if (userDishesSnapshot.hasError)
                      return Container(
                        child: Text(userDishesSnapshot.error.toString()),
                      );
                    final List userDishes = userDishesSnapshot.data.documents;
                    if (userDishes.isEmpty) {
                      return Center(
                          child: Text("You have not uploaded any dishes"));
                    }
                    return ListView.builder(
                        itemCount: userDishes.length,
                        itemBuilder: (ctx, index) => DishCard(
                              title: userDishes[index]['dishName'],
                              cuisine: userDishes[index]['dishCat'],
                              dishStory: userDishes[index]['dishStory'],
                              dishId: userDishes[index]['dishId'],
                              dishUrl: userDishes[index]['dishUrl'],
                              ingredients: userDishes[index]['dishIngredients'],
                              isVeg: userDishes[index]['isVeg'],
                              isStatus: true,
                              isFavorite: false,
                              status: userDishes[index]['status'],
                              isLogin: true,
                              isAdmin: isAdmin,
                            ));
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
        ));
  }
}
