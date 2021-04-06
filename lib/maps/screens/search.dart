import 'package:autopayflutter/maps/services/geolocator_service.dart';
import 'package:autopayflutter/maps/services/marker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';

class Search extends StatelessWidget {
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final small = Provider.of<LatLng>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Parking Locations'),
        ),
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  Marker marker1 = Marker(
                      markerId: MarkerId("your_location"),
                      draggable: false,
                      onTap: () {
                        print("Your location");
                      },
                      infoWindow: InfoWindow(title: "Your location"),
                      position: LatLng(
                          currentPosition.latitude, currentPosition.longitude));
                  Marker marker2 = Marker(
                      markerId: MarkerId("best location"),
                      draggable: false,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                      infoWindow: InfoWindow(title: "best location"),
                      position: small); //LatLng(16.394400, 80.149200));
                  markers.add(marker1);
                  markers.add(marker2);
                  return (places != null)
                      ? Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0),
                                onMapCreated: (GoogleMapController controller) {
                                  controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: LatLng(currentPosition.latitude,
                                            currentPosition.longitude),
                                        zoom: 20.0),
                                  ));
                                },
                                zoomGesturesEnabled: true,
                                markers: Set<Marker>.of(markers),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: (places.length > 0)
                                  ? ListView.builder(
                                      itemCount: places.length,
                                      itemBuilder: (context, index) {
                                        return FutureProvider(
                                          create: (context) =>
                                              geoService.getDistance(
                                                  currentPosition.latitude,
                                                  currentPosition.longitude,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng),
                                          child: Card(
                                            child: ListTile(
                                              title: Text(places[index].name),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  (places[index].rating != null)
                                                      ? Row(
                                                          children: <Widget>[
                                                            RatingBarIndicator(
                                                              rating:
                                                                  places[index]
                                                                      .rating,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber),
                                                              itemCount: 5,
                                                              itemSize: 10.0,
                                                              direction: Axis
                                                                  .horizontal,
                                                            )
                                                          ],
                                                        )
                                                      : Row(),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                 /* Consumer<double>(
                                                    builder: (context, meters,
                                                        widget) {
                                                      return (meters != null)
                                                          ? Text(
                                                              '${places[index].vicinity} \u00b7 ${(meters / 1609).round()} mi')
                                                          : Container();
                                                    },
                                                  )*/
                                                ],
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.directions),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                onPressed: () {
                                                  _launchMapsUrl(
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text('No Parking Found Nearby'),
                                    ),
                            )
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

