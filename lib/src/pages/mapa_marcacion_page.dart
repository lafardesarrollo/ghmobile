import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghmobile/src/models/marcacion.dart';
import 'package:ghmobile/src/models/regional.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class MapaMarcacionPage extends StatefulWidget {
  Marcacion? marcaje;
  Regional? regional;
  MapaMarcacionPage({Key? key, this.marcaje, this.regional}) : super(key: key);

  @override
  MapaMarcacionPageState createState() => MapaMarcacionPageState();
}

class MapaMarcacionPageState extends State<MapaMarcacionPage> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();
  Set<Circle> circles = Set();

  Map<MarkerId, Marker> _markers = Map();

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
  void initState() {
    _redirigirRegional();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text(widget.regional!.nombre!),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          var ubicacion_regional = widget.regional!.ubicacion!.split(',');

          _controller.complete(controller);
          _setMarkerRegional(
            LatLng(
              double.parse(ubicacion_regional[0]),
              double.parse(ubicacion_regional[1]),
            ),
          );

          _setCircles(
            LatLng(
              double.parse(ubicacion_regional[0]),
              double.parse(ubicacion_regional[1]),
            ),
          );
        },
        markers: Set.of(_markers.values),
        circles: circles,
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        // onPressed: () => _redirigirRegional(),
        label: Text('Volver!'),
        icon: Icon(Icons.keyboard_return_outlined),
      ),
    );
  }

  Future<void> _redirigirRegional() async {
    var ubicacion_regional = widget.regional!.ubicacion!.split(',');
    // print(ubicacion_regional[0]);
    CameraPosition _regionalPosicion = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
          double.parse(ubicacion_regional[0]),
          double.parse(
            ubicacion_regional[1],
          ),
        ),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_regionalPosicion));
  }

  _setMarkerRegional(LatLng p) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/img/lafar_cyan.png', 100);
    final markerId = MarkerId('${widget.regional!.id}');
    final marker = Marker(
        markerId: markerId,
        position: p,
        icon: BitmapDescriptor.fromBytes(markerIcon));
    setState(() {
      _markers[markerId] = marker;
    });
  }

  void _setCircles(LatLng point) {
    final String circleIdVal = '${circles.length}';
    circles.add(
      Circle(
          circleId: CircleId(circleIdVal),
          center: point,
          radius: 30.0,
          fillColor: Theme.of(context).dividerColor, // .withOpacity(0.5),
          strokeWidth: 3,
          strokeColor: Theme.of(context).hintColor),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
