import 'dart:ui';

import 'package:async/async.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/distance_calculator.dart';
import 'package:fishapp/utils/loading_spinnder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:strings/strings.dart';

import 'choose_location_widget.dart';

/// Displays a map image of the location specified
/// by the latitude and longitude.
class MapImage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final bool interactive;
  final Function onTap;
  final double height;
  final double zoom;
  final String _url = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  final MapController mapController;

  const MapImage(
      {Key key,
      @required this.latitude,
      @required this.longitude,
      @required this.height,
      this.zoom = 15.0,
      this.interactive = false,
      this.onTap,
      this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: FlutterMap(
        mapController: this.mapController,
        options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: zoom,
            interactive: interactive,
            onTap: onTap),
        layers: [
          TileLayerOptions(
            urlTemplate: _url,
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: [
            Marker(
                width: 50.0,
                height: 50.0,
                point: LatLng(latitude, longitude),
                builder: (context) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ))
          ])
        ],
      ),
    );
  }
}

class MapCard extends StatefulWidget {
  final LatLng initialLatLang;

  final bool interactive;

  final void Function(LatLng position) onNewPosSelected;
  final double height;
  final double zoom;
  final String _url = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  final MapController _mapController = MapController();

  MapCard({
    Key key,
    @required this.height,
    this.zoom = 15.0,
    this.interactive = false,
    this.onNewPosSelected,
    this.initialLatLang,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MapCardState();
}

class MapCardState extends State<MapCard> {
  LatLng currentLatLang;
  CancelableOperation _future;
  bool _hasPicked = false;

  @override
  void initState() {
    if (widget.initialLatLang != null) {
      currentLatLang = widget.initialLatLang;
    } else {
      _future = CancelableOperation.fromFuture(determinePosition()).then((pos) {
        if (pos != null) {
          setState(() {
            currentLatLang = LatLng(pos.latitude, pos.longitude);
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _future?.cancel();
    super.dispose();
  }

  _navigateAndDisplayMap(BuildContext context) async {
    final LatLng result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseLocation(
                  initialLatLang: currentLatLang,
                )));
    if (result != null) {
      setState(() {
        _hasPicked = true;
        currentLatLang = result;

        widget?.onNewPosSelected(result);
      });
      widget._mapController.move(result, 15);
    }
  }

  final LatLng _fallbackLatLng = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
          height: widget.height,
          child: Stack(
            children: [
              Visibility(
                  visible: (currentLatLang != null),
                  replacement: getCircularSpinner(),
                  child: FlutterMap(
                    mapController: widget._mapController,
                    options: MapOptions(
                      center: currentLatLang ?? _fallbackLatLng,
                      zoom: widget.zoom,
                      interactive: widget.interactive,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: widget._url,
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: [
                        Marker(
                            width: 50.0,
                            height: 50.0,
                            point: currentLatLang ?? _fallbackLatLng,
                            builder: (context) => Container(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ))
                      ])
                    ],
                  )),
              if (!_hasPicked && widget.interactive) ...[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                Center(child: Text(capitalize(S.of(context).clickLocation))),
              ],
              GestureDetector(
                onTap: () {
                  if (widget.interactive) {
                    _navigateAndDisplayMap(context);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          )),
    );
  }
}
