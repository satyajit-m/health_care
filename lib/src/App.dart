import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:health_care/src/home/HomePageUsr.dart';
import 'package:health_care/src/home/HelpPage.dart';
import 'package:health_care/src/home/ProfilePage.dart';

import 'forms/UserForm.dart';

class App extends StatefulWidget {
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  void initState() {
    super.initState();
  }

  List<Widget> screens = [
    HomePageUsr(key: PageStorageKey("HomePageUsr")),
    //Locations(key: PageStorageKey("Locations")),
    UserForm(key: PageStorageKey("UserForm")),
    // MyOrders(user),
    ProfilePage(key: PageStorageKey("ProfilePage")),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int bottomNavBarIndex = 0;
  int pageControllerIndex = 0;

  void pageChanged(int index) {
    setState(() {
      bottomNavBarIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      pageControllerIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 10), curve: Curves.linear);
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index) => pageChanged(index),
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green[600],
          unselectedItemColor: Colors.lightGreen[200],
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(
            color: Colors.lightGreen[100],
            opacity: 1.0,
          ),
          selectedIconTheme: IconThemeData(
            color: Colors.green[600],
            opacity: 1.0,
          ),
          onTap: (index) => bottomTapped(index),
          currentIndex: bottomNavBarIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            //BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Locations')),
            BottomNavigationBarItem(
                icon: Icon(Icons.help), title: Text('Help')),

            // BottomNavigationBarItem(icon: Icon(Icons.view_list), title: Text('My Orders')),

            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
