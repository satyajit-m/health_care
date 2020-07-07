import 'package:cloud_firestore/cloud_firestore.dart';


class UserProf {
  final Personal personal;
  final Address address;
  final Identity id;
  final bool verified;

  //Map<String, String> address;

  UserProf({this.personal, this.address, this.id, this.verified});

  factory UserProf.fromMap(DocumentSnapshot data) {
    data = data ?? {};

    return UserProf(
        personal: Personal.fromMap(data['personal']) ?? '',
        address: Address.fromMap(data['address']) ?? '',
        id: Identity.fromMap(data['identification']) ?? '',
        verified: data['verified']);
  }
}

class Personal {
  String name;
  String email;
  String phone;
  String dob;
  String gender;

  Personal({this.name, this.email, this.phone, this.dob, this.gender});

  factory Personal.fromMap(Map<String, dynamic> data) {
    data = data ?? '';

    return Personal(
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        dob: data['dob'],
        gender: data['gender']);
  }
}

class Address {
  String area;
  String block;
  String city;
  String district;
  String state;
  String pincode;

  Address(
      {this.area,
      this.block,
      this.city,
      this.district,
      this.state,
      this.pincode});

  factory Address.fromMap(Map<String, dynamic> data) {
    data = data ?? '';

    return Address(
        area: data['area'],
        block: data['block'],
        city: data['city'],
        district: data['district'],
        state: data['state'],
        pincode: data['pincode']);
  }
}

class Identity {
  String gid;

  Identity({this.gid});

  factory Identity.fromMap(Map<String, dynamic> data) {
    data = data ?? '';

    return Identity(gid: data['gid']);
  }
}
