//import packages
import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

//import files
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DishDetailView extends StatefulWidget {
  static const routeName = '/views-screen';

  final String title;
  final String cuisine;
  final String dishStory;
  final String dishId;
  bool isFavorite;
  final Map<String, dynamic> ingredients;
  final bool isVeg;
  final List dishUrl;
  bool isStatus;
  final status;
  bool isLogin;
  bool isAdmin;

  DishDetailView(
      {Key key,
      @required this.title,
      @required this.cuisine,
      @required this.dishStory,
      @required this.dishId,
      @required this.isFavorite,
      @required this.ingredients,
      @required this.isVeg,
      @required this.dishUrl,
      @required this.status,
      @required this.isStatus,
      @required this.isLogin,
      @required this.isAdmin})
      : super(key: key);

  @override
  _DishDetailViewState createState() => _DishDetailViewState();
}

class _DishDetailViewState extends State<DishDetailView> {
  final String nonVegIcon = 'assets/icons/Non-Veg.svg';
  final String vegIcon = 'assets/icons/Veg.svg';
  final String favIcon = 'assets/icons/Heartv2.svg';
  final String likedbuttom = 'assets/icons/liked.svg';

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  void _likedThis() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData = Firestore.instance.collection('users').document(user.uid);
    if (widget.isFavorite == false) {
      userData.updateData({
        "allFavorites": FieldValue.arrayUnion([widget.dishId])
      });

      setState(() {
        widget.isFavorite = true;
      });
    } else {
      userData.updateData({
        "allFavorites": FieldValue.arrayRemove([widget.dishId])
      });

      setState(() {
        widget.isFavorite = false;
      });
    }
  }

  String getIngredients(Map<String, dynamic> ingredients) {
    String ingredientsStr = '';
    for (var ing in ingredients.entries) {
      ingredientsStr += '>' +
          ing.key +
          ', ' +
          ing.value['Qty'] +
          ' ' +
          ing.value['Unit(s)'] +
          '\n';
    }
    return ingredientsStr;
  }

  void approveDish() {
    Firestore.instance
        .collection('dishInfo')
        .document(widget.dishId)
        .updateData({'status': "APPROVED"});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(widget.isFavorite)),
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontFamily: '.SF Pro Display',
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(120, 115, 115, 1),
            ),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
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
                  child: PageView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    itemCount: widget.dishUrl.length,
                    onPageChanged: (int index) {
                      _currentPageNotifier.value = index;
                    },
                    itemBuilder: (BuildContext context, index) {
                      return Image.network(widget.dishUrl[index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CirclePageIndicator(
                  itemCount: widget.dishUrl.length,
                  currentPageNotifier: _currentPageNotifier,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: '.SF Pro Display',
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(120, 115, 115, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                          ),
                          Text(
                            widget.cuisine,
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
                          widget.isVeg
                              ? SvgPicture.asset(
                                  vegIcon,
                                  height: 15,
                                )
                              : SvgPicture.asset(
                                  nonVegIcon,
                                  height: 15,
                                ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          widget.isLogin
                              ? IconButton(
                                  icon: !widget.isFavorite
                                      ? SvgPicture.asset(
                                          favIcon,
                                          height: 35,
                                        )
                                      : SvgPicture.asset(
                                          likedbuttom,
                                          height: 35,
                                        ),
                                  onPressed: _likedThis,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(right: 2),
                                ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                        ],
                      ),
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
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: '.SF Pro Display',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(120, 115, 115, 1),
                      ),
                    ),
                    Text(
                      getIngredients(widget.ingredients),
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
                      widget.dishStory,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: '.SF Pro Display',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(120, 115, 115, 1),
                      ),
                    ),
                    if (widget.isStatus)
                      Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: '.SF Pro Display',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(120, 115, 115, 1),
                        ),
                      ),
                    if (widget.isAdmin)
                      ElevatedButton(
                          onPressed: approveDish, child: Text('Approve')),
                  ],
                ),
              ),
            ]),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFFFFF),
                    const Color(0xFFF7F0DD),
                  ],
                  stops: [
                    0,
                    1
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
