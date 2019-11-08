// DEPRECIADO!!!
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';

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
              key: UniqueKey(),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: snapshot.data,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              markers: Set.from(marcas),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
