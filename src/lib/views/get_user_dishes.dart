//import packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import files
import '../widgets/meal_card_widget.dart';

class GetUserDishes extends StatelessWidget {
  Future _checkuserdishes() async {
    final user = await FirebaseAuth.instance.currentUser();
    final dishesData = await Firestore.instance.collection('dishInfo')
        .where('userId', isEqualTo: user.uid).getDocuments();
    return dishesData;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(body: FutureBuilder(
      future: _checkuserdishes(),
      builder: (ctx, userDishesSnapshot){
        switch (userDishesSnapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(),);
            break;
          default:
            if(userDishesSnapshot.hasError)
              return Container(
                child: Text(userDishesSnapshot.error.toString()),
              );
            final List userDishes = userDishesSnapshot.data.documents;
            return ListView.builder(
              itemCount: userDishes.length,
              itemBuilder: (ctx, index) =>
                DishCard(
                title: userDishes[index]['dishName'],
                cuisine: userDishes[index]['dishCat'],
                dishStory: userDishes[index]['dishStory'],
                dishId: userDishes[index]['dishId'],
                dishUrl: userDishes[index]['dishUrl'],
                ingredients: userDishes[index]['Ingredients'],
                isVeg: userDishes[index]['isVeg'],
                isStatus: true,
                isFavorite: false,
                status: userDishes[index]['status'],
              )
            );

        }
      }


    )
    );
  }
}