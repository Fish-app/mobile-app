import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const DefaultCard({Key key, this.children, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class CircleThingy extends StatelessWidget {
  final double centerX;
  final double centerY;

  final double sizeX;
  final double sizeY;

  final bool top;
  final bool left;

  final Color color;

  const CircleThingy(
      {Key key,
      this.centerX,
      this.centerY,
      this.sizeX,
      this.sizeY,
      this.top,
      this.left,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? true ? -((sizeY / 2) - centerY) : null,
      bottom: top ?? true ? null : -((sizeY / 2) - centerY),
      left: left ?? true ? -((sizeX / 2) - centerX) : null,
      right: left ?? true ? null : -((sizeX / 2) - centerX),
      child: ClipOval(
        child: Container(
          color: color ?? Theme.of(context).accentColor,
          height: sizeY,
          width: sizeX,
        ),
      ),
    );
  }
}

class ButtonV2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final IconData buttonIcon;
  final EdgeInsets padding;

  const ButtonV2(
      {Key key, this.onPressed, this.buttonText, this.buttonIcon, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 55,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: 20,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Card(
                    elevation: 4,
                    shape: ContinuousRectangleBorder(),
                    margin: EdgeInsets.zero,
                    semanticContainer: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(buttonText),
                  ),
                ),
                Positioned(
                  height: 55,
                  width: 55,
                  left: 0,
                  child: Card(
                      elevation: 3,
                      margin: EdgeInsets.zero,
                      shape:
                          CircleBorder(side: BorderSide(color: Colors.black)),
                      color: Theme.of(context).accentColor,
                      child: Icon(
                        buttonIcon,
                        size: 35,
                        color: Colors.black,
                      )),
                ),
                // CircleThingy(
                //   sizeY: 60,
                //   sizeX: 60,
                //   centerX: 30,
                //   centerY: 30,
                //   color: Colors.black,
                // ),
                // CircleThingy(
                //   sizeY: 59,
                //   sizeX: 59,
                //   centerX: 30,
                //   centerY: 30,
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 12),
                //     child: Icon(
                //       Icons.payments,
                //       size: 35,
                //       color: Colors.black,
                //     ),
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
