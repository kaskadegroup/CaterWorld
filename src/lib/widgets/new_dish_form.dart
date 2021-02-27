//import packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import files

import '../server/upload_images.dart';

class NewDishForm extends StatefulWidget {
  @override
  _NewDishFormState createState() => _NewDishFormState();
}

class _NewDishFormState extends State<NewDishForm> {
  final _priceNode = FocusNode();
  //final _controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _dishName;
  String _dishCuisine;
  List _dishIngredients;
  String _dishAllergens;
  String _dishStory;
  String userId;
  bool isVeg = false;

  List convertIngredientsList(value) {
    return value.split(",");
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      final user = await FirebaseAuth.instance.currentUser();
      final userData =
          await Firestore.instance.collection('users').document(user.uid).get();
      DocumentReference documentReference =
          Firestore.instance.collection('dishInfo').document();
      documentReference.setData({
        'dishCat': _dishCuisine,
        'dishName': _dishName,
        'createdAt': Timestamp.now(),
        'dishStory': _dishStory,
        'userId': user.uid,
        'username': userData.data['username'],
        'dishId': documentReference.documentID,
        'Ingredients': _dishIngredients,
        'isVeg': isVeg,
        'dishAllergens': _dishAllergens,
        'status': false,
      });

      _formKey.currentState.reset();
      uploadImages(context, documentReference.documentID);
    }
  }

  void uploadImages(BuildContext context, dishId) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MultiPicker(
                  dishId: dishId,
                )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey('Name'),
                validator: (value) {
                  if (value.isEmpty) {
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
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceNode);
                },
                onSaved: (value) {
                  _dishName = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey('Cuisine'),
                validator: (value) {
                  if (value.isEmpty) {
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
                focusNode: _priceNode,
                onSaved: (value) {
                  _dishCuisine = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey('Ingredients'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ingredients is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Add comma separated Ingredients',
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
                  _dishIngredients = convertIngredientsList(value);
                },
                //focusNode: _priceNode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey('Allergens'),
                validator: (value) {
                  if (value.isEmpty) {
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
                //focusNode: _priceNode,
                onSaved: (value) {
                  _dishAllergens = value;
                },
              ),
            ),
            CheckboxListTile(
                title: const Text('Is this dish Vegetarian ?'),
                value: isVeg,
                onChanged: (val) {
                  setState(() {
                    isVeg = val;
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey('Story'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Story is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Story',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _dishStory = value;
                },

                //focusNode: _priceNode,
              ),
            ),
            SizedBox(
              height: 20,
              width: 40,
              child: RaisedButton(
                //shape: ,
                child: Text('Submit'),
                onPressed: _trySubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
