import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayTextField extends StatelessWidget {
  const DisplayTextField({
    Key key,
    @required this.description,
    @required this.content
  }) : super(key: key);

  final String description;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: Theme.of(context).primaryTextTheme.bodyText2.copyWith(fontSize: 12),
            ),
            Text(
              content,
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            Divider(
              color: Colors.grey[800],
            )
          ],
        ),
      ),
    );
  }
}