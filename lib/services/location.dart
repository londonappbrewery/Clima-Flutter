import 'package:geolocator/geolocator.dart';

class Location {
  double latitiude;
  double longitude;
  Future<dynamic> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitiude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
