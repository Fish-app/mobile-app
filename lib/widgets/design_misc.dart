import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class CircleThingy extends StatelessWidget {
  final double centerX;
  final double centerY;

  final double sizeX;
  final double sizeY;

  final bool top;
  final bool left;

  const CircleThingy({
    Key key,
    this.centerX,
    this.centerY,
    this.sizeX,
    this.sizeY,
    this.top,
    this.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? true ? -((sizeY / 2) - centerY) : null,
      bottom: top ?? true ? null : -((sizeY / 2) - centerY),
      left: left ?? true ? -((sizeX / 2) - centerX) : null,
      right: left ?? true ? null : -((sizeX / 2) - centerX),
      child: ClipOval(
        child: Container(
          color: Theme.of(context).accentColor,
          height: sizeY,
          width: sizeX,
        ),
      ),
    );
  }
}

class ButtonV2 extends StatelessWidget {
  final VoidCallback onPushed;

  const ButtonV2({Key key, this.onPushed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 60,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.centerLeft,
            children: [
              CircleThingy(
                sizeY: 60,
                sizeX: 60,
                centerX: 30,
                centerY: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.payments,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
