import 'package:health_care/services/covid_api.dart';

class CovidModel {
  String dist;
  int dconf;
  int drecov;
  int dactive;

  int total;
  int active;
  int recov;
  int decs;

  CovidModel.fromMap(String d, Map<String, dynamic> cases)
      : dist = d,
        dconf = cases['delta'] != null ? (cases['delta']['confirmed'] ?? 0) : 0,
        drecov =
            cases['delta'] != null ? (cases['delta']['recovered'] ?? 0) : 0,
        total = cases['total'] != null ? (cases['total']['confirmed'] ?? 0) : 0,
      
        recov = cases['total'] != null ? (cases['total']['recovered'] ?? 0) : 0,
        decs = cases['total'] != null ? (cases['total']['deceased'] ?? 0) : 0;
        
}
