import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 5) {
      sink.add(name);
    } else {
      sink.addError(
          'Invalid Name, please enter Full Name more than 5 characters');
    }
  });

  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length == 10) {
      sink.add(phone);
    } else {
      sink.addError('Please enter 10digit phone no.');
    }
  });

  final validatePin =
      StreamTransformer<String, String>.fromHandlers(handleData: (pin, sink) {
    if (pin.length == 6) {
      sink.add(pin);
    } else {
      sink.addError('Enter 6digit pin Code');
    }
  });

  final validateGID =
      StreamTransformer<String, String>.fromHandlers(handleData: (gID, sink) {
    if (gID.length == 10) {
      sink.add(gID);
    } else {
      sink.addError('Please enter 10digit ID number');
    }
  });
}
