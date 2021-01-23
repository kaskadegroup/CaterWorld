//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../models/meal_item.dart';

class LikesScreen extends StatefulWidget {
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  Future getFavoriteDishes() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    var _allFavorites = userData.data["data"];
    var results = Firestore.instance
        .collection('dish_info')
        .where("dishId", whereIn: _allFavorites)
        .getDocuments();
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFavoriteDishes(),
        builder: (ctx, dishInfoSnapshot) {
          if (dishInfoSnapshot.hasData) {
            final dishInfo = dishInfoSnapshot.data.documents;
            return ListView.builder(
                itemCount: dishInfo.length,
                itemBuilder: (ctx, index) => MealItem(
                      title: dishInfo[index]['dish_name'],
                      cuisine: dishInfo[index]['dish_cat'],
                      dishStory: dishInfo[index]['dish_story'],
                      dishId: dishInfo[index]['dishId'],
                      dishUrl:  dishInfo[index]['dishUrl'],
                      isVeg: dishInfo[index]['isVeg'],
                      isFavorite: true,
                      ingredients: dishInfo[index]['Ingredients'],
                    ));
          }
          return Center(child: Text("You have no Favorites"));
        });
  }
}
