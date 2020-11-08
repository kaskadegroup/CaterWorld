//Ios Home Screen

//Package Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

//File Imports
import '../models/meal_item.dart';
import '../models/dummy-data.dart';

class IosHome extends StatelessWidget {
  final String home;
  final String addNew;
  final String favDish;
  final String burgMenu;
  final String filterMenu;
  final String categoryTitle;
  final categoryMeals;

  IosHome(
    this.home,
    this.addNew,
    this.favDish,
    this.burgMenu,
    this.filterMenu,
    this.categoryTitle,
    this.categoryMeals,
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Color.fromRGBO(120, 115, 115, 0.5),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(home),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(favDish),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(addNew),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(burgMenu),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              child: Container(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      CupertinoSliverNavigationBar(
                        largeTitle: Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: '.SF Pro Display',
                            color: Color.fromRGBO(120, 115, 115, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: SvgPicture.asset(filterMenu),
                        border: null,
                        backgroundColor: Color.fromRGBO(251, 252, 249, 1),
                      ),
                    ];
                  },
                  body: ListView.builder(
                    itemCount: DUMMY_MEALS.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealItem(
                        id: 'm1',
                        title: 'Spaghetti',
                        categories: 'Italian',
                        imageUrl: "lol",
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      const Color(0xFFF7F0DD),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
