//Package Import
import 'dart:ui';
import 'package:flutter_svg/svg.dart';
//import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MealsScreen extends StatelessWidget {
  static const routeName = '/views-screen';

  final Function toggleFavorite;
  final Function isFavorite;

  final image1 = 'assets/images/Patriotic-Charcuterie-Board-RC.png';
  final String nonVeg = 'assets/icons/Non-Veg.svg';
  final String likeButton = 'assets/icons/Tile Like Button.svg';
  final String title;
  final String cuisine;
  final String dishStory;
  final List ingredients;
  final bool isVeg;


  MealsScreen({
    Key key,
    this.title,
    this.cuisine,
    this.dishStory,
    this.toggleFavorite,
    this.isFavorite,
    this.ingredients,
    this.isVeg,
  })
      : super(key: key);

  //_takePictur() {}

  String get_ingredients (List ingredients){
    String ingredients_str = '';
    for (var i = 0 ; i < ingredients.length; i++){
      ingredients_str += '>' + ingredients[i] + '\n';
    }
    return ingredients_str;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontFamily: '.SF Pro Display',
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(120, 115, 115, 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: PageView(
                  controller: PageController(viewportFraction: 1),
                  children: [
                    Image.asset(
                      image1,
                      //height: 80,
                      //width: 80,
                    ),
                    Image.asset(
                      image1,
                      //height: 80,
                      //width: 80,
                    ),
                    Image.asset(
                      image1,
                      //height: 80,
                      //width: 80,
                    ),
                    Image.asset(
                      image1,
                      //height: 80,
                      //width: 80,
                    ),
                  ],
                ),
                // child: GridView.count(
                //   physics: NeverScrollableScrollPhysics(),
                //   crossAxisCount: 2,
                //   children: [
                //     Image.asset(
                //       image1,
                //       height: 80,
                //       width: 80,
                //     ),
                //     Image.asset(
                //       image1,
                //       height: 80,
                //       width: 80,
                //       //fit: BoxFit.cover,
                //     ),
                //     Image.asset(
                //       image1,
                //       height: 80,
                //       width: 80,
                //       //fit: BoxFit.cover,
                //     ),
                //     Image.asset(
                //       image1,
                //       height: 80,
                //       width: 80,
                //       //fit: BoxFit.cover,
                //     )
                //   ],
                // ),
              ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(50),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: '.SF Pro Display',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                      ),
                      Text(
                        cuisine,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: '.SF Pro Display',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                      ),
                      SvgPicture.asset(
                        nonVeg,
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      //FlatButton.icon(onPressed: (null), icon:Icon(Icons.camera), label: Text("cam")),

                      SvgPicture.asset(
                        likeButton,
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ingredients",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(120, 115, 115, 1),
                    ),
                  ),
                  Text(get_ingredients(ingredients),
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: '.SF Pro Display',
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(120, 115, 115, 1),
                  ),
                  ),
                  Text(
                    "Story Behind This Dish",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(120, 115, 115, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                  Text(
                      dishStory,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(120, 115, 115, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFF7F0DD),
            ],
          ),
          //boxShadow: [BoxShadow(spreadRadius: 2,),],
        ),
      ),
    );
  }
}
