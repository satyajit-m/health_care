import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/UserProf.dart';

class ExistSearch extends StatefulWidget {
  @override
  _ExistSearchState createState() => _ExistSearchState();
}

class _ExistSearchState extends State<ExistSearch> {
  List<UserProf> userprof = new List<UserProf>();
  bool fetched = false;
  List<UserProf> filteredNames = new List<UserProf>();
  String _searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDocs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RawMaterialButton(
                          elevation: 0.0,
                          child: Icon(Icons.arrow_back_ios,color: darkGreen,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          constraints: BoxConstraints.tightFor(
                            width: 40.0,
                            height: 40.0,
                          ),
                          shape: CircleBorder(),
                          fillColor: Colors.white24),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Patient Search',
                        style: GoogleFonts.roboto(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.8,
                  child: fetched == true
                      ? SearchBar<UserProf>(
                          debounceDuration: Duration(milliseconds: 700),
                          cancellationWidget: Icon(
                            Icons.cancel,
                            size: 30,
                            color: Colors.black,
                          ),
                          hintText: 'Search',
                          placeHolder:
                              Center(child: Text('Enter Patient Phone')),
                          minimumChars: 3,
                          emptyWidget: Center(child: Text("No Patient Found")),
                          loader: CircularProgressIndicator(),
                          searchBarStyle:
                              SearchBarStyle(backgroundColor: Colors.grey[200]),
                          onSearch: search,
                          onItemFound: (UserProf prof, int index) {
                            return Material(
                              type: MaterialType.transparency,
                              elevation: 6.0,
                              color: Colors.transparent,
                              shadowColor: Colors.grey[50],
                              child: InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PatientViewRoute,
                                        arguments: prof);
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[50]),
                                      child: Icon(
                                        Icons.person_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                    title: Text(prof.personal.phone,
                                        style: TextStyle(color: Colors.black)),
                                    subtitle: Text(
                                      prof.personal.name,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    trailing: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[50]),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ]),
        ),
      ),
    );
  }

  Future fetchDocs() async {
    QuerySnapshot snap =
        await Firestore.instance.collection('users').getDocuments();

    for (int i = 0; i < snap.documents.length; i++) {
      var a = snap.documents[i];
      userprof.add(UserProf.fromMap(a));
    }

    setState(() {
      fetched = true;
    });
  }

  Future<List<UserProf>> search(String s) async {
    if (s.isNotEmpty) {
      List<UserProf> tempList = new List<UserProf>();
      for (int i = 0; i < userprof.length; i++) {
        if ((userprof[i].personal.phone).contains(s.toLowerCase())) {
          tempList.add(userprof[i]);
        }
      }
      return tempList;
    }
  }
}
