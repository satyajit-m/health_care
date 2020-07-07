import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'button.dart';

/// The button text can be overridden, however the default text is recommended
/// in order to be compliant with the design guidelines and to maximise
/// conversion.
class MobileSignInButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color splashColor;
  final double minWidth;

  MobileSignInButton({
    this.onPressed,
    this.borderRadius = defaultBorderRadius,
    this.text = 'Continue with Phone',
    this.textStyle,
    this.splashColor,
    this.minWidth,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: primaryColor,
      borderRadius: borderRadius,
      splashColor: splashColor,
      onPressed: onPressed,
      buttonPadding: 8.0,
      minWidth: minWidth,
      children: <Widget>[
        // Facebook doesn't provide strict sizes, so this is a good
        // estimate of their examples within documentation.
        Icon(Icons.phone),
        // Image(
        //   image: AssetImage(
        //     "assets/img/smartphone.png",
        //   ),
        //   height: 24.0,
        //   width: 24.0,
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 10.0),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  // default to the application font-style
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ),
      ],
    );
  }
}
