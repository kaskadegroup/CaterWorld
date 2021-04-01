import 'package:flutter/material.dart';

class RecipeField extends StatefulWidget {
  final int index;
  final List<String> recipesList;

  RecipeField({
    @required this.index,
    @required this.recipesList,
  });
  @override
  _RecipeFieldState createState() => _RecipeFieldState();
}

class _RecipeFieldState extends State<RecipeField> {
  TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.recipesList[widget.index] ?? '';
    });

    return Padding(padding: EdgeInsets.only(left:10, right: 5, bottom: 10, top: 10),
    child:TextFormField(
      controller: _nameController,
      onChanged: (v) => widget.recipesList[widget.index] = v,
      validator: (v) {
        if (v.trim().isEmpty) return 'Recipe is required';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Recipe',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    )
    );
  }
}
