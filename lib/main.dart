import 'package:autopayflutter/Authentication/SplashScreen.dart';
import 'package:autopayflutter/DashBoard.dart';
import 'package:autopayflutter/PaymentMsg.dart';
import 'package:autopayflutter/things/ACorderDetails.dart';
import 'package:autopayflutter/things/orderDetails.dart';

import 'Authentication/SplashScreen.dart';
import 'Authentication/SplashScreen.dart';
import 'Authentication/SplashScreen.dart';
import 'things/CarRegister.dart';
import 'things/FridgeRegister.dart';
import 'things/WasherRegister.dart';
import 'things/ThingsDashboard.dart';
import 'things/transactiondesign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:autopayflutter/maps/models/place.dart';
import 'package:autopayflutter/maps/services/distance_service.dart';
import 'package:autopayflutter/maps/services/geolocator_service.dart';
import 'package:autopayflutter/maps/services/places_service.dart';

import 'things/transactiondesign.dart';
import 'things/transactiondesign.dart';
import 'things/transactionsboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  initializeFirebase() async {
    await Firebase.initializeApp();
  }
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  final distanceService = DistanceService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
          primarySwatch: Colors.blue,
        ),
        home: ACOrderDetails(),
      ),
    );
  }
}
