class CovidModel {
  CovidToday today;
  List<CovidDists> dists = [];
  CovidTotal total;
  String updAt;
  CovidModel();

  CovidModel.fromMap(Map<String, dynamic> odisha) {
    today = CovidToday.fromMap(odisha['delta']);
    var listDist = odisha['districts'];
    listDist.forEach((k, v) {
      if (k == "Others" || k == "Unknown" || k== "State Pool") {
      } else {
        CovidDists covidDists = new CovidDists.fromMap(k, v);
        covidDists.active =
            covidDists.confirmed - covidDists.recov - covidDists.decs;
        covidDists.dactive =
            covidDists.dconf - covidDists.drecov - covidDists.ddeceased;
        dists.add(covidDists);
      }
    });
    dists.sort((a, b) => (b.active).compareTo(a.active));

    total = CovidTotal.fromMap(odisha['total']);
    updAt = odisha['meta']['last_updated'];
  }
}

class CovidToday {
  int confirmed;
  int deceased;
  int recovered;
  int active;

  CovidToday.fromMap(Map<String, dynamic> data)
      : confirmed = data['confirmed'] ?? 0,
        deceased = data['deceased'] ?? 0,
        recovered = data['recovered'] ?? 0;
}

class CovidDists {
  String dist;
  int dconf;
  int drecov;
  int dactive;
  int ddeceased;

  int confirmed;
  int active;
  int recov;
  int decs;

  CovidDists.fromMap(String d, Map<String, dynamic> cases)
      : dist = d,
        dconf = cases['delta'] != null ? (cases['delta']['confirmed'] ?? 0) : 0,
        drecov =
            cases['delta'] != null ? (cases['delta']['recovered'] ?? 0) : 0,
        ddeceased =
            cases['delta'] != null ? (cases['delta']['deceased'] ?? 0) : 0,
        confirmed =
            cases['total'] != null ? (cases['total']['confirmed'] ?? 0) : 0,
        recov = cases['total'] != null ? (cases['total']['recovered'] ?? 0) : 0,
        decs = cases['total'] != null ? (cases['total']['deceased'] ?? 0) : 0;
}

class CovidTotal {
  int confirmed;
  int deceased;
  int recovered;
  int active;

  CovidTotal.fromMap(Map<String, dynamic> data)
      : confirmed = data['confirmed'] ?? -1,
        deceased = data['deceased'] ?? -1,
        recovered = data['recovered'] ?? -1;
}
