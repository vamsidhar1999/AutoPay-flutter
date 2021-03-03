import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

class DistanceService {
  final key = 'AIzaSyArJzFNe1UoSEVHCjaAmEL9zVZKv8Nrkj8';
  Future<LatLng> bestLocation() async {
    Position pos1 = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double clat = pos1.latitude;
    double clng = pos1.longitude;
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$clat,$clng&type=parking&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    int limit=json.length;
    LatLng smalllatlang;
    //print('json value : $limit');
    //double lat = json['results'][0]['geometry']['location']['lat'];
    //double lng = json['results'][0]['geometry']['location']['lng'];
    List lat = [];
    List lng = [];
    for (int k = 0; k < limit; k++) {
      /*if (json['results'][k]['geometry']['location']['lat'] != null &&
          json['results'][k]['geometry']['location']['lng'] != null) {*/
      lat.insert(k, json['results'][k]['geometry']['location']['lat']);
      lng.insert(k, json['results'][k]['geometry']['location']['lng']);
      // }
    }
    print('lat value : $lat');
    int num = lat.length;
    var rg = Random();
    int min = 100, max = 150;
    List prices = [];
    for (int j = 0; j < num; j++) {
      prices.add(min + rg.nextInt(max - min));
    }
    List distances = [];
    for (int i = 0; i < num; i++) {
      distances.add(
          (Geolocator.distanceBetween(clat, clng, lat[i], lng[i])) * prices[i]);
    }
    if (num >= 2) {
      double min=distances[0];
      for (int i = 0; i < num; i++) {
        if (distances[i] <= min) {
          smalllatlang = LatLng(lat[i], lng[i]);
        }
      }
    } else {
      smalllatlang = LatLng(lat[0], lng[0]);
    }
    return smalllatlang;
  }
}
