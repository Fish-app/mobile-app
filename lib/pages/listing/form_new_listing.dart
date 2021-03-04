import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/Map/choose_location_widget.dart';
import 'package:fishapp/widgets/dropdown_menu.dart';
import 'package:fishapp/widgets/form/formfield_normal.dart';
import 'package:fishapp/widgets/standard_button.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;

import 'package:latlong/latlong.dart';

import 'package:fishapp/entities/listing.dart';

import '../../entities/listing.dart';
import '../../entities/listing.dart';
import '../../utils/form/form_validators.dart';
import '../../utils/form/form_validators.dart';
import '../../utils/form/form_validators.dart';
import 'listing_info_page.dart';

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
  OfferListing _listingFormData;
  String _errorMessage = "";
  final _firstDate = DateTime(1900);
  final _lastDate = DateTime(2100);
  final _dateController = TextEditingController();
  Commodity pickedFish;
  LatLng _location;

  @override
  void initState() {
    super.initState();
    _listingFormData = OfferListing();
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
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            DropdownMenu(
              showSearchBox: true,
              showClearButton: true,
              label: S.of(context).commodity,
              searchBoxHint: S.of(context).search,
              customFilter: (commodity, filter) =>
                  commodity.filterByName(filter),
              onFind: (String filter) =>
                  widget.service.getAllCommodities(context),
              onSaved: _dropdownSelectedCallback,
              validator: (value) {
                if (value == null) {
                  return S.of(context).commodityNotChosen;
                }
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            StandardButton(
                buttonText: S.of(context).setPickupLocation,
                onPressed: () {
                  _navigateAndDisplayMap(context);
                }),
            FormFieldNormal(
              title: S.of(context).amount.toUpperCase(),
              keyboardType: TextInputType.number,
              suffixText: "kg",
              onSaved: (newValue) => {
                _listingFormData.maxAmount = int.parse(
                  newValue,
                  onError: (source) => 0,
                )
              },
              validator: (value) {
                return validateIntInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).price.toUpperCase(),
              suffixText: "nok",
              keyboardType: TextInputType.number,
              onSaved: (newValue) =>
                  {_listingFormData.price = double.parse(newValue)},
              validator: (value) {
                return validateIntInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).pickupDate.toUpperCase(),
              readOnly: true,
              controller: _dateController,
              onSaved: (newValue) => {
                if (newValue.trim().isNotEmpty)
                  {_listingFormData.endDate = _toEpoch(newValue)}
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
                _dateController.text = date.toString().substring(0, 10);
              },
            ),
            FormFieldNormal(
              title: S.of(context).additionalInfo.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (newValue) =>
                  {_listingFormData.additionalInfo = newValue},
            ),
            StandardButton(
                buttonText: S.of(context).addListing.toUpperCase(),
                onPressed: () => _handleNewOffer(context))
          ],
        ),
      ),
    );
  }

  int _toEpoch(String date) {
    DateTime i = DateTime.parse(date);
    int epochTime = i.millisecondsSinceEpoch;
    return epochTime;
  }

  _dropdownSelectedCallback(newValue) {
    if (newValue != null) {
      setState(() {
        pickedFish = newValue;
        _listingFormData.commodity = pickedFish;
      });
    }
  }

  _navigateAndDisplayMap(BuildContext context) async {
    final LatLng result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseLocation()));
    if (result != null) {
      _location = result;
      _listingFormData.longitude = _location.longitude;
      _listingFormData.latitude = _location.latitude;
    }
  }

  void _handleNewOffer(BuildContext context) async {
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        print(_listingFormData.toJson());
        print(_listingFormData.toJsonString());
        OfferListing suc = await widget.listingService
            .createOfferListing(context, _listingFormData);
        if (suc != null) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Listing has been created")));
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
