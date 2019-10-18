import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => new _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Position _currentPosition;
  File _image;

  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future _getImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((img) {
      setState(() {
        _image = img;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Novo foco',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoScrollbar(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Text('$_currentPosition'),
                  Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: _image == null
                        ? OutlineButton(
                            borderSide:
                                BorderSide(color: Colors.red[200], width: 4),
                            onPressed: () {
                              _getImage();
                            },
                            child: Center(
                              heightFactor: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.camera_alt),
                                  Text('Tire uma foto do foco')
                                ],
                              ),
                            ),
                          )
                        : Image.file(
                            _image,
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                  Text('$_currentPosition'),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: MapFoco(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MapFoco extends StatefulWidget {
  @override
  State<MapFoco> createState() => MapFocoState();
}

class MapFocoState extends State<MapFoco> {
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
        infoWindow: InfoWindow(
            title: 'Foco 1',
            onTap: () {
              print('Foco 1');
            }),
        onTap: () {
          print('Unit Mano');
        },
        position: LatLng(-10.9689128, -37.0592988),
      ),
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
