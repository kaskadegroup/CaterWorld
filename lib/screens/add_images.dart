import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

class AddImagae extends StatefulWidget {
  static const routeName = '/add-image';

  @override
  _AddImagaeState createState() => _AddImagaeState();
}

class _AddImagaeState extends State<AddImagae> {
  File _storedImage1,
      _storedImage2,
      _storedImage3,
      _storedImage4,
      _storedImage5,
      _storedImage6;
  final addPhoto = 'assets/icons/Add Photo.svg';


  Future _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
      imageQuality: 50,
    );
    setState(() {
      _storedImage1 = File(imageFile.path);
    });
  }

  Future _uploadImage() async {
    final ref =
        FirebaseStorage.instance.ref().child('dish_image').child('dish2.png');
    await ref.putFile(_storedImage1).onComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Add Images",
          style: TextStyle(
            fontSize: 24,
            fontFamily: '.SF Pro Display',
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(120, 115, 115, 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(15),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage1 != null
                ? Image.file(
                    _storedImage1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage2 != null
                ? Image.file(
                    _storedImage2,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage3 != null
                ? Image.file(
                    _storedImage3,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage4 != null
                ? Image.file(
                    _storedImage4,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage5 != null
                ? Image.file(
                    _storedImage5,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: _storedImage6 != null
                ? Image.file(
                    _storedImage6,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : IconButton(
                    icon: SvgPicture.asset(addPhoto),
                    onPressed: _takePicture,
                  ),
          ),
        ],
      ),
      floatingActionButton: RaisedButton(
        onPressed: _uploadImage,
        child: Text("Upload"),
      ),
    );
  }
}
