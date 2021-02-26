import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';

import '../entities/commodity.dart';

class DropdownMenu extends StatefulWidget {
  final commodityService = CommodityService();

  final Function onSaved;
  final bool showSearchBox;
  final showClearButton;
  final String searchBoxHint;
  final Function(Commodity, String) customFilter;
  final onFind;
  final label;
  final Function(Commodity) validator;
  DropdownMenu({
    this.showClearButton = false,
    this.showSearchBox = false,
    this.onSaved,
    this.searchBoxHint,
    this.customFilter,
    this.onFind,
    this.label,
    this.validator
  });

  @override
  _DropdownMenuState createState() => _DropdownMenuState();

}

class _DropdownMenuState extends State<DropdownMenu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Commodity>(
      searchBoxController: TextEditingController(),
      showSearchBox: widget.showSearchBox,
      showClearButton: widget.showClearButton,
      searchBoxDecoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.searchBoxHint
      ),
      mode: Mode.MENU,
      filterFn: widget.customFilter,
      showSelectedItem: false,
      label: widget.label,
      onFind: widget.onFind,
      onSaved: (c) => widget.onSaved(c),
      validator: widget.validator,
    );
  }
}