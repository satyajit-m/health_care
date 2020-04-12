import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';


class HomePageUsr extends StatefulWidget {
  HomePageUsr({Key key}) : super(key: key);

  @override
  HomePageUsrState createState() => HomePageUsrState();
}

class HomePageUsrState extends State<HomePageUsr> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();

  void dispose() {
    super.dispose();
  }

  HomePageUsrState() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40),
                  constraints: BoxConstraints.expand(height: 200),
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [lightBlueIsh,accentColor],
                          begin: const FractionalOffset(1.0, 1.0),
                          end: const FractionalOffset(0.2, 0.2),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome Back',
                          style: titleStyleWhite,
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 100),
                        constraints:
                            BoxConstraints.expand(height: 200, width: 250),
                        child: getprofileCard())),
                // Container(
                //   height: 330,
                //   margin: EdgeInsets.only(top: 300),
                //   padding: EdgeInsets.all(20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.only(top: 40),
                //         child: Text(
                //           "Explore New Opportunities",
                //           style: titileStyleBlack,
                //           ),
                //       ),
                //       Container(
                //         height: 280,
                //         child: ListView(
                //           children: getJobCategories(),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<String> jobCategories = [
    "Sales",
    "Engineering",
    "Health",
    "Education",
    "Finance"
  ];

  // Map jobCatToIcon = {
  //   "Sales" : Icon(Icons.monetization_on, color: lightBlueIsh, size: 50,),
  //   "Engineering" : Icon(Icons.settings, color: lightBlueIsh, size: 50),
  //   "Health" : Icon(Icons.healing, color: lightBlueIsh, size: 50),
  //   "Education" : Icon(Icons.search, color: lightBlueIsh, size: 50),
  //   "Finance" : Icon(Icons.card_membership, color: lightBlueIsh, size: 50),
  // };

  // Widget getCategoryContainer(String categoryName) {
  //   return new Container(
  //         margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
  //         height: 180,
  //         width: 140,
  //         padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(15)),
  //           boxShadow: [
  //             new BoxShadow(
  //               color: Colors.grey,
  //               blurRadius: 10.0,
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: <Widget>[
  //             Text(categoryName, style: titileStyleLighterBlack),
  //             Container(
  //               padding: EdgeInsets.only(top: 20),
  //               height: 80,
  //               width: 70,
  //               child: RaisedButton(

  //                 child:  jobCatToIcon[categoryName],
  //                 elevation: 10,
  //                 onPressed: () {

  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       );
}

// List<Widget> getJobCategories() {
//   List<Widget> jobCategoriesCards = [];
//   List<Widget> rows = [];
//   int i = 0;
//   for (String category in jobCategories) {
//     if (i < 2) {
//       rows.add(getCategoryContainer(category));
//       i ++;
//     } else {
//       i = 0;
//       jobCategoriesCards.add(new Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: rows,
//       ));
//       rows = [];
//       rows.add(getCategoryContainer(category));
//       i++;
//     }
//   }
//   if (rows.length > 0) {
//     jobCategoriesCards.add(new Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//         children: rows,
//       ));
//   }
//   return jobCategoriesCards;
// }

// List<Job> findJobs() {
//   List<Job> jobs = [];
//   for (int i = 0; i < 10; i++) {
//     jobs.add(new Job("Volvo", "Frontend Developer", 20000, "Remote", "Part time", new AssetImage("assets/logo/volvo.png")));
//   }
//   return jobs;
// }

// String makeSalaryToK(double salary) {
//   String money = "";
//   if (salary > 1000) {
//     if (salary > 100000000) {
//       salary = salary/100000000;
//       money = salary.toInt().toString() + "M";
//     } else {
//       salary = salary/1000;
//       money = salary.toInt().toString() + "K";
//     }
//   } else {
//     money = salary.toInt().toString();
//   }
//   return "\$" + money;
// }

Widget getprofileCard() {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
    height: 150,
    width: 200,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              child: Image.asset("assets/logo/volvo.png"),
            ),
            Text(
              'Name',
              style: jobCardTitileStyleBlue,
            )
          ],
        ),
        Text('Design', style: jobCardTitileStyleBlack),
      ],
    ),
  );
}
