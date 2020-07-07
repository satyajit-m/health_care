import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care/auth/patient/widgets/countdown.dart';
import 'package:health_care/const/color_const.dart';


import 'package:health_care/const/route_constants.dart';
import 'package:health_care/services/router_models.dart';

class Otp {
  static const int showNothing = 0;
  static const int showTimer = 1;
  static const int showRetryButton = 2;
}

class OtpPage extends StatefulWidget {
  final OtpPageData data;
  OtpPage(this.data);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with TickerProviderStateMixin {

  static const int otpTimeout = 10;

  ValueNotifier<int> _showRetryButton = ValueNotifier(Otp.showNothing);
  TextEditingController otpController = TextEditingController();
  AnimationController _controller;
  ValueNotifier<String> _otpError = ValueNotifier("");

  String verificationId = '';

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: otpTimeout),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showRetryButton.value = Otp.showRetryButton;
      }
    });
    verifyPhone(context);
    super.initState();
  }

  @override
  void dispose() {
    _showRetryButton.dispose();
    otpController.dispose();
    _controller.dispose();
    _otpError.dispose();
    super.dispose();
  }

  void logIn(AuthCredential credential) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((currentUser) async {
        FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

        if (currentUser != null) {
          String otp = autoFillAutoOtp(credential);
          print(otp);
          if (otpController.text.length == 0) {
            otpController.text = otp;
          }
          success();
          // await createUserDb(firebaseUser);

        } else {
          _otpError.value = "Something went wrong";
        }
      });
    } on PlatformException catch (error) {
      Navigator.of(context, rootNavigator: true).pop();
      if (error.message.contains(
          "The sms verification code used to create the phone auth credential is invalid")) {
        _otpError.value = "Incorrect OTP";
      } else if (error.message.contains("The sms code has expired")) {
        _otpError.value = "This sms code has expired";
      }
    }
  }

  void success() async {
    assert(widget.data.next != null);

    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).popUntil((route) => route.isFirst);

    Navigator.pushReplacementNamed(context, PatHomeRoute);
  }

  Future<void> verifyPhone(BuildContext context) async {
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        _showRetryButton.value = Otp.showTimer;
        _controller.forward(from: 0);
      };

      final PhoneVerificationCompleted verifiedSuccess =
          (AuthCredential credential) async {
        logIn(credential);
      };

      final PhoneVerificationFailed veriFailed = (AuthException exception) {
        _otpError.value = "Verification Failed";
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.data.number,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: otpTimeout),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed,
      );
    } catch (e) {
      _otpError.value = ":(, Verification via Phone failed.";
    }
  }

  void failed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(227, 227, 227, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: height * 0.30,
                              maxWidth: width,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(
                              'assets/img/mobile_login.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Mobile Verification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Waiting to automatically detect an SMS sent to ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.data.number,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          height: height * 0.10,
                          padding: EdgeInsets.all(10),
                          child: ValueListenableBuilder(
                            valueListenable: _showRetryButton,
                            builder: (BuildContext context, int snapshot,
                                Widget child) {
                              if (snapshot == Otp.showRetryButton) {
                                return RaisedButton(
                                  onPressed: () => verifyPhone(context),
                                  child: Text("Resend OTP"),
                                );
                              } else if (snapshot == Otp.showTimer) {
                                return Countdown(
                                  animation: new StepTween(
                                    begin: otpTimeout,
                                    end: 0,
                                  ).animate(_controller),
                                );
                              }
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 40,
                          constraints: BoxConstraints(maxWidth: 500),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: _otpError,
                            builder: (BuildContext context, String error,
                                Widget child) {
                              return TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  counterText: "",
                                  hintText: "Enter 6-digit code",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3),
                                    ),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorText: error.length == 0 ? null : error,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly,
                                ],
                                controller: otpController,
                                maxLength: 6,
                                maxLengthEnforced: true,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                onChanged: (newVal) {
                                  if (newVal.length != 6) {
                                    _otpError.value =
                                        "Please enter the 6 digit OTP";
                                  } else {
                                    _otpError.value = "";
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _otpError,
                          builder: (BuildContext context, String error,
                              Widget child) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              constraints: BoxConstraints(maxWidth: 500),
                              child: RaisedButton(
                                onPressed: (error.length != 0 ||
                                        otpController.text.length != 6)
                                    ? null
                                    : otpMatch,
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Done',
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          // color: accentColor,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void otpMatch() {
    _showLoader();
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: this.verificationId,
      smsCode: otpController.text,
    );
    logIn(credential);
  }

  /*
    CAUTION! May Break in future updates made to Firebase.
    So I wrapped it in a try catch block.
  */
  String autoFillAutoOtp(AuthCredential credential) {
    try {
      String credentialString = credential.toString();

      // 3 lines below will break this feature
      String tokenBeforeOTP = '"zzb":"';
      int otpLength = 6;
      int otpIndex =
          credentialString.indexOf(tokenBeforeOTP) + tokenBeforeOTP.length;

      String otpFromCredential =
          credentialString.substring(otpIndex, otpIndex + otpLength);
      return otpFromCredential;
    } catch (e) {
      return "";
    }
  }

  Future<void> createUserDb(FirebaseUser currentUser) async {
    print("PHONE NUMBER : " + currentUser.phoneNumber);
    if (currentUser != null) {
      _showLoader();
      Map<String, dynamic> data = {};
      DocumentReference dbUserRef =
          Firestore.instance.collection("users").document(currentUser.uid);
      await dbUserRef.setData(data, merge: true);
      // Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> _showLoader() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 40,
                ),
                Text("Verifying"),
              ],
            ),
          ),
        );
      },
    );
  }
}
