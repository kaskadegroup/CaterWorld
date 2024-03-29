//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';

class GetDishData extends StatefulWidget {
  @override
  _GetDishDataState createState() => _GetDishDataState();
}

class _GetDishDataState extends State<GetDishData> {
  Future _checkfavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('dishInfo')
              .where('status', isEqualTo: 'APPROVED')
              .snapshots(),
          builder: (ctx, dishInfoSnapshot) {
            if (dishInfoSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final dishInfo = dishInfoSnapshot.data!.docs;

            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (_, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.active) {
                    if (userSnapshot.data == null) {
                      return ListView.builder(
                          itemCount: dishInfo.length,
                          itemBuilder: (ctx, index) => DishCard(
                                title: dishInfo[index]['dishName'],
                                cuisine: dishInfo[index]['dishCat'],
                                dishStory: dishInfo[index]['dishStory'],
                                dishId: dishInfo[index]['dishId'],
                                dishUrl: dishInfo[index]['dishUrl'],
                                ingredients: dishInfo[index]['dishIngredients'],
                                isVeg: dishInfo[index]['isVeg'],
                                isStatus: false,
                                status: dishInfo[index]['status'],
                                isFavorite: false,
                                isLogin: false,
                                isAdmin: false,
                                dishRecipe: dishInfo[index]['dishRecipe']
                              ));
                    } else {
                      return FutureBuilder(
                          future: _checkfavorites(),
                          builder: (ctx, favoriteSnapshot) {
                            switch (favoriteSnapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                                break;
                              default:
                                if (favoriteSnapshot.hasError) {
                                  return Container(
                                      child: Text(
                                          favoriteSnapshot.error.toString()));
                                }
                                final List allFavorite =
                                    favoriteSnapshot.data['allFavorites'];

                                return ListView.builder(
                                    itemCount: dishInfo.length,
                                    itemBuilder: (ctx, index) => DishCard(
                                          title: dishInfo[index]['dishName'],
                                          cuisine: dishInfo[index]['dishCat'],
                                          dishStory: dishInfo[index]
                                              ['dishStory'],
                                          dishId: dishInfo[index]['dishId'],
                                          dishUrl: dishInfo[index]['dishUrl'],
                                          ingredients: dishInfo[index]
                                              ['dishIngredients'],
                                          isVeg: dishInfo[index]['isVeg'],
                                          isStatus: false,
                                          status: dishInfo[index]['status'],
                                          isFavorite: allFavorite.contains(
                                              dishInfo[index]['dishId']),
                                          isLogin: true,
                                          isAdmin: false,
                                          dishRecipe: dishInfo[index]['dishRecipe']
                                        ));
                            }
                          });
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                });
          }),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFFFFF),
            const Color(0xFFF7F0DD),
          ],
        ),
      ),
    );
  }
}
