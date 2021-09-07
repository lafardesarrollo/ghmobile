import 'package:location/location.dart';

Future<Stream<LocationData>> obtenerLocalizacionActual() async {
  Location location = new Location();
  LocationData _locationData;
  _locationData = await location.getLocation();

  return new Stream.value(_locationData);
}
