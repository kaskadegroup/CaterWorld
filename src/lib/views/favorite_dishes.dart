//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';
import '../widgets/sign_in.dart';

class FavoriteDishes extends StatefulWidget {
  @override
  _FavoriteDishesState createState() => _FavoriteDishesState();
}

class _FavoriteDishesState extends State<FavoriteDishes> {
  Future getFavoriteDishes() async {
    final user =  FirebaseAuth.instance.currentUser;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    List _allFavorites = userData.data()!["allFavorites"];
    if (_allFavorites.isNotEmpty) {
      var results = FirebaseFirestore.instance
          .collection('dishInfo')
          .where("dishId", whereIn: _allFavorites)
          .get();
      return results;
    } else {
      var results = FirebaseFirestore.instance
          .collection('dishInfo')
          .where("dishId", isEqualTo: 'none')
          .get();
      return results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return Container(
              child: FutureBuilder(
                  future: getFavoriteDishes(),
                  builder: (ctx, dishInfoSnapshot) {
                    switch (dishInfoSnapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                        break;
                      default:
                        if (dishInfoSnapshot.hasError)
                          return Container(
                              child: Text(dishInfoSnapshot.error.toString()));
                        final List dishInfo = dishInfoSnapshot.data.docs;
                        if (dishInfo.isEmpty) {
                          return Center(child: Text("You have no Favorites"));
                        }
                        return ListView.builder(
                            itemCount: dishInfo.length,
                            itemBuilder: (ctx, index) => DishCard(
                                  title: dishInfo[index]['dishName'],
                                  cuisine: dishInfo[index]['dishCat'],
                                  dishStory: dishInfo[index]['dishStory'],
                                  dishId: dishInfo[index]['dishId'],
                                  dishUrl: dishInfo[index]['dishUrl'],
                                  isVeg: dishInfo[index]['isVeg'],
                                  isFavorite: true,
                                  status: dishInfo[index]['status'],
                                  isStatus: false,
                                  ingredients: dishInfo[index]
                                      ['dishIngredients'],
                                  isLogin: true,
                                  isAdmin: false,
                                  dishRecipe: dishInfo[index]['dishRecipe']
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
            );
          }
          return Scaffold(
            body: SignIn(),
          );
        });
  }
}
