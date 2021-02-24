
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/entities/commodity.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/pages/Listing/listing_formdata.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/rest_api_service.dart';
import 'package:***REMOVED***/widgets/Map/choose_location_widget.dart';
import 'package:***REMOVED***/widgets/dropdown_menu.dart';
import 'package:***REMOVED***/widgets/form/formfield_normal.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';

import 'package:latlong/latlong.dart';


class NewListingForm extends StatefulWidget {
  final GenericRouteData routeData;
  final listingService = ListingService();
  final service = CommodityService();
  NewListingForm({Key key, this.routeData}) : super(key: key);

  @override
  _NewListingFormState createState() => _NewListingFormState();
}


class _NewListingFormState extends State<NewListingForm> {
  final _formKey = GlobalKey<FormState>();
  ListingFormData _listingFormData;
  String _errorMessage = "";
  final _firstDate = DateTime(1900);
  final _lastDate = DateTime(2100);
  final _dateController = TextEditingController();
  Commodity pickedFish;
  LatLng _location;

  @override
  void initState() {
    super.initState();
    _listingFormData = ListingFormData();
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
            //DropdownType(dropdownTypeCallback),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            DropdownMenu(
                showSearchBox: true,
                showClearButton: true,
                label: S.of(context).commodity,
                searchBoxHint: S.of(context).search,
                customFilter: (commodity, filter) => commodity.filterByName(filter),
                onFind: (String filter) => widget.service.getAllCommodities(context),
                callback: _dropdownSelectedCallback
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            StandardButton(
                buttonText: S.of(context).setPickupLocation,
                onPressed: () {
                  _navigateAndDisplayMap(context);
                }
            ),
            FormFieldNormal(
              title: S.of(context).amount.toUpperCase(),
              keyboardType: TextInputType.number,
              onSaved: (newValue) => {_listingFormData.maxAmount = int.parse(newValue)},
              validator: (value) {
                return validateFloatInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).price.toUpperCase(),
              keyboardType: TextInputType.number,
              onSaved: (newValue) => {_listingFormData.price = double.parse(newValue)},
              validator: (value) {
                return validateFloatInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).pickupDate.toUpperCase(),
              readOnly: true,
              controller: _dateController,
              onSaved: (newValue) => {_listingFormData.endDate = _toEpoch(newValue)},
              validator: (value) {
                return validateDateNotPast(value, context);
              },
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: _firstDate,
                    lastDate: _lastDate);
                _dateController.text = date.toString().substring(0,10);
              }, //TODO: validate that the date is not past
            ),
            FormFieldNormal(
              title: S.of(context).additionalInfo.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (newValue) => {_listingFormData.additionalInfo = newValue},
            ),
            StandardButton(
                buttonText: S.of(context).addListing.toUpperCase(),
                onPressed: _handleNewOffer(context))
          ],
        ),
      ),
    );
  }

  // dropdownTypeCallback(newValue) {
  //   setState(() {
  //     dropdownType = newValue;
  //   });
  // }

  int _toEpoch(String date) {
    DateTime i = DateTime.parse(date);
    int epochTime = i.millisecondsSinceEpoch;
    print(epochTime);
    return epochTime;
  }

  _dropdownSelectedCallback(newValue) {
    setState(() {
      pickedFish = newValue;
    });
  }

  _navigateAndDisplayMap(BuildContext context) async {
    final LatLng result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLocation())
    );
    _location = result;
    _listingFormData.longitude = _location.longitude;
    _listingFormData.latitude = _location.latitude;
  }

  _handleNewOffer(BuildContext context) async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.listingService.createOfferListing(context, _listingFormData);
      } on HttpException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      }
    }
  }
}