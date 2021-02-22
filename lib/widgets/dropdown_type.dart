import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/themes/theme_config.dart';
import 'package:***REMOVED***/generated/l10n.dart';

class _Item {
  final String title;
  bool isActive = false;
  int index;

  _Item(this.title, this.index);
}

class DropdownType extends StatefulWidget {
 final Function(int) callback;
 DropdownType(this.callback);

  @override
  _DropdownTypeState createState() => _DropdownTypeState();

}

class _DropdownTypeState extends State<DropdownType> {
  final List<_Item> items = [
    _Item(S.current.fish, 0),
    _Item(S.current.shellfish, 1),
  ];
  _Item _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: items.map((item) {
        return ChoiceChip(
          selectedColor: Theme.of(context).primaryColor,
            label: Text(
              item.title,
              style: TextStyle(
                color: item.isActive ? emphasis2Color : Colors.black
              ),
            ),
            onSelected: (value) {
              setState(() {
              item.isActive = value;
              _selectedValue = value ? item : null;
              widget.callback(_selectedValue?.index ?? 0);
              });
            },
            selected: testSelected(item, _selectedValue)
        );
      }).toList(),
    );
  }

  bool testSelected(_Item item, _Item selectedItem) {
    bool i = false;
    if (selectedItem == item) {
      i = true;
      item.isActive = false;
    }
    return i;
  }

}