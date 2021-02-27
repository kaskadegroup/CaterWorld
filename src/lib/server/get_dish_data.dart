//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';

class GetDishData extends StatelessWidget {

  Future _checkfavorites() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('dishInfo')
            .where('status', isEqualTo: 'APPROVED').snapshots(),
        builder: (ctx, dishInfoSnapshot) {
          if (dishInfoSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final dishInfo = dishInfoSnapshot.data.documents;

          return FutureBuilder(
            future: _checkfavorites(),
            builder: (ctx, favoriteSnapshot) {
              switch (favoriteSnapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                default:
                  if (favoriteSnapshot.hasError)
                    return Container(
                        child: Text(favoriteSnapshot.error.toString()));

                  final List allFavorite = favoriteSnapshot
                      .data['allFavorites'];
                  return ListView.builder(
                      itemCount: dishInfo.length,
                      itemBuilder: (ctx, index) =>
                          DishCard(
                            title: dishInfo[index]['dishName'],
                            cuisine: dishInfo[index]['dishCat'],
                            dishStory: dishInfo[index]['dishStory'],
                            dishId: dishInfo[index]['dishId'],
                            dishUrl: dishInfo[index]['dishUrl'],
                            ingredients: dishInfo[index]['Ingredients'],
                            isVeg: dishInfo[index]['isVeg'],
                            isStatus: false,
                            status: dishInfo[index]['status'],

                            isFavorite: allFavorite.contains(dishInfo[index]['dishId']),
                          ));
              }

            });
          });
  }
}
