import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:***REMOVED***/widgets/Map/open_map_widget.dart';

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

  const MapImage({
    Key key,
    @required this.latitude,
    @required this.longitude,
    @required this.height,
    this.zoom = 15.0,
    this.interactive = false,
    this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: FlutterMap(
        options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: zoom,
            interactive: interactive,
            onTap: onTap
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: _url,
              subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 50.0,
                height: 50.0,
                point: LatLng(latitude, longitude),
                builder: (context) => Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                )
              )
            ]
          )
        ],
      ),
    );
  }
}