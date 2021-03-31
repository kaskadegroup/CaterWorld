//package import
import 'package:flutter/material.dart';

//file import
import '../widgets/ingredients_form.dart';

class AddIngredients extends StatelessWidget {
  final String dishName;
  final String dishCuisine;
  final String dishAllergens;
  final bool isVeg;
  final GlobalKey<FormState> newDishKey;

  AddIngredients({
    @required this.dishName,
    @required this.dishCuisine,
    @required this.dishAllergens,
    @required this.isVeg,
    @required this.newDishKey,
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
      body: IngredientsForm(
        dishName: dishName,
        dishCuisine: dishCuisine,
        dishAllergens: dishAllergens,
        isVeg: isVeg,
        newDishKey: newDishKey,
      ),
    );
  }
}
