//Cupertino Style Home Screen

//Package Imports
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//File Imports
//import 'category.dart';
import 'ios_home.dart';
import 'android_home.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/ios-screen';

  final String home = 'assets/icons/Home.svg';
  final String addNew = 'assets/icons/Add.svg';
  final String favDish = 'assets/icons/Union.svg';
  final String burgMenu = 'assets/icons/Hamburger Menu.svg';
  final String filterMenu = 'assets/icons/Meatball Menu.svg';

  @override
  Widget build(BuildContext context) {
    //final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = 'Italian'; //ignore
    final categoryId = 'c1'; //ignore
    final categoryMeals = '0'; //ignore

    return Platform.isIOS
        ? IosHome(home, addNew, favDish, burgMenu, filterMenu, categoryId,
            categoryMeals)
        : AndroidHome(home, addNew, favDish, burgMenu, filterMenu,
            categoryTitle, categoryMeals);
  }
}
