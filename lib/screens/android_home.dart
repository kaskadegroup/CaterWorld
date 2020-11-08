//Android Home Screen

//Package Import
import 'package:flutter/material.dart';

class AndroidHome extends StatelessWidget {
  final String home;
  final String addNew;
  final String favDish;
  final String burgMenu;
  final String filterMenu;
  final String categoryTitle;
  final categoryMeals;

  AndroidHome(
    this.home,
    this.addNew,
    this.favDish,
    this.burgMenu,
    this.filterMenu,
    this.categoryTitle,
    this.categoryMeals,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Coming Soon!!!'),
      ),
    );
  }
}
