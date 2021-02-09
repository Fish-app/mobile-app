import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/widgets/standard_button.dart';
import 'package:map_launcher/map_launcher.dart';

/*
This widget looks for installed map applications on the phone and gives the
option of opening one of them at the given coordinates.
 */
class MapWidget extends StatelessWidget {

  final OfferListing offerListing;

  const MapWidget({Key key, this.offerListing}) : super(key: key);

 openMapSheet(context) async {
   try {
     final coords = this.offerListing.coords ?? Coords(0, 0);
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
                               coords: coords,
                               title: "Listing"
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
     print(e); //TODO: Must be done another way
   }
 }

 //TODO: will be replaced with an image displaying the destination
  @override
  Widget build(BuildContext context) {
   return StandardButton(
       buttonText: "Open Map",
       onPressed: () => openMapSheet(context)
   );
  }
}
