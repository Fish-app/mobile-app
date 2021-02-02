import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleShadowWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color shadowColor;

  /// entire screen blures when this and left is equal and below 1
  final double fromTop;

  final double fromLeft;

  final double size;

  final double blur;

  const SimpleShadowWidget(
      {Key key,
      this.iconData,
      this.iconColor,
      this.shadowColor = Colors.black54,
      this.fromTop = 0.4,
      this.fromLeft = 0.3,
      this.size = 32,
      this.blur = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      //fit: StackFit.loose,
      children: [
        Positioned(
          left: fromLeft,
          top: fromTop,
          child: SizedBox(
            width: size + blur,
            height: size + blur,
            child: Icon(
              iconData,
              color: shadowColor,
              size: size,
            ),
          ),
        ),

        /// hmm this or the comented block unshure what looks best
        /// further testing needed
        Positioned(
          left: fromLeft,
          top: fromTop,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Icon(
              iconData,
              color: shadowColor.withOpacity(0),
              size: size,
            ),
          ),
        ),
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        //   child: new Container(
        //     width: size + blur,
        //     height: size + blur,
        //     color: Colors.white.withOpacity(0),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, fromTop + blur, fromLeft + blur),
          child: Icon(
            iconData,
            color: iconColor,
            size: size,
          ),
        ),
      ],
    );
  }
}
