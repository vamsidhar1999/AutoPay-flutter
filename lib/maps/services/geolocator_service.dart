import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    Position pos1 = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return pos1; //geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, locationPermissionLevel: GeolocationPermission.location);
  }

  getDistance(double startLatitude, double startLongitude, double endLatitude,
      double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  getUserLocation() async {
    LatLng _center;
    Position currentLocation;
    currentLocation = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    return _center;
  }
}
/* Future<Position> getLocation() async {
    /* Set _markers = {};
    LatLng latlong;
    CameraPosition _cameraPosition;
    GoogleMapController _controller;*/
    Position pos1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // ignore: missing_return
    /* setState(() {
      latlong = new LatLng(pos1.latitude, pos1.longitude);
      _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
      if (_controller != null)
        _controller
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      _markers.add(Marker(
          markerId: MarkerId("a"),
          draggable: true,
          position: latlong,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onDragEnd: (_currentlatLng) {
            latlong = _currentlatLng;
          }));
    });*/

    return pos1;
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  /* void setState(Position Function() param0) {}*/
}
*/
