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

class BluredButtonOverlay extends StatelessWidget {
  final Widget child;
  final bool showButton;
  final VoidCallback onClick;

  final Color blurColor;
  final double sigmaX;
  final double sigmaY;

  const BluredButtonOverlay(
      {Key key,
      this.blurColor,
      this.sigmaX = 5,
      this.sigmaY = 5,
      this.child,
      this.showButton,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (showButton) ...[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              color: blurColor ?? Colors.black12.withOpacity(0.2),
            ),
          ),
          Text('AAAAA'),
          GestureDetector(
            onTap: onClick,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ]
      ],
    );
  }
}
