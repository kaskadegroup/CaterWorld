//import packages
import 'package:flutter/material.dart';

//import files
import '../models/add_dish_form.dart';

class AddDishScreen extends StatefulWidget {
  @override
  _AddDishScreenState createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  @override
  Widget build(BuildContext context) {
    return AddDishForm();
  }
}
