import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:maoyi/utils/distance_calculator.dart';
import 'package:maoyi/widgets/nav_widgets/common_nav.dart';
import 'package:latlong/latlong.dart';
import 'package:maoyi/widgets/standard_button.dart';


class ChooseLocation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final String _url = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  double _currentLat;
  double _currentLong;
  double _pickedLat = 0.0;
  double _pickedLong = 0.0;
  bool _hasChosen = false;

  Future<Position> _determinePosition = determinePosition();

  List<LatLng> tappedPoint = [];


  @override
  Widget build(BuildContext context) {
    var _marker = tappedPoint.map((latlng) {
      return Marker(
        width: 50.0,
        height: 50.0,
        point: latlng,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
    }).toList();

    return getMaoyiDefaultScaffold(
        context,
        includeTopBar: S.of(context).setPickupLocation,
        extendBehindAppBar: false,
        child: FutureBuilder(
          future: _determinePosition,
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              _currentLat = snapshot.data.latitude;
              _currentLong = snapshot.data.longitude;
              children = [
                FlutterMap(
                    options: MapOptions(
                      interactiveFlags: InteractiveFlag.pinchZoom |
                        InteractiveFlag.drag | InteractiveFlag.doubleTapZoom,
                      center: LatLng(_currentLat, _currentLong),
                      zoom: 14.0,
                      interactive: true,
                      onTap: _handleNewMarker
                    ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate: _url,
                        subdomains: ['a', 'b', 'c'],
                      ),
                    MarkerLayerOptions(markers: _marker)
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/12,
                  child: BottomAppBar(
                    child: StandardButton(
                      buttonText:  _buttonText(context),
                      onPressed: () {
                        if (_hasChosen) {
                          Navigator.pop(context, LatLng(_pickedLat, _pickedLong));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
              ];
            } else if (snapshot.hasError) {
              children = [
                Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ],
                )
              ];
            } else {
              children = [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator()
                  ],
                )
              ];
            }
            return Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: children,
              ),
            );
          }
        )
    );
  }

  void _handleNewMarker(LatLng position) {
    setState(() {
      _pickedLat = position.latitude;
      _pickedLong = position.longitude;
      if (tappedPoint.isNotEmpty) {
        tappedPoint.removeLast();
      }
      tappedPoint.add(position);
      _hasChosen = true;
    });
  }

  String _buttonText(BuildContext context) {
    if (_hasChosen) {
      return S.of(context).confirmLocation.toUpperCase();
    } else {
      return S.of(context).cancel.toUpperCase();
    }
  }

}