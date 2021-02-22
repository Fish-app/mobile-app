
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/entities/commodity.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/pages/Listing/listing_formdata.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/utils/services/rest_api_service.dart';
import 'package:***REMOVED***/widgets/dropdown_menu.dart';
import 'package:***REMOVED***/widgets/dropdown_type.dart';
import 'package:***REMOVED***/widgets/form/formfield_normal.dart';

class NewListingForm extends StatefulWidget {
  final GenericRouteData routeData;
  final authService = AuthService();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                callback: dropdownSelectedCallback
            ),
            FormFieldNormal(
              title: S.of(context).amount.toUpperCase(),
              keyboardType: TextInputType.number,
              //onSaved: (newValue) => {_listingFormData.maxAmount = newValue},
              validator: (value) {
                return validateFloatInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).price.toUpperCase(),
              keyboardType: TextInputType.number,
              validator: (value) {
                return validateFloatInput(value, context);
              },
            ),
            FormFieldNormal(
              title: S.of(context).pickupDate.toUpperCase(),
              controller: _dateController,
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
            )
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

  dropdownSelectedCallback(newValue) {
    setState(() {
      pickedFish = newValue;
    });
  }

}