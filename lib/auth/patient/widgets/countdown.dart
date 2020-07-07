import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CircularProgressIndicator(),
        Text(
          animation.value.toString(),
        )
      ],
    );
  }
}
