import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';
import 'package:vetores/src/config/theme_config.dart';
import 'package:vetores/src/models/foco.model.dart';
import 'package:vetores/src/ui/pages/focodetail_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
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
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();

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
              Navigator.of(context).push(
                CupertinoPageRoute(
                  title: 'Teste',
                  builder: (context) {
                    return FocoDetailPage();
                  },
                ),
              );
            }),
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
        fillColor: CupertinoColors.activeOrange.withOpacity(0.25),
        strokeColor: CupertinoColors.black,
        center: LatLng(-10.9689128, -37.0592988),
        radius: 50,
        circleId: CircleId('Meu ovo'),
        onTap: () {
          print('Meu ovo');
        },
      ),
    );
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
    bloc.fetchFocos();
    return StreamBuilder(
      stream: bloc.allFocos,
      builder: (context, AsyncSnapshot<List<Foco>> snapshot) {
        if (snapshot.hasData) {
          // List<Foco> pontosDeFoco = List<Foco> snapshot.data.;
          // return Text(snapshot.data[0].lat);
          for (var data in snapshot.data) {
            if (data.lat != 'lat' && data.lng != 'lng') {
              print("lat: ${data.lat} | lng:${data.lng}");
              marcas.add(
                Marker(
                  markerId: MarkerId('${data.imagem.name}'),
                  draggable: false,
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
                  position:
                      LatLng(double.parse(data.lat), double.parse(data.lat)),
                ),
              );
            }
          }

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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
