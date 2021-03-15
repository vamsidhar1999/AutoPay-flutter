import 'package:autopayflutter/maps/models/place.dart';
import 'package:autopayflutter/maps/screens/search.dart';
import 'package:autopayflutter/maps/services/distance_service.dart';
import 'package:autopayflutter/maps/services/geolocator_service.dart';
import 'package:autopayflutter/maps/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyMaps extends StatefulWidget {
  @override
  _MyMapsState createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  final distanceService = DistanceService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          FutureProvider(create: (context) => locatorService.getLocation()),
          FutureProvider<LatLng>(
              create: (context) => distanceService.bestLocation()),
          //FutureProvider(create: (context) => distanceService.bestLocation()),
          FutureProvider(create: (context) {
            ImageConfiguration configuration =
            createLocalImageConfiguration(context);
            return BitmapDescriptor.fromAssetImage(
                configuration, 'assets/images/parking-icon.png');
          }),
          ProxyProvider2<Position, BitmapDescriptor, Future<List<Place>>>(
            update: (context, position, icon, places,) {
              return (position != null)
                  ? placesService.getPlaces(
                  position.latitude, position.longitude, icon)
                  : null;
            },
          )
        ],
        child: MaterialApp(
          title: 'Parking App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: Search(),
        ),
      ),
    );
  }
}