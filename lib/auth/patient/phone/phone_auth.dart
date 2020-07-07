import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/services/Dialogs.dart';
import 'package:health_care/services/router_models.dart';

class PhoneLogin extends StatefulWidget {
  final Destination data;

  const PhoneLogin({Key key, @required this.data}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController phoneController = TextEditingController();

  ValueNotifier<bool> _phoneNoHasError = ValueNotifier(false);

  @override
  void dispose() {
    phoneController.dispose();
    _phoneNoHasError.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color.fromRGBO(227, 227, 227, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: height * 0.30,
                                    maxWidth: width * 0.80),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    Image.asset('assets/img/mobile_login.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Mobile Verification',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 30,
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
                              text: 'We will send you an ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'One Time Password ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'on this mobile number',
                              style: TextStyle(color: Colors.black),
                            ),
                          ]),
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
                          valueListenable: _phoneNoHasError,
                          builder: (BuildContext context, bool hasError,
                              Widget child) {
                            return TextField(
                              decoration: InputDecoration(
                                prefixText: "+91",
                                contentPadding: EdgeInsets.all(10),
                                counterText: "",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        !hasError ? primaryColor : Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                errorText: hasError == true
                                    ? "Phone No. Must be 10 digits"
                                    : null,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              controller: phoneController,
                              maxLength: 10,
                              maxLengthEnforced: true,
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              onChanged: (newVal) => _phoneNoHasError.value =
                                  (newVal.length != 10),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: BoxConstraints(maxWidth: 500),
                        child: ValueListenableBuilder(
                            valueListenable: _phoneNoHasError,
                            builder: (BuildContext context, bool hasError,
                                Widget child) {
                              return RaisedButton(
                                onPressed: (hasError ||
                                        phoneController.text.length != 10)
                                    ? null
                                    : () async {
                                        var phone =
                                            '+91' + phoneController.text;
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        currentFocus.unfocus();
                                        ProgressDialog.showLoadingDialog(
                                            context,
                                            _keyLoader); //invoking login
                                        await Firestore.instance
                                            .document("users/$phone")
                                            .get()
                                            .then((doc) {
                                          if (doc.exists) {
                                            Navigator.of(
                                                    _keyLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();

                                            Navigator.of(context).pushNamed(
                                              OtpRoute,
                                              arguments: OtpPageData(
                                                  "+91" + phoneController.text,
                                                  widget.data),
                                            );
                                          } else {
                                            Navigator.of(
                                                    _keyLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                            showInSnackBar(
                                                'Patient Account Doesnt Exist ');
                                          }
                                        });
                                      },
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
                                        'Next',
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
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      elevation: 10,
      backgroundColor: Colors.red[400],
      duration: Duration(seconds: 3),
    ));
  }
}
