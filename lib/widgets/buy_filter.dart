import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _BuyFilterItem {
  final String filterTitle;
  bool isActive = false;

  _BuyFilterItem(this.filterTitle);
}

class BuyFilterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BuyFilterWidgetState();
}

class BuyFilterWidgetState extends State<BuyFilterWidget> {
  final List<_BuyFilterItem> filterItems = [
    _BuyFilterItem("somefilter"),
    _BuyFilterItem("some other filter"),
    _BuyFilterItem("aaa"),
    _BuyFilterItem("bbb")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(
                      20.0), // dobbel defined also in input_fealds
                ),
              ),
              fillColor: Colors.grey,
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              //isCollapsed: true,
              prefixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8.0),
                child: Icon(Icons.search),
              ),
              hintText: "Search",
              prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
              )),
        ),
        Wrap(
          spacing: 3,
          children: filterItems.map((filterItem) {
            return ChoiceChip(
              selectedColor: Theme.of(context).primaryColor,
              label: Text(
                filterItem.filterTitle,
                style: TextStyle(
                    color: filterItem.isActive
                        ? Theme.of(context).accentColor
                        : Colors.black),
              ),
              onSelected: (value) {
                print("filter " + filterItem.filterTitle + " is active");
                setState(() {
                  filterItem.isActive = value;
                });
              },
              selected: filterItem.isActive,
            );
          }).toList(),
        )
      ],
    );
  }
}
