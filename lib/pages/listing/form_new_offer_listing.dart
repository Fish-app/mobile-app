import 'dart:io';
import 'dart:ui';

import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/rest_api_service.dart';
import 'package:fishapp/widgets/Map/choose_location_widget.dart';
import 'package:fishapp/widgets/Map/map_image.dart';
import 'package:fishapp/widgets/design_misc.dart';
import 'package:fishapp/widgets/dropdown_menu.dart';
import 'package:fishapp/widgets/form/formfield_normal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../../entities/listing.dart';
import '../../utils/form/form_validators.dart';

class NewOfferListingForm extends StatefulWidget {
  final GenericRouteData routeData;
  final listingService = ListingService();
  final service = CommodityService();

  NewOfferListingForm({Key key, this.routeData}) : super(key: key);

  @override
  _NewOfferListingFormState createState() => _NewOfferListingFormState();
}

class _NewOfferListingFormState extends State<NewOfferListingForm> {
  final _formKey = GlobalKey<FormState>();
  OfferListing _listingFormData;
  String _errorMessage = "";
  final _firstDate = DateTime(2000);
  final _lastDate = DateTime(2100);
  final _dateController = TextEditingController();
  Commodity pickedFish;
  bool _hasLocation = false;
  LatLng _location = LatLng(0.0, 0.0);
  String _notPickedLocationMessage = "";

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
              onFind: (String filter) => widget.service.getAllCommodities(),
              onSaved: _dropdownSelectedCallback,
              validator: (value) {
                if (value == null) {
                  return S.of(context).commodityNotChosen;
                }
              },
            ),
            DefaultCard(
              children: [
                FormFieldNormal(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  title: S.of(context).amount.toUpperCase(),
                  keyboardType: TextInputType.number,
                  suffixText: "Kg",
                  onSaved: (newValue) =>
                      {_listingFormData.maxAmount = int.tryParse(newValue)},
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
                  onSaved: (newValue) =>
                      {_listingFormData.price = double.tryParse(newValue)},
                  validator: (value) {
                    if (value.isEmpty) {
                      return validateNotEmptyInput(value, context);
                    } else {
                      return validateIntInput(value, context);
                    }
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
                    if (date != null) {
                      _dateController.text = date.toString().substring(0, 10);
                    }
                  },
                ),
              ],
            ),
            DefaultCard(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: MapImage(
                        latitude: _location.latitude,
                        longitude: _location.longitude,
                        height: MediaQuery.of(context).size.height / 2.2,
                        interactive: false,
                        onTap: (asd) {
                          _navigateAndDisplayMap(context);
                        },
                      ),
                    ),
                    Text(
                      S.of(context).setPickupLocation,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ],
                ),
                Text(_notPickedLocationMessage,
                    style: TextStyle(color: Colors.red)),
              ],
            ),
            DefaultCard(
              children: [
                FormFieldNormal(
                  title: S.of(context).additionalInfo.toUpperCase(),
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) =>
                      {_listingFormData.additionalInfo = newValue},
                ),
              ],
            ),
            ButtonV2(
                padding: const EdgeInsets.symmetric(vertical: 30),
                buttonText: S.of(context).addListing.toUpperCase(),
                buttonIcon: Icons.add,
                onPressed: () => _handleNewOffer(context)),
            SizedBox(
              height: 100,
            )
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
      _hasLocation = true;
    }
  }

  void _handleNewOffer(BuildContext context) async {
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
        print(_listingFormData.toJson());
        print(_listingFormData.toJsonString());
        OfferListing suc =
            await widget.listingService.createOfferListing(_listingFormData);
        if (suc != null) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Listing has been created")));
          Navigator.removeRouteBelow(context, ModalRoute.of(context));
          Navigator.pushReplacementNamed(context, routes.OfferListingInfo,
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
