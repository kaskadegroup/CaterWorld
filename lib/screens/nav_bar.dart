
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


//Import Files
import 'add_dish_screen.dart';
//import 'ios_homev2.dart';
import 'dish_info.dart';
import 'likes_screen.dart';
//import '../providers/meal.dart';
//import 'auth_screen.dart';
import 'user_settings.dart';

class NavBar extends StatefulWidget {
  

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final String home = 'assets/icons/Home.svg';
  final String favDish = 'assets/icons/Union.svg';
  final String addNew = 'assets/icons/Add.svg';
  final String burgMenu = 'assets/icons/Hamburger Menu.svg';
  //final String filterMenu = 'assets/icons/Meatball Menu.svg';

  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': DishInfo(

          
          //widget.toggleFavorite,
          //widget.isMealFavorite,
        ),
        'title': 'Home',
      },
      {
        'page': LikesScreen(),
        'title': 'Likes',
      },
      {
        'page': AddDishScreen(),
        'title': 'Add a Dish',
      },
      {
        'page': UserSettings(),
        'title': 'Settings',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(37),
        child: AppBar(
          centerTitle: false,
          title: Text(
            _pages[_selectedPageIndex]['title'],
            style: TextStyle(
              fontSize: 34,
              fontFamily: '.SF Pro Display',
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(120, 115, 115, 1),
            ),
            textAlign: TextAlign.justify,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: SizedBox(
        height: 88,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(home,height: 30,),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(favDish,height: 30,),
              label: "fav",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(addNew,height: 30,),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(burgMenu,height: 30,),
              label: "set",
            )
          ],
        ),
      ),
    );
  }
}
