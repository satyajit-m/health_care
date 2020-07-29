import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/const/size_config.dart';

import 'package:health_care/core/models/UserProf.dart';
import 'package:health_care/src/forms/blocs/firestore_provider.dart';

class ProfilePageAgent extends StatefulWidget {
  ProfilePageAgent({Key key}) : super(key: key);

  @override
  ProfilePageAgentState createState() => ProfilePageAgentState();
}

class ProfilePageAgentState extends State<ProfilePageAgent> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    // TODO: implement build
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        child: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            color: lightBlueIsh,
          ),
        ),
      ),
      Container(
        child: FutureBuilder(
            future: getEmail(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none &&
                  projectSnap.hasData == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder(
                stream: getUserDetails(projectSnap.data),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    UserProf prof = UserProf.fromMap(snapshot.data);

                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                        ),
                        Center(
                            child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.person_pin,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              prof.personal.name,
                              style: titleStyleWhite,
                            ),
                            //  SizedBox(height: 10,),
                            // Text(
                            //   prof.personal.email,
                            //   style: subStyleWhite,
                            // ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              prof.personal.email,
                              style: subStyleWhite,
                            ),
                          ],
                        )),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.1,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: prof.verified == true
                                ? Colors.green[50]
                                : Colors.red[50],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              prof.verified == true
                                  ? verifiedGreenIcon
                                  : cancelRedIcon,
                              SizedBox(
                                width: 15,
                              ),
                              prof.verified == true
                                  ? verifiedText
                                  : notVerifiedText,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        //Personal
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue[50]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue[100]),
                                child: Text(
                                  'Personal',
                                  style: GoogleFonts.ptSans(
                                      fontSize: 20, color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Phone No. : ${prof.personal.phone}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Date Of Birth : ${prof.personal.dob}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Gender : ${prof.personal.gender}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        //Address
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepOrange[50]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.deepOrange[100]),
                                child: Text(
                                  'Address',
                                  style: GoogleFonts.ptSans(
                                      fontSize: 20, color: Colors.deepOrange),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Area. : ${prof.address.area}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Block : ${prof.address.block}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'City : ${prof.address.city}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'District : ${prof.address.district}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'State : ${prof.address.state}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Pincode : ${prof.address.pincode}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        //ID
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepPurple[50]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.deepPurple[100]),
                                child: Text(
                                  'Identitification',
                                  style: GoogleFonts.ptSans(
                                      fontSize: 20, color: Colors.deepPurple),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Govt. ID : ${prof.id.gid}',
                                      style: profileContent,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Material(
                          color: Colors.white.withOpacity(0.0),
                          child: InkWell(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(
                                  context, LoginRoute);
                            },
                            child: Ink(
                              color: Colors.blue,
                              child: Container(
                                color: Colors.grey[100],
                                child: ListTile(
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[50]),
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.red,
                                    ),
                                  ),
                                  title: Text('LogOut',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[50]),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }
                },
              );
            }),
      ),
    ]));
  }

  Future getEmail() async {
    final auth = FirebaseAuth.instance;
    var user = await auth.currentUser();
    return user.email;
  }

  getUserDetails(String email) {
    dynamic snapData =
        Firestore.instance.collection('admin').document(email).snapshots();
    return snapData;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2 - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height / 2 - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
