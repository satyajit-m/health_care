import 'package:flutter/material.dart';

class ProgressDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white.withOpacity(0.0),
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]));
        });
  }
}
