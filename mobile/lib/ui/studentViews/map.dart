import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tds_project_mobile/utils/Code.dart';

import 'dart:developer' as developer;

import 'package:tds_project_mobile/utils/dbHelper.dart';

const darkBlueColor = Color(0xff486579);

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _Map();
}

class _Map extends State<Map> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  DataBaseHelper _dbHelper = DataBaseHelper.instance;

  String titulo = 'Geo. Medidor';

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  String _lat = '';
  String _log = '';

  var locationMsg;
  late final Position lastPosition;

  void getCurrentLocation() async{
              lastPosition = (await Geolocator.getLastKnownPosition())!;
        _lat = lastPosition.latitude.toString();
        _log = lastPosition.longitude.toString();
        setState(() {
          _goToCurrentPosition();
        });

    }


  Future<void> _goToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lastPosition.latitude, lastPosition.longitude), 19.151926040649414));
  }

  //late GoogleMapController _ctrlGoogleMap;
  Marker? _origin;
  Marker? _destination;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      initConnectivity();

      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
      _determinePosition();
      getCurrentLocation();
      //_locationMap = Location.ct;
    });
  }

  bool re = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async
      {
        return re;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade600,
          title: Center(
            child: Text(titulo,
              style: TextStyle(
                color: Color.fromARGB(255, 245, 235, 235),
              ),
            ),
          ),
          leading: GestureDetector(
            child: Icon( Icons.keyboard_arrow_left_rounded, color: Colors.white ),
            onTap: () {}
          ) ,
          automaticallyImplyLeading: true,
        ),
        body:
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                margin:  EdgeInsets.fromLTRB(0, 5, 0, 5),
                height: Code.ScreenSize(context) - 170,
                child: GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(target:
                  LatLng(18.735693, -70.162651),
                      zoom: 8.5),
                  mapType: _currentMapType,
                  onMapCreated: _onMapCreated,
                  markers: {
                    if (_origin != null) _origin as Marker,
                    if(_destination != null) _destination as Marker,
                  },
                ),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext,index) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text('Lat: ' + _lat,
                                style: TextStyle(fontWeight: FontWeight.w500),),
                              SizedBox(height: 5,),
                              Text('Log: ' + _log,
                                style: TextStyle(fontWeight: FontWeight.w500),),
                            ],
                          ),
                          _onMapTypeButtonPressed(),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MapType _currentMapType = MapType.hybrid;

  _onMapTypeButtonPressed() {
    return PopupMenuButton(
      icon: Icon(Icons.map_rounded),
      onSelected: (selectedValue)
      {
        switch(selectedValue)
        {
          case 1:
            setState(() {
              _currentMapType =  MapType.hybrid;
            });
            break;
          case 2:
            setState(() {
              _currentMapType =  MapType.terrain;
            });
            break;
          case 3:
            setState(() {
              _currentMapType =  MapType.satellite;
            });
            break;
          case 4:
            setState(() {
              _currentMapType =  MapType.normal;
            });
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context)
      => [
        PopupMenuItem(child: Text('Hibrido'), value: 1,),
        PopupMenuItem(child: Text('Terreno'), value: 2,),
        PopupMenuItem(child: Text('Satelital'), value: 3,),
        PopupMenuItem(child: Text('Normal'), value: 4,)
      ],
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  _showAlert(String titulo, String msj)
  {
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(msj),
    );

    showDialog(
        context: context,
        builder: (_) => alert);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    Code cd2 = Code();
    switch(result)
    {
      case ConnectivityResult.none:
        _showAlert('AVISO!', 'Sin conexion a red, la ubicacion se tomara automaticamente, recuerde pulsar el boton de guardar antes de salir');
        cd2.show('Sin conexion a red', 3, Colors.red, 20, context);
        break;
      default:
        break;
    }
  }

}