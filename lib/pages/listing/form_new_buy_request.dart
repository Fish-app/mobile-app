import 'dart:io';

import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/Map/choose_location_widget.dart';
import 'package:fishapp/widgets/dropdown_menu.dart';
import 'package:fishapp/widgets/form/formfield_normal.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;



class NewBuyRequestForm extends StatefulWidget {
  final GenericRouteData routeData;
  final listingService = ListingService();
  final commodityService = CommodityService();

  NewBuyRequestForm({Key key, this.routeData}) : super(key: key);

  @override
  _NewBuyRequestFormState createState() => _NewBuyRequestFormState();
}

class _NewBuyRequestFormState extends State<NewBuyRequestForm> {
  final _formKey = GlobalKey<FormState>();
  BuyRequest _buyRequestData;
  String _errorMessage = "";
  final _firstDate = DateTime(2000);
  final _lastDate = DateTime(2100);
  final _dateController = TextEditingController();
  Commodity pickedFish;
  bool _hasLocation = false;
  LatLng _location;
  String _notPickedLocationMessage = "";

  @override
  void initState() {
    super.initState();
    _buyRequestData = BuyRequest();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            DropdownMenu(
              showSearchBox: true,
              showClearButton: true,
              label: S.of(context).commodity,
              searchBoxHint: S.of(context).search,
              customFilter: (commodity, filter) =>
                  commodity.filterByName(filter),
              onFind: (String filter) =>
                  widget.commodityService.getAllCommodities(context),
              onSaved: _dropdownSelectedCallback,
              validator: (value) {
                if (value == null) {
                  return S.of(context).commodityNotChosen;
                }
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            StandardButton(
                buttonText: S.of(context).setHomeLocation,
                onPressed: () {
                  _navigateAndDisplayMap(context);
                }),
            Text(_notPickedLocationMessage, style: TextStyle(color: Colors.red)),
            FormFieldNormal(
                title: S.of(context).amount.toUpperCase(),
              keyboardType: TextInputType.number,
              suffixText: "Kg",
              onSaved: (newValue) => {
                  _buyRequestData.amount = int.tryParse(newValue)
              },
              validator: (value) {
                  if (value.isEmpty) {
                    return validateNotEmptyInput(value, context);
                  } else {
                    return validateIntInput(value, context);
                  }
              },
            ),
            FormFieldNormal(
                title: S.of(context).price.toUpperCase(),
              suffixText: "nok",
              keyboardType: TextInputType.number,
              onSaved: (newValue) => {
                  _buyRequestData.price = double.tryParse(newValue)
              },
              validator: (value) {
                if (value.isEmpty) {
                  return validateNotEmptyInput(value, context);
                } else {
                  return validateIntInput(value, context);
                }
              },
            ),
            FormFieldNormal(
                title: S.of(context).dueDate.toUpperCase(),
              readOnly: true,
              controller: _dateController,
              onSaved: (newValue) => {
                  if (newValue.trim().isNotEmpty) {
                    _buyRequestData.endDate = _toEpoch(newValue)
                  }
              },
              validator: (value) {
                  return validateDateNotPast(value, context);
              },
              onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: _firstDate,
                      lastDate: _lastDate);
                  if (date != null) {
                    _dateController.text = date.toString().substring(0, 10);
                  }
              },
            ),
            FormFieldNormal(
                title: S.of(context).additionalInfo.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (newValue) => {
                  _buyRequestData.additionalInfo = newValue
              },
            ),
            FormFieldNormal(
                title: S.of(context).maxDistance.toUpperCase(),
              suffixText: "Km",
              keyboardType: TextInputType.number,
              onSaved: (newValue) => {
                  _buyRequestData.maxDistance = double.tryParse(newValue)
              },
              validator: (value) {
                if (value.isEmpty) {
                  return validateNotEmptyInput(value, context);
                } else {
                  return validateIntInput(value, context);
                }
              },
            ),
            StandardButton(
                buttonText: S.of(context).addOrder.toUpperCase(),
                onPressed: () => _handleBuyRequest(context)
            )
          ],
        ),
      ),
    );
  }

  _dropdownSelectedCallback(newValue) {
    if (newValue != null) {
      setState(() {
        pickedFish = newValue;
        _buyRequestData.commodity = pickedFish;
      });
    }
  }

  _navigateAndDisplayMap(BuildContext context) async {
    final LatLng result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseLocation()));
    if (result != null) {
      _location = result;
      _buyRequestData.longitude = _location.longitude;
      _buyRequestData.latitude = _location.latitude;
      _hasLocation = true;
    }
  }

  int _toEpoch(String date) {
    DateTime i = DateTime.parse(date);
    int epochTime = i.millisecondsSinceEpoch;
    return epochTime;
  }

  void _handleBuyRequest(BuildContext context) async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (!_hasLocation) {
      setState(() {
        _notPickedLocationMessage = S.of(context).locationNotSet;
      });
    } else {
      setState(() {
        _notPickedLocationMessage = "";
      });
    }
    if (formState.validate() && _hasLocation) {
      try {
        BuyRequest suc = await widget.listingService
            .createBuyRequest(context, _buyRequestData);
        if (suc != null) {
          Navigator.removeRouteBelow(context, ModalRoute.of(context));
          Navigator.pushReplacementNamed(context, routes.ListingInfo,
              arguments: suc);
        }
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }
    }
  }
}