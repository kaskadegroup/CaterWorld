import 'dart:ui';

import 'package:caterWorld/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//File Import
import '../screens/dish_view_screen.dart';
import '../providers/meal.dart';


class MealItem extends StatefulWidget {

  // final String id;
  final String title;
  final String cuisine;
  final String dishStory;
  final String imageUrl;
  final String dishId;
  final List ingredients;
  final bool isVeg;

  final Function toggleFovorite;
  final Function isMealFavorite;

  MealItem({
    // @required this.id,
    @required this.title,
    @required this.cuisine,
    this.dishStory,
    this.imageUrl,
    this.toggleFovorite,
    this.isMealFavorite,
    this.dishId,
    this.ingredients,
    this.isVeg
  });


  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {

  final String nonVegIcon = 'assets/icons/Non-Veg.svg';
  final String vegIcon = 'assets/icons/Veg.svg';


  final String favIcon = 'assets/icons/Heartv2.svg';

  final String foodImage = 'assets/images/Patriotic-Charcuterie-Board-RC.png';

  final String likedbuttom = 'assets/icons/liked.svg';

  bool isFavorite = false;

  void selectMeal(BuildContext context) async {
    final favResult = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MealsScreen(

                  title: widget.title,
                  cuisine: widget.cuisine,
                  dishStory: widget.dishStory,
                  dishId: widget.dishId,
                  isFavorite: isFavorite,
                  ingredients: widget.ingredients,
                  isVeg: widget.isVeg
                )));

    setState(() {
      isFavorite = favResult;
    });

  }

  @override
  Widget build(BuildContext context) {
    //return InkWell(
    //onTap: selectMeal,
    //final meals = Provider.of<Meal>(context);

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        margin: EdgeInsets.only(
          bottom: 25,
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    foodImage,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 21,
                          fontFamily: '.SF Pro Display',
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                      ),

                      //Cuisine
                      Text(
                        widget.cuisine,
                        style: TextStyle(
                          fontSize: 21,
                          fontFamily: '.SF Pro Display',
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                      ),

                      //Non-Veg Icon
                      widget.isVeg ?  SvgPicture.asset(
                        vegIcon,
                        height: 25,
                      ):
                      SvgPicture.asset(
                        nonVegIcon,
                        height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 5),
                      ),
                      !isFavorite
                          ? SvgPicture.asset(
                              favIcon,
                              height: 35,
                            )
                          : SvgPicture.asset(
                              likedbuttom,
                              height: 35,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        color: Color.fromRGBO(246, 243, 236, 1),
      ),
    );
  }
}
