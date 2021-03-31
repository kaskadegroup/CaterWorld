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
                        : Text("-")),
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
                    child:
                        i == (recipesList.length - 1) ? Text("+") : Text("-")),
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
          Text("Add Ingredients *"),
          ..._getNewIngredientsFields(),
          Text("How do you make this dish? *"),
          ..._getNewRecipeFields(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Back"),
              ),
              ElevatedButton(
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
