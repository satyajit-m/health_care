import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';

import 'home_agent/covid_od.dart';
import 'home_agent/home_page_agent.dart';
import 'home_agent/profile_page_agent.dart';

class AgentApp extends StatefulWidget {
  AgentAppState createState() {
    return AgentAppState();
  }
}

class AgentAppState extends State<AgentApp> {
  void initState() {
    super.initState();
  }

  List<Widget> screens = [
    HomePageAgent(key: PageStorageKey("HomePageUsr")),
    //Locations(key: PageStorageKey("Locations")),
    CovidOD(key: PageStorageKey("HelpPage")),
    // MyOrders(user),
    ProfilePageAgent(key: PageStorageKey("ProfilePage")),
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
