import 'package:flutter/material.dart';

import '../widgets/ingredients_field.dart';
import '../views/dish_story_view.dart';
import '../widgets/recipe_field.dart';

class IngredientsForm extends StatefulWidget {
  final String dishName;
  final String dishCuisine;
  final String dishAllergens;
  final bool isVeg;
  final GlobalKey<FormState> newDishKey;

  IngredientsForm({
    @required this.dishName,
    @required this.dishCuisine,
    @required this.dishAllergens,
    @required this.isVeg,
    @required this.newDishKey,
  });

  @override
  _IngredientsFormState createState() => _IngredientsFormState();
}

class _IngredientsFormState extends State<IngredientsForm> {
  final newIngKey = GlobalKey<FormState>();
  TextEditingController nameController;
  static List<String> ingredientsNameList = [null];
  static List<String> ingredientsqtyList = [null];
  static List<String> ingredientsUnitList = [null];
  static List<String> recipesList = [null];

  static Map<String, Map<String, String>> ingredientsList = {};

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _addRemoveIngredients(bool action, int index) {
    if (action) {
      ingredientsNameList.insert(index + 1, null);
      ingredientsqtyList.insert(index + 1, null);
      ingredientsUnitList.insert(index + 1, null);
    } else {
      ingredientsNameList.removeAt(index);
      ingredientsqtyList.removeAt(index);
      ingredientsUnitList.removeAt(index);
    }
    setState(() {});
  }

  void _addRemoveRecipe(bool action, int index) {
    if (action) {
      recipesList.insert(index + 1, null);
    } else
      recipesList.removeAt(index);
    setState(() {});
  }

  List<Widget> _getNewIngredientsFields() {
    List<Widget> ingredientsTextFields = [];
    for (int i = 0; i < ingredientsNameList.length; i++) {
      ingredientsTextFields.add(
        Row(
          children: [
            Flexible(
              flex: 4,
              child: IngredientsTextFields(
                index: i,
                ingredientsNameList: ingredientsNameList,
                ingredientsQtyList: ingredientsqtyList,
                ingredientsUnitList: ingredientsUnitList,
              ),
            ),
            Flexible(
              flex: 1,
              child: ClipOval(
                child: ElevatedButton(
                  onPressed: () => _addRemoveIngredients(
                      i == ingredientsNameList.length - 1, i),
                  child: i == (ingredientsNameList.length - 1)
                      ? Text("+")
                      : Text("-"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF787373),
                    minimumSize: Size(10, 45),
                    enableFeedback: true,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color(0xDBDAD6),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return ingredientsTextFields;
  }

  List<Widget> _getNewRecipeFields() {
    List<Widget> recipesTextFields = [];
    for (int i = 0; i < recipesList.length; i++) {
      recipesTextFields.add(
        Row(
          children: [
            Flexible(
              flex: 4,
              child: RecipeField(
                index: i,
                recipesList: recipesList,
              ),
            ),
            Flexible(
              flex: 1,
              child: ClipOval(
                child: ElevatedButton(
                  onPressed: () =>
                      _addRemoveRecipe(i == recipesList.length - 1, i),
                  child: i == (recipesList.length - 1) ? Text("+") : Text("-"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF787373),
                    enableFeedback: true,
                    minimumSize: Size(10, 45),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color(0xDBDAD6),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return recipesTextFields;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: newIngKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Text(
              "Add Ingredients *",
              style: TextStyle(
                fontSize: 18,
                fontFamily: '.SF Pro Display',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(120, 115, 115, 1),
              ),
            ),
          ),
          ..._getNewIngredientsFields(),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "How do you make this dish? *",
              style: TextStyle(
                fontSize: 18,
                fontFamily: '.SF Pro Display',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(120, 115, 115, 1),
              ),
            ),
          ),
          ..._getNewRecipeFields(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 70, right: 10, top: 100),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF787373),
                    minimumSize: Size(10, 50),
                    enableFeedback: true,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color(0xDBDAD6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, right: 20, top: 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (newIngKey.currentState.validate()) {
                      newIngKey.currentState.save();
                    }

                    for (int i = 0; i < ingredientsNameList.length; i++) {
                      ingredientsList[ingredientsNameList[i].toString()] = {
                        'Qty': ingredientsqtyList[i].toString(),
                        'Unit(s)': ingredientsUnitList[i].toString()
                      };
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DishStory(
                          dishName: widget.dishName,
                          dishCuisine: widget.dishCuisine,
                          dishAllergens: widget.dishAllergens,
                          isVeg: widget.isVeg,
                          recipesList: recipesList,
                          ingredientsList: ingredientsList,
                          newDishKey: widget.newDishKey,
                          newIngKey: newIngKey,
                          ingController: nameController,
                        ),
                      ),
                    );
                    newIngKey.currentState.reset();
                    nameController.clear();
                  },
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF787373),
                    minimumSize: Size(10, 50),
                    enableFeedback: true,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: '.SF Pro Display',
                      fontWeight: FontWeight.w500,
                      color: Color(0xDBDAD6),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
