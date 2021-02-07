//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';

class FavoriteDishes extends StatefulWidget {
  @override
  _FavoriteDishesState createState() => _FavoriteDishesState();
}

class _FavoriteDishesState extends State<FavoriteDishes> {
  Future getFavoriteDishes() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    var _allFavorites = userData.data["allFavorites"];
    var results = Firestore.instance
        .collection('dishInfo')
        .where("dishId", whereIn: _allFavorites)
        .getDocuments();
    return results;
  }

  @override
  Widget build(BuildContext context) {
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
              if(dishInfo.isEmpty){
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
                        ingredients: dishInfo[index]['Ingredients'],
                      ));
          }
        });
  }
}
