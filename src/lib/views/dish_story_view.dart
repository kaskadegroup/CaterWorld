import 'package:flutter/material.dart';

import '../widgets/dish_story_form.dart';

class DishStory extends StatelessWidget {
  final String dishName;
  final String dishCuisine;
  final String dishAllergens;
  final bool isVeg;
  final Map<String, Map<String, String>> ingredientsList;
  final List<String> recipesList;
  final GlobalKey<FormState> newDishKey;
  final GlobalKey<FormState> newIngKey;
  final TextEditingController ingController;

  DishStory({
    @required this.dishName,
    @required this.dishCuisine,
    @required this.dishAllergens,
    @required this.isVeg,
    @required this.ingredientsList,
    @required this.recipesList,
    @required this.newDishKey,
    @required this.newIngKey,
    @required this.ingController,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(37),
          child: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: Text(
                "Add a Dish",
                style: TextStyle(
                  fontSize: 34,
                  fontFamily: '.SF Pro Display',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(120, 115, 115, 1),
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0),
        ),
        body: DishStoryForm(
          dishName: dishName,
          dishCuisine: dishCuisine,
          dishAllergens: dishAllergens,
          isVeg: isVeg,
          ingredientsList: ingredientsList,
          recipesList: recipesList,
          newDishKey: newDishKey,
          newIngKey: newIngKey,
          ingController: ingController,
        ));
  }
}
