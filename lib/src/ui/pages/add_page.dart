import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => new _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();

  Position _currentPosition;
  File _image;

  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          print(position);
      bloc.setCoordenadas(LatLng(position.latitude, position.longitude));
    }).catchError((e) {
      print(e);
    });
  }

  Future _getImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((img) {
      bloc.setFoto(img);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 128, top: 32, bottom: 32),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Ajude a identificar os focos de vetores e faça a diferença contribuindo nas pesquisas.',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: CupertinoColors.inactiveGray),
                        ),
                      ],
                    ),
                  ),
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
                            borderSide: BorderSide(
                                color: CupertinoColors.activeBlue, width: 4),
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
                  Text("Localização"),
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
                      bloc.send( );
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
  @override
  State<MapFoco> createState() => _MapFocoState();
}

class _MapFocoState extends State<MapFoco> {
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();
  Completer<GoogleMapController> _controller = Completer();
 
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
            title: 'O foco esta aqui!!!',
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
    return StreamBuilder(
        stream: bloc.coordenadas,
        builder: (context, AsyncSnapshot<LatLng> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              rotateGesturesEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: snapshot.data,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set.from(marcas),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
