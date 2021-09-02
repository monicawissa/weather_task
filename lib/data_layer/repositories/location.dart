class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      // Position position = await Geolocator()
      //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      // latitude = position.latitude;
      // longitude = position.longitude;
      latitude = 30.0074;
      longitude = 31.4913;
    } catch (e) {
      print(e);
    }
  }
}
