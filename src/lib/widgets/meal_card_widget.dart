import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

//File Import
import '../views/dish_detail_view.dart';

class DishCard extends StatefulWidget {
  // final String id;
  final String title;
  final String cuisine;
  final String dishStory;
  final List dishUrl;
  final String dishId;
  final Map<String, dynamic> ingredients;
  final bool isVeg;
  final String status;
  bool isStatus;
  bool isFavorite;
  bool isLogin;
  bool isAdmin;

  DishCard({
    // @required this.id,
    @required this.title,
    @required this.cuisine,
    @required this.dishStory,
    @required this.dishUrl,
    @required this.dishId,
    @required this.ingredients,
    @required this.isVeg,
    @required this.status,
    @required this.isStatus,
    @required this.isFavorite,
    @required this.isLogin, // do not use except for like screen for now
    @required this.isAdmin,
  });

  @override
  _DishCardState createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  final String nonVegIcon = 'assets/icons/Non-Veg.svg';
  final String vegIcon = 'assets/icons/Veg.svg';

  final String favIcon = 'assets/icons/Heartv2.svg';

  final String foodImage = 'assets/images/Patriotic-Charcuterie-Board-RC.png';

  final String likedbuttom = 'assets/icons/liked.svg';

  void selectMeal(BuildContext context) async {
    final favResult = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => DishDetailView(
                  title: widget.title,
                  cuisine: widget.cuisine,
                  dishStory: widget.dishStory,
                  dishId: widget.dishId,
                  isFavorite: widget.isFavorite,
                  ingredients: widget.ingredients,
                  isVeg: widget.isVeg,
                  dishUrl: widget.dishUrl,
                  isStatus: widget.isStatus,
                  status: widget.status,
                  isLogin: widget.isLogin,
                  isAdmin: widget.isAdmin,
                )));

    setState(() {
      widget.isFavorite = favResult;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Image.network(
                      widget.dishUrl[0].toString(),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: '.SF Pro Display',
                              color: Color.fromRGBO(120, 115, 115, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                        ),

                        //Cuisine
                        Text(
                          widget.cuisine,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: '.SF Pro Display',
                            color: Color.fromRGBO(120, 115, 115, 1),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                        ),

                        //Non-Veg Icon
                        widget.isVeg
                            ? SvgPicture.asset(
                                vegIcon,
                                height: 10,
                              )
                            : SvgPicture.asset(
                                nonVegIcon,
                                height: 10,
                              ),

                        Padding(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        //Favorite Icon
                        widget.isLogin
                            ? !widget.isFavorite
                                ? SvgPicture.asset(
                                    favIcon,
                                    height: 30,
                                  )
                                : SvgPicture.asset(
                                    likedbuttom,
                                    height: 30,
                                  )
                            : Padding(
                                padding: EdgeInsets.only(right: 2),
                              ),

                        if (widget.isStatus)
                          Text(
                            widget.status,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: '.SF Pro Display',
                              color: Color.fromRGBO(120, 115, 115, 1),
                            ),
                          ),
                      ],
                    ),
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
