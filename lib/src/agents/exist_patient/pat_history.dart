import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/const/size_config.dart';

import 'package:health_care/core/models/pat_his_model.dart';
import 'package:shimmer/shimmer.dart';

Widget patHistory(BuildContext context, String phone) {
  return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(phone)
          .collection('health')
          .orderBy('stamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: ListTile(
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      title: Container(
                          width: SizeConfig.screenWidth * 0.5,
                          height: 10,
                          color: Colors.white),
                      subtitle: Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.screenWidth * 0.3),
                          width: 50,
                          height: 10,
                          color: Colors.white),
                      trailing: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 4),
          );
        } else {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          if (documents.length == 0) {
            return Container(
              height: SizeConfig.screenHeight * 0.3,
              child: Center(
                child: Text('No Previous Records Found'),
              ),
            );
          }
          List<HistoryModel> model = [];
          snapshot.data.documents.forEach((element) {
            model.add(HistoryModel.fromSnapshot(element));
          });

          return ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PatHisDetRoute, arguments: model[index]);
                  },
                  splashColor: Colors.grey,
                  child: ListTile(
                    leading: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue[50]),
                      child: Icon(
                        model[index].status > 1
                            ? (model[index].status > 2
                                ? Icons.error
                                : Icons.error_outline)
                            : Icons.check_circle_outline,
                        color: model[index].status > 1
                            ? (model[index].status > 2
                                ? Colors.redAccent
                                : Colors.orange)
                            : Colors.green,
                      ),
                    ),
                    title: Text(model[index].date),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: Text('Status : ')),
                        Expanded(
                          flex: 2,
                          child: model[index].status > 1
                              ? (model[index].status > 2
                                  ? FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(' Urgent Care Needed ',
                                          style: TextStyle(
                                              color: Colors.redAccent)),
                                    )
                                  : Text(
                                      ' Care Needed ',
                                      style: TextStyle(color: Colors.orange),
                                    ))
                              : Text(
                                  'Good',
                                  style: TextStyle(color: Colors.green),
                                ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(model[index].time))),
                      ],
                    ),
                    trailing: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue[50]),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: documents.length);
        }
      });
}
