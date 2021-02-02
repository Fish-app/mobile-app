import 'dart:ui';

import 'package:flutter/material.dart';

/// The BlurBackgroundStack takes a Widget, and
/// places it on top of a image and a blurred background
class StackBlurredBackground extends StatelessWidget {
  final Container container;
  final AssetImage backgroundImage;
  const StackBlurredBackground(this.backgroundImage, this.container , {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                // Source on how to add image:
                // https://stackoverflow.com/a/44183373
                image: this.backgroundImage,
                fit: BoxFit.cover,
              )),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black12.withOpacity(0.2),
          ),
        ),
        /// The container to be placed on top of the blurred background
        this.container,
      ],
    );
  }
}
