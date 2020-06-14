import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/src/forms/blocs/repo.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final _repo = Repo();
  String email1;
  //* "_" sets the instance variable to a private variable
  //NOTE: By default, streams are created as "single-subscription stream", but in this case and in most cases, we need to create "broadcast stream"
  //Note(con'd): because the email/password streams are consumed by the email/password fields as well as the combineLastest2 RxDart method
  //Note:(con'd): because we need to merge these two streams as one and get the lastest streams of both that are valid to enable the button state
  //Note:(con'd): Thus, below two streams are being consumed multiple times
  //* original single-subscription stream
  // final _emailController = StreamController<String>();
  // final _passwordController = StreamController<String>();

  //* Broadcast stream
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

  //* Replacing above Dart StreamController with RxDart BehaviourSubject (which is a broadcast stream by default)
  //NOTE: We are leveraging the additional functionality from BehaviorSubject to go back in time and retrieve the lastest value of the streams for form submission
  //NOTE: Dart StreamController doesn't have such functionality
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<String>();
  final _genderController = BehaviorSubject<String>();

  // final _address = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();

  //address
  final _pinController = BehaviorSubject<String>();
  final _areaController = BehaviorSubject<String>();
  final _blockController = BehaviorSubject<String>();
  final _cityController = BehaviorSubject<String>();
  final _districtController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<String>();

  //id
  final _gIdController = BehaviorSubject<String>();

  //Add Data To Stream
  Stream<String> get name => _nameController.stream.transform(validateName);
  Stream<String> get email => _emailController.stream;
  Stream<String> get phone => _phoneController.stream.transform(validatePhone);
  Stream<String> get date => _dateController.stream;
  Stream<String> get gender => _genderController.stream;

  Stream<String> get pin => _pinController.stream.transform(validatePin);
  Stream<String> get area => _areaController.stream;
  Stream<String> get block => _blockController.stream;
  Stream<String> get city => _cityController.stream;
  Stream<String> get district => _districtController.stream;
  Stream<String> get state => _stateController.stream;

  Stream<String> get gId => _gIdController.stream.transform(validateGID);

  Stream<bool> get showProgress => _showProgress.stream;

  Stream<bool> get firstSubmit =>
      Rx.combineLatest2(name, phone, (n, p) => true);

  //change data
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeDate => _dateController.sink.add;
  Function(String) get changeGender => _genderController.sink.add;

  Function(String) get changePin => _pinController.sink.add;
  Function(String) get changeArea => _areaController.sink.add;
  Function(String) get changeBlock => _blockController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changeDistrict => _districtController.sink.add;
  Function(String) get changeState => _stateController.sink.add;

  Function(String) get changeGID => _gIdController.sink.add;

  Bloc() {
    getEmail();
  }

  // Future<bool> submit() async {
  //   final validName = _nameController.value;
  //   final validEmail = _emailController.value;
  //   final validPhone = _phoneController.value;
  //   final validId = _gIdController.value;

  //   print(validName);
  // }

  // dispose() {
  //   _nameController.close();
  //   _emailController.close();
  //   _phoneController.close();
  //   _gIdController.close();
  // }

  void submit() async {
      _showProgress.sink.add(true);
    var data = new List<Map<String, String>>();
    data.add({
      'name': _nameController.value,
      'phone': _phoneController.value,
      'email': _emailController.value,
      'dob': _dateController.value,
      'gender': _genderController.value
    });
    data.add({
      'pincode': _pinController.value,
      'area': _areaController.value,
      'block': _blockController.value,
      'city': _cityController.value,
      'district': _districtController.value,
      'state': _stateController.value
    });

    data.add({'gid': _gIdController.value});

    await _repo.uploadAgent(data).then((value) {}).whenComplete(() {
      _showProgress.sink.add(false);
    });
    
  }

  Future insert() async {}

  void getEmail() async {
    final _auth = FirebaseAuth.instance;
    var user = await _auth.currentUser();
    email1 = user.email.toString();
    _emailController.sink.add(email1);
  }

  void dispose() async {
    _stateController.close();
    _districtController.close();
    _cityController.close();
    _blockController.close();
    _areaController.close();
    _pinController.close();
    //_emailController.close();

    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _gIdController.close();
    await _showProgress.drain();
    _showProgress.close();
  }
}
