import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';
import 'package:vetores/src/models/foco.model.dart';

class MapVetores extends StatefulWidget {
  @override
  State<MapVetores> createState() => MapVetoresState();
}

class MapVetoresState extends State<MapVetores> {
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();

  Completer<GoogleMapController> _controller = Completer();

  Position _currentPosition = Position(latitude: 0, longitude: 0);

  Uint8List markerIcon = Uint8List(0);

  List<Marker> marcas = [];
  List<Circle> circulos = [];
  List<LatLng> pontos = [];
  List<Polygon> poligonos = [];

  void _getCurrentLocation() {  
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          setState(() {
            _currentPosition = position; 
            _goLocation(buildCameraPosition());
          });      
    }).catchError((e) {
      print(e);
    });
  }

  CameraPosition buildCameraPosition() {
    return CameraPosition(
      target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      zoom: 16,
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _getCurrentLocation();
    bloc.fetchFocos();

    getBytesFromAsset('assets/icons/marker.png', 100).then((onValue) {
      setState(() {
        markerIcon = onValue;
      });
    });
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // ImageConfiguration imageConfig =
    //     ImageConfiguration(devicePixelRatio: mediaQueryData.devicePixelRatio);
    // BitmapDescriptor.fromAssetImage(imageConfig, 'assets/icons/marker.png')
    //     .then((onValue) {
    //   myIcon = onValue;
    // });

    // Circle example
    // circulos.add(
    //   Circle(
    //     fillColor: CupertinoColors.activeOrange.withOpacity(0.25),
    //     strokeColor: CupertinoColors.black,
    //     center: LatLng(-10.9689128, -37.0592988),
    //     radius: 50,
    //     circleId: CircleId('Meu ovo'),
    //     onTap: () {
    //       print('Meu ovo');
    //     },
    //   ),
    // );

    // Polygon example
    // pontos.add(LatLng(-10.9689128 + 0.0005, -37.0592988 + 0.0005));
    // pontos.add(LatLng(-10.9689128 - 0.0005, -37.0592988 + 0.0005));
    // pontos.add(LatLng(-10.9689128 - 0.0005, -37.0592988 - 0.0005));
    // pontos.add(LatLng(-10.9689128 + 0.0005, -37.0592988 - 0.0005));
    // poligonos.add(
    //   Polygon(
    //       polygonId: PolygonId('Meu Saco'),
    //       fillColor: Colors.blue.withOpacity(0.5),
    //       strokeColor: Colors.redAccent,
    //       points: pontos),
    // );
  }
  
  Future<void> _goLocation(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
    
  }
  @override
  Widget build(BuildContext context) {    

    return StreamBuilder(
      stream: bloc.allFocos,
      builder: (context, AsyncSnapshot<List<Foco>> snapshot) {
        if (snapshot.hasData) {
          // List<Foco> pontosDeFoco = List<Foco> snapshot.data.;
          // return Text(snapshot.data[0].lat);
          print(snapshot.data);
          for (var data in snapshot.data) {
            print(
                "lat: ${data.coordenadas.latitude} | lng:${data.coordenadas.longitude}");
            marcas.add(
              Marker(
                markerId: MarkerId('${data.imagem.name}'),
                draggable: false,
                flat: true,
                icon: BitmapDescriptor.fromBytes(markerIcon),
                // infoWindow: InfoWindow(
                //   title: data.imagem.name,
                //   snippet: data.imagem.url,
                //   onTap: () {
                //     Navigator.of(context).push(
                //       CupertinoPageRoute(
                //         title: 'Detalhes do foco: ${data.imagem.name}',
                //         settings: RouteSettings(name: '/details'),
                //         builder: (context) {
                //           return FocoDetailPage();
                //         },
                //       ),
                //     );
                //   },
                // ),
                onTap: () {
                  print('${data.imagem.name}');
                },
                position: LatLng(
                    data.coordenadas.latitude, data.coordenadas.longitude),
              ),
            );
          }

          return GoogleMap(
            rotateGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: buildCameraPosition(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set.from(marcas),
            // circles: Set.from(circulos),
            // polygons: Set.from(poligonos),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
