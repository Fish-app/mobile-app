import 'dart:ui';

import 'package:flutter/material.dart';

/// The BlurredBackgroundWidget takes a Widget, and
/// places it on top of a image and a blurred background
class BlurredImage extends StatelessWidget {
  final AssetImage backgroundImage;
  final Color blurColor;
  final double sigmaX;
  final double sigmaY;
  const BlurredImage(
      {Key key,
      this.backgroundImage,
      this.blurColor,
      this.sigmaX = 5,
      this.sigmaY = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: this.backgroundImage,
            fit: BoxFit.cover,
          )),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: Container(
            color: blurColor ?? Colors.black12.withOpacity(0.2),
          ),
        ),

      ],
    );
  }
}
