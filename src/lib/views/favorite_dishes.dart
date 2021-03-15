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
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    List _allFavorites = userData.data["allFavorites"];
    if (_allFavorites.isNotEmpty) {
      var results = Firestore.instance
          .collection('dishInfo')
          .where("dishId", whereIn: _allFavorites)
          .getDocuments();
      return results;
    } else {
      var results = Firestore.instance
          .collection('dishInfo')
          .where("dishId", isEqualTo: 'none')
          .getDocuments();
      return results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder(
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
                      final List dishInfo = dishInfoSnapshot.data.documents;
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
                                ingredients: dishInfo[index]['Ingredients'],
                                isLogin: true,
                              ));
                  }
                });
          }
          return Scaffold(
            body: SignIn(),
          );
        });
  }
}
