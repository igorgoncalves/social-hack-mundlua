import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          child: Icon(MdiIcons.helpCircleOutline),
          onPressed: () {
            _launchURL();
          },
        ),
        middle: Text(
          'Mapa',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: MapSample(),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://vetores.app';
    if (await canLaunch(url)) {
      await launch(
        url,
        // forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
      print('deu ruim');
    }
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-10.9689128, -37.0592988),
    zoom: 16,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-10.9689128, -37.0592988),
      tilt: 59.440717697143555,
      zoom: 5.151926040649414);

  List<Marker> marcas = [];
  List<Circle> circulos = [];
  List<LatLng> pontos = [];
  List<Polygon> poligonos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marcas.add(
      Marker(
        markerId: MarkerId('Unit'),
        draggable: false,
        onTap: () {
          print('Unit Mano');
        },
        position: LatLng(-10.9689128, -37.0592988),
      ),
    );
    marcas.add(
      Marker(
        markerId: MarkerId('Unit2'),
        draggable: false,
        onTap: () {
          print('Unit2 Mano');
        },
        position: LatLng(-10.9689128 + 0.00005, -37.0592988 + 0.00005),
      ),
    );

    circulos.add(
      Circle(
        fillColor: Colors.amber.withOpacity(0.25),
        strokeColor: Colors.black,
        center: LatLng(-10.9689128, -37.0592988),
        radius: 50,
        circleId: CircleId('Meu ovo'),
        onTap: () {
          print('Meu ovo');
        },
      ),
    );

    pontos.add(LatLng(-10.9689128 + 0.0005, -37.0592988 + 0.0005));
    pontos.add(LatLng(-10.9689128 - 0.0005, -37.0592988 + 0.0005));
    pontos.add(LatLng(-10.9689128 - 0.0005, -37.0592988 - 0.0005));
    pontos.add(LatLng(-10.9689128 + 0.0005, -37.0592988 - 0.0005));
    poligonos.add(
      Polygon(
          polygonId: PolygonId('Meu Saco'),
          fillColor: Colors.blue.withOpacity(0.5),
          strokeColor: Colors.redAccent,
          points: pontos),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      rotateGesturesEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set.from(marcas),
      circles: Set.from(circulos),
      polygons: Set.from(poligonos),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
