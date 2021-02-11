import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maoyi/generated/l10n.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:strings/strings.dart';


/// This widget looks for installed map applications on the phone and gives the
/// option of opening one of them at the given coordinates.
class MapWidget {

  final double latitude;
  final double longitude;

  const MapWidget({
    Key key,
    @required this.latitude,
    @required this.longitude
  });

 openMapSheet(context) async {
   try {
     final availableMaps = await MapLauncher.installedMaps;
     showModalBottomSheet(
         context: context,
         builder: (BuildContext context) {
           return SafeArea(
               child: SingleChildScrollView(
                 child: Container(
                   child: Wrap(
                     children: [
                       for (var map in availableMaps)
                         ListTile(
                           onTap: () => map.showMarker(
                               coords: Coords(latitude, longitude),
                               title: capitalize(S.of(context).pos),
                           ),
                           title: Text(map.mapName),
                           leading: SvgPicture.asset(
                             map.icon,
                             height: 30.0,
                             width: 30.0,
                           ),
                         )
                     ],
                   ),
                 ),
               )
           );
         }
     );
   } catch (e) {
     log("Error displaying map applications", error: e, time: DateTime.now());
   }
 }
}
