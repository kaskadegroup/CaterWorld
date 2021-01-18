import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal.dart';
import '../models/meal_item.dart';
import '../providers/products.dart';

class LikesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final favItemList = productsData.favortieItems;
    if (favItemList.isEmpty) {
      return Center(
        child: Text("You have no favorites"),
      );
    } else {
      //print(favItemList.length);
      //print(favItemList[0].id);
      //print(favItemList[0].title);
      return ListView.builder(
          itemCount: favItemList.length,
          itemBuilder: (BuildContext context, int index) {
            //return ChangeNotifierProvider.value(
            //value: favItemList[index],
            return MealItem(
              //d: likedMeals[index].id,
              title: "placeholder",
              cuisine: "all",
              imageUrl: 'none',
              //isFavorite: widget.isMealFavorite,
              //toggleFovorite: widget.toggleFavorite,
            );
          });
    }
  }
}
