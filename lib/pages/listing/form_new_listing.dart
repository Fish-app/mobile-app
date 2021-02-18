
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/route_data.dart';
import 'package:***REMOVED***/generated/l10n.dart';
import 'package:***REMOVED***/pages/Listing/listing_formdata.dart';
import 'package:***REMOVED***/utils/form/form_validators.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/widgets/form/formfield_normal.dart';

class NewListingForm extends StatefulWidget {
  final GenericRouteData routeData;
  final authService = AuthService();
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
            FormFieldNormal(
              title: S.of(context).amount.toUpperCase(),
              keyboardType: TextInputType.number,
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
}