import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';
import 'package:vetores/src/models/foco.model.dart';
import 'package:vetores/src/ui/pages/focodetail_page.dart';

class MapVetores extends StatefulWidget {
  @override
  State<MapVetores> createState() => MapVetoresState();
}

class MapVetoresState extends State<MapVetores> {
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();

  Completer<GoogleMapController> _controller = Completer();

  Position _currentPosition;

  BitmapDescriptor myIcon;
  CameraPosition _myPosition;

  List<Marker> marcas = [];
  List<Circle> circulos = [];
  List<LatLng> pontos = [];
  List<Polygon> poligonos = [];

  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position);
      _currentPosition = position;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              size: Size(0.0313, 0.0313),
            ),
            'assets/icons/marker.png')
        .then((onValue) {
      myIcon = onValue;
    });

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

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();

    _myPosition = CameraPosition(
      target: LatLng(-10.972310, -37.057430),
      zoom: 20,
    );

    bloc.fetchFocos();

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
                icon: myIcon,
                infoWindow: InfoWindow(
                  title: data.imagem.name,
                  snippet: data.imagem.url,
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        title: 'Detalhes do foco: ${data.imagem.name}',
                        settings: RouteSettings(name: '/details'),
                        builder: (context) {
                          return FocoDetailPage();
                        },
                      ),
                    );
                  },
                ),
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
            initialCameraPosition: _myPosition,
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
