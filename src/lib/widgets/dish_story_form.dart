import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../server/upload_images.dart';

class DishStoryForm extends StatefulWidget {
  final String dishName;
  final String dishCuisine;
  final String dishAllergens;
  final bool isVeg;
  final Map<String, Map<String, String>> ingredientsList;
  final List<String> recipesList;
  final GlobalKey<FormState> newDishKey;
  final GlobalKey<FormState> newIngKey;
  final TextEditingController ingController;

  DishStoryForm({
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
  _DishStoryFormState createState() => _DishStoryFormState();
}

class _DishStoryFormState extends State<DishStoryForm> {
  final newStoryKey = GlobalKey<FormState>();
  TextEditingController _storyController;
  String dishStory = '';

  @override
  void initState() {
    super.initState();
    _storyController = TextEditingController();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  void _trySubmit(String dishStory) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    DocumentReference documentReference =
        Firestore.instance.collection('dishInfo').document();
    documentReference.setData({
      'dishCat': widget.dishCuisine,
      'dishName': widget.dishName,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data['username'],
      'dishId': documentReference.documentID,
      'dishIngredients': widget.ingredientsList,
      'isVeg': widget.isVeg,
      'dishAllergens': widget.dishAllergens,
      'dishRecipe': widget.recipesList,
      'dishStory': dishStory,
      'status': 'PENDING',
    });

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                new MultiPicker(dishId: documentReference.documentID)),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: newStoryKey,
          child: TextFormField(
            controller: _storyController,
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
            onChanged: (value) {
              dishStory = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Story is required';
              }
              return null;
            },
          ),
        ),
        Row(children: [
        Padding(
        padding: EdgeInsets.only(left:70,right: 10, top: 100),
        child:ElevatedButton(
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
        ),),

    Padding(
    padding: EdgeInsets.only(left: 100, right: 20, top: 100),
    child:ElevatedButton(
            onPressed: () {
              if (newStoryKey.currentState.validate()) {
                newStoryKey.currentState.save();
              }
              _trySubmit(dishStory);

              widget.newDishKey.currentState.reset();
              // widget.newIngKey.currentState.reset();
              // widget.ingController.clear();
              newStoryKey.currentState.reset();
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
          ),),],)
      ],
    );
  }
}
