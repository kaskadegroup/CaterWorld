
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//File imports

import '../screens/add_images.dart';

class AddDishForm extends StatefulWidget {
  @override
  _AddDishFormState createState() => _AddDishFormState();
}

class _AddDishFormState extends State<AddDishForm> {
  final _priceNode = FocusNode();
  //final _controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _dishName;
  String _dishCuisine;
  List _dishIngredients;
  String _dishAllergens;
  String _dishStory;
  String userId;

  void uploadImages(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AddImagae()));
  }

  List convertIngredientsList(value){
    return value.split(",");
  }
  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid){
      _formKey.currentState.save();
      final user = await FirebaseAuth.instance.currentUser();
      final userData = await Firestore.instance.collection('users').document(user.uid).get();
      // final dishId = FirebaseFirestore.instance.collection('dish_info').doc().id;
      Firestore.instance.collection('dish_info').add({
        'dish_cat': _dishCuisine,
        'dish_name': _dishName,
        'createdAt': Timestamp.now(),
        'dish_story': _dishStory,
        'userId': user.uid,
        'username': userData.data['username'],
        'Ingredients': _dishIngredients
        // 'dish_id': dishId,
        //'userImage': userData.data()['image_url']
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Name of the Dish, Change yo",
            ),
            TextFormField(
              key: ValueKey('Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Name of Dish'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceNode);
              },
              onSaved: (value) {
                _dishName = value;
              },
            ),
            TextFormField(
              key: ValueKey('Cuisine'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Cuisine is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Cuisine'),
              textInputAction: TextInputAction.next,
              focusNode: _priceNode,
              onSaved: (value) {
                _dishCuisine = value;
              },
            ),
            TextFormField(
              key: ValueKey('Ingredients'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingredients is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Add comma separated Ingredients'),
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                _dishIngredients = convertIngredientsList(value);
              },
              //focusNode: _priceNode,
            ),
            TextFormField(
              key: ValueKey('Allergens'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Allergens is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Allergens'),
              textInputAction: TextInputAction.next,
              //focusNode: _priceNode,
              onSaved: (value) {
                _dishAllergens = value;
              },
            ),
            TextFormField(
              key: ValueKey('Story'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Story is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Story'),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                _dishStory = value;
              },
              //focusNode: _priceNode,
            ),
            RaisedButton(
              child: Text('Upload Images'),
              onPressed: null,
              // onPressed: () => uploadImages(context),
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: _trySubmit,
            ),
          ],
        ),
      ),
    );
  }
}
