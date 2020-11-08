import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import './meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String categories;
  final String imageUrl;

  final String assetName = 'assets/icons/Non-Veg.svg';
  final String foodImage = 'assets/images/Patriotic-Charcuterie-Board-RC.png';

  MealItem({
    @required this.id,
    @required this.title,
    @required this.categories,
    @required this.imageUrl,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    //return InkWell(
    //onTap: selectMeal,
    return GestureDetector(
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
                        title,
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
                        categories,
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
                      SvgPicture.asset(
                        assetName,
                        height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 15),
                      ),
                      //Favorite Icon
                      ImageIcon(
                        AssetImage('assets/icons/Heart.png'),
                        size: 38,
                        color: Color.fromRGBO(120, 115, 115, 1),
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
