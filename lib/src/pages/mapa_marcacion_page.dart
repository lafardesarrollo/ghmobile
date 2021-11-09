import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/marcacion.dart';
import 'package:ghmobile/src/models/regional.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaMarcacionPage extends StatefulWidget {
  Marcacion? marcaje;
  Regional? regional;
  MapaMarcacionPage({Key? key, this.marcaje, this.regional}) : super(key: key);

  @override
  MapaMarcacionPageState createState() => MapaMarcacionPageState();
}

class MapaMarcacionPageState extends State<MapaMarcacionPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-16.5458425, -68.2287310),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text('Volver!'),
        icon: Icon(Icons.keyboard_return_outlined),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
