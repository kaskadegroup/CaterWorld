import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, const Color(0xFFF7F0DD)],
                ),
              ),
            ),
            Positioned(
              child: AppBar(
                title: Transform(
                  transform: Matrix4.translationValues(-130, 0, 0),
                  child: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 34,
                        color: const Color(0xFF787373),
                        fontFamily: '.SF Pro Display',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
