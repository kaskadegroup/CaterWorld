//import packages
import 'package:flutter/material.dart';
import 'package:toastea/views/add_ingredients.dart';

//import files


class NewDishForm extends StatefulWidget {
  @override
  _NewDishFormState createState() => _NewDishFormState();
}

class _NewDishFormState extends State<NewDishForm> {
  final _newDishKey = GlobalKey<FormState>();

  String _dishName = '';
  String _dishCuisine = '';
  String _dishAllergens = '';
  String _servingSize = '';
  String _prepTime = '';
  bool isVeg = false;

  List convertIngredientsList(value) {
    return value.split(",");
  }

  void addIngredients(BuildContext context) {
    final isValid = _newDishKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _newDishKey.currentState?.save();
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => AddIngredients(
            dishName: _dishName,
            dishCuisine: _dishCuisine,
            dishAllergens: _dishAllergens,
            isVeg: isVeg,
            newDishKey: _newDishKey,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: Form(
          key: _newDishKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey('Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name of Dish',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   _addDishFormNode.nextFocus();
                  // },
                  onSaved: (value) {
                    _dishName = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey('Cuisine'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cuisine is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Cuisine',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _dishCuisine = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey('Allergens'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Allergens is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Allergens',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _dishAllergens = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey('Serving Size'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Serving size is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Serving Size',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _servingSize = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey('Prep Time'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Preparation time is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Preparation Time',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _prepTime = value!;
                  },
                ),
              ),
              CheckboxListTile(
                  title: const Text('Is this dish Vegetarian ?'),
                  value: isVeg,
                  onChanged: (val) {
                    setState(() {
                      isVeg = val!;
                    });
                  }),
              Padding(
                padding: EdgeInsets.all(100),
                child: ElevatedButton(
                  child: Text('Next'),
                  onPressed: () {
                    addIngredients(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF787373),
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
          ),
        ),
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
    );
  }
}
