class UserProf {
  String name;
  String phone;
  String dob;
  String gender;
  String idType;
  String idNum;
  //Map<String, String> address;

  UserProf(
      this.name, this.phone, this.dob, this.gender, this.idType, this.idNum);

  UserProf.fromMap(Map snapshot) {
    name = snapshot['name'] ?? '';
    phone = snapshot['phone'] ?? '';
    dob = snapshot['dob'] ?? '';
    gender = snapshot['gender'] ?? '';
    idType = snapshot['idType'] ?? '';
    idNum = snapshot['idNum'] ?? '';
    //name = snapshot['name'] ?? '';
  }

  toJson() {
    return {
      'name': name,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'idType': idType,
      'idNum': idNum,
      //'address': address,
    };
  }

  // set _name(String _name) {
  //   this.name = _name;
  // }

  // set name(String name){
  //   this._name = name;
  // }

  // set salary(double salary){
  //   this._salary = salary;
  // }

  // int get id => this._id;

  // String get _name => this.name;

  // double get salary => this._salary;
}
