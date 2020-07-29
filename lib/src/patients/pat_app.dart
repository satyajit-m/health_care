import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/src/agents/home_agent/covid_od.dart';
import 'home_patient/home_page_pat.dart';
import 'home_patient/profile_page_pat.dart';

class PatApp extends StatefulWidget {
  PatAppState createState() {
    return PatAppState();
  }
}

class PatAppState extends State<PatApp> {
  void initState() {
    super.initState();
  }

  List<Widget> screens = [
    HomePagePat(key: PageStorageKey("HomePagePat")),
    //Locations(key: PageStorageKey("Locations")),
    CovidOD(key: PageStorageKey("CovidOD")),
    // MyOrders(user),
    ProfilePagePat(key: PageStorageKey("ProfilePagePat")),
  ];

  int bottomNavBarIndex = 0;

  void pageChanged(int index) {
    setState(() {
      bottomNavBarIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: ConnectivityWidgetWrapper(
        disableInteraction: true,
        message: intMsg,
        child: Scaffold(
          body: screens[bottomNavBarIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 10,
            showUnselectedLabels: true,
            selectedItemColor: Colors.green[600],
            unselectedItemColor: Colors.blueGrey[400],
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: IconThemeData(
              color: Colors.grey[400],
              opacity: 1.0,
            ),
            selectedIconTheme: IconThemeData(
              color: Colors.green[600],
              opacity: 1.0,
            ),
            onTap: (index) => pageChanged(index),
            currentIndex: bottomNavBarIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              //BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Locations')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.show_chart), title: Text('Covid-19')),

              // BottomNavigationBarItem(icon: Icon(Icons.view_list), title: Text('My Orders')),

              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile'))
            ],
          ),
        ),
      ),
    );
  }
}
