//package import
import 'package:flutter/material.dart';

class IngredientsTextFields extends StatefulWidget {
  final int index;
  final List<String> ingredientsNameList;
  final List<String> ingredientsQtyList;
  final List<String> ingredientsUnitList;
  IngredientsTextFields(
      {@required this.index,
      @required this.ingredientsNameList,
      @required this.ingredientsQtyList,
      @required this.ingredientsUnitList});
  @override
  _IngredientsTextFieldsState createState() => _IngredientsTextFieldsState();
}

class _IngredientsTextFieldsState extends State<IngredientsTextFields> {
  String dropdownValue = 'Unit';

  TextEditingController _nameController;
  TextEditingController _qtyController;
  TextEditingController _unitController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _qtyController = TextEditingController();
    _unitController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.ingredientsNameList[widget.index] ?? '';
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _qtyController.text = widget.ingredientsQtyList[widget.index] ?? '';
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _unitController.text = widget.ingredientsUnitList[widget.index] ?? '';
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: TextFormField(
              controller: _nameController,
              onChanged: (v1) => widget.ingredientsNameList[widget.index] = v1,
              validator: (v1) {
                if (v1.trim().isEmpty) return 'Ingredients are required';
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: _qtyController,
              onChanged: (v2) => widget.ingredientsQtyList[widget.index] = v2,
              validator: (v2) {
                if (v2.trim().isEmpty) return 'Qty is required';
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Qty',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: _unitController,
              onChanged: (v3) => widget.ingredientsUnitList[widget.index] = v3,
              validator: (v3) {
                if (v3.trim().isEmpty) return 'Unit is required';
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Unit',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),

            //DropdownButton<String>(
            //   value: dropdownValue,
            //   iconSize: 20,
            //   elevation: 0,
            //   style: TextStyle(color: Colors.grey),
            //   onChanged: (newValue) {
            //     setState(() {
            //       dropdownValue = newValue;
            //     });
            //   },
            //   items: <String>['Unit', 'Tsp', 'Tbsp', 'Cups']
            //       .map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
          ),
        ],
      ),
    );
  }
}
