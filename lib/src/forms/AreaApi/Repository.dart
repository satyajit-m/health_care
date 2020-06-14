import 'AreaModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final addr = new Map<String, dynamic>();

Future<Map<String, dynamic>> fetchArea(String pin) async {
  final response =
      await http.get('https://api.postalpincode.in/pincode/' + pin);
  final jsonresponse = json.decode(response.body);

  List<AreaModel> area = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    Map<String, dynamic> parsedJson = jsonresponse[0];
    var list = parsedJson['PostOffice'] as List;

    for (var u in list) {
      AreaModel ar = AreaModel(u['Name']);
      area.add(ar);
    }
    //var addr = new Map();
    addr['ar'] = area;
    addr['state'] = list[0]['State'];
    addr['district'] = list[0]['District'];
    addr['block'] = list[0]['Block'];
    addr['divison'] = list[0]['Division'];
    //print(addr);
    return addr;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Area');
  }

  Map<String, dynamic> fetch_adr() {
    return addr;
  }
}
