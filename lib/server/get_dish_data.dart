//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import files
import '../widgets/meal_card_widget.dart';

class GetDishData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('dishInfo').snapshots(),
        builder: (ctx, dishInfoSnapshot) {
          if (dishInfoSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final dishInfo = dishInfoSnapshot.data.documents;

          return ListView.builder(
              itemCount: dishInfo.length,
              itemBuilder: (ctx, index) => DishCard(
                    title: dishInfo[index]['dishName'],
                    cuisine: dishInfo[index]['dishCat'],
                    dishStory: dishInfo[index]['dishStory'],
                    dishId: dishInfo[index]['dishId'],
                    dishUrl: dishInfo[index]['dishUrl'],
                    ingredients: dishInfo[index]['Ingredients'],
                    isVeg: dishInfo[index]['isVeg'],
                    isFavorite: false,
                  ));
        });
  }
}
