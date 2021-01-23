////import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

////import files
import 'package:caterWorld/models/meal_item.dart';

class DishInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('dish_info').snapshots(),
        builder: (ctx, dishInfoSnapshot) {
          if (dishInfoSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final dishInfo = dishInfoSnapshot.data.documents;

          return ListView.builder(
              itemCount: dishInfo.length,
              itemBuilder: (ctx, index) => MealItem(
                    title: dishInfo[index]['dish_name'],
                    cuisine: dishInfo[index]['dish_cat'],
                    dishStory: dishInfo[index]['dish_story'],
                    dishId: dishInfo[index]['dishId'],
                    dishUrl: dishInfo[index]['dishUrl'],
                    ingredients: dishInfo[index]['Ingredients'],
                    isVeg: dishInfo[index]['isVeg'],
                    isFavorite: false,
                  ));
        });
  }
}
