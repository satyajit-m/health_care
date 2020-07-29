import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HistoryModel {
  int alergy;
  int cold;
  int cough;
  String date;
  int fever;
  int headache;
  int ft;
  int inc;
  int indigestion;
  int status;
  String time;
  int kg;
  int gm;
  Timestamp stamp;

  HistoryModel.fromSnapshot(DocumentSnapshot snapshot)
      : alergy = snapshot['alergy']??0,
        cold = snapshot['cold']??0,
        cough = snapshot['cough']??0,
        date = snapshot['date'],
        fever = snapshot['fever']??0,
        headache = snapshot['headache']??0,
        ft = snapshot['height']['ft'],
        inc = snapshot['height']['inc'],
        indigestion = snapshot['indigestion']??0,
        stamp = snapshot['stamp'],
        status = snapshot['status'],
        time = snapshot['time'],
        kg = snapshot['weight']['kg'],
        gm = snapshot['weight']['gm'];
}
