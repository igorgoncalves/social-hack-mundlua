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

  var _selectedIndexValue;
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
                  Text("Registro fotográfico"),
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
                  Divider(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: MapFoco(
                        myPosition: _currentPosition,
                      ),
                    ),
                  ),
                  Divider(),
                  // Text('Veores relacionados ao foco:'),
                  // CupertinoSegmentedControl(
                  //   children: {
                  //     0: Text("Aedes Aegypti"),
                  //     1: Text("Bar"),
                  //   },
                  //   groupValue: _selectedIndexValue,
                  //   onValueChanged: (value) {
                  //     setState(() => _selectedIndexValue = value);
                  //   },
                  // ),
                  CupertinoButton(
                    padding: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8),
                    color: CupertinoColors.activeGreen,
                    disabledColor: CupertinoColors.inactiveGray,
                    child: Text("Enviar"),
                    onPressed: () {
                      print("Eniado");
                    },
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
  final Position myPosition;

  const MapFoco({Key key, this.myPosition}) : super(key: key);
  @override
  State<MapFoco> createState() => _MapFocoState();
}

class _MapFocoState extends State<MapFoco> {
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

  BitmapDescriptor myIcon;

  @override
  void initState() {
    // TODO: implement initState
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/icons/marker.png')
        .then((onValue) {
      myIcon = onValue;
    });
    super.initState();
    marcas.add(
      Marker(
        markerId: MarkerId('Unit'),
        icon: myIcon,
        draggable: false,
        infoWindow: InfoWindow(
            title: 'O fco esta aqui!!!',
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
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
