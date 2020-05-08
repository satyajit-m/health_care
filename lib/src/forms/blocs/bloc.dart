import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
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

  //Add Data To Strem
  Stream<String> get name => _nameController.stream.transform(validateName);
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(name, email, (n, e) => true);

  //change data
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;

  submit() {
    final validName = _nameController.value;
    final validEmail = _emailController.value;

    print('Email is $validEmail, and password is $validName');
  }

  dispose() {
    _nameController.close();
    _emailController.close();
  }
}
