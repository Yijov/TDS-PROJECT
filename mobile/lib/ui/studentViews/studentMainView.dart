

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'dart:developer' as developer;

import '../../models/road.dart';
import '../../utils/Code.dart';
import '../../utils/blocClass.dart';
import '../../utils/dbHelper.dart';
import '../navBar/navBar.dart';

const darkBlueColor = Color(0xff486579);

class pageStudentListView extends StatefulWidget {

  @override
  State<pageStudentListView> createState() => _pageStudentListViewState();
}

class _pageStudentListViewState extends State<pageStudentListView> {

  bool _isLoading = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool up = false;

  TextEditingController _textFieldController = TextEditingController();

  DataBaseHelper _dbHelper = DataBaseHelper.instance;


  List<Icon> leadList =
  [
    Icon(Icons.plumbing_rounded,
        color: darkBlueColor,
        size: 35.0),

    Icon(Icons.plumbing_rounded,
        color: Colors.green.shade600,
        size: 35.0),
  ];

  List<Icon> _iconsList =[
    Icon(Icons.keyboard_arrow_right_rounded,
        color: Colors.green.shade600,
        size: 25),
    Icon(Icons.edit,
      color: Colors.green.shade600,
      size: 25,),];

  int currentIcon = 0;

  String titulo = "Tipos de Trabajos";
  double _divAltura = 15.0;

  dataLoadFunction() async {
    Code.submit = true;
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    _dbHelper = DataBaseHelper.instance;
    setState(() {
      _isLoading = false; // your loder will stop to finish after the data fetch
    });
    Code.submit = false;
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      initConnectivity();

      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
      dataLoadFunction();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool re = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async
      {
        //  cd.changeBloc(46);
        //context.read<MyBloc>().add(EventListTypeSurvey());
        return re;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.green.shade600,
          title: Center(
              child: Text(titulo,
                style: TextStyle(
                  color: Color.fromARGB(255, 245, 235, 235),
                ),
              )
          ),
          automaticallyImplyLeading: true,
        ),
        drawer: navBar(),
        body: Center(
          child: Column(
            children: <Widget>[
              //_List(),
              //_ListView_2(),
              _ListTile_2(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Icon> _listType =
  [
    Icon(Icons.bubble_chart, //posicion 0
      color: darkBlueColor,
      size: 35,),

    Icon(Icons.bubble_chart, //posicion 0
      color: darkBlueColor,
      size: 35,),

    Icon(Icons.bubble_chart, //posicion 0
      color: darkBlueColor,
      size: 35,),
  ];

  Icon back = Icon(Icons.keyboard_arrow_right_rounded,
  color: darkBlueColor);

  var event = EventMap();
  var num = 2;

  List<String> _tipo =
  [
    'Charles de Gaulle', //0
    '27 de Febrero', //1
    'Institucion', //2
  ];

  String subTitle = "Ruta";

  List<bool> eneList =
  [
    true,
    true,
    true,
  ];

  _ListTile_2(BuildContext context) => Expanded(
    child: ListView(
        children:
        [
          _getCard(_tipo[0], subTitle, back, 20, 20, 20, 0, event,num,_listType[0], eneList[0]),
          Code.getDivider(),
          _getCard(_tipo[1], subTitle, back, 20, 0, 20, 0, event,num,_listType[1], eneList[1]),
          Code.getDivider(),
          _getCard(_tipo[1], subTitle, back, 20, 0, 20, 0, event,num,_listType[2], eneList[2]),
          Code.getDivider(),
        ]
    ),
  );

  _getCard(String Titulo,String Subtitulo, Icon icon, double izq, double arriba, double der, double abajo, MyEvent wget, int num, Icon lead,bool enabled)
  => Container(
    //color: Colors.white,
    margin:  EdgeInsets.fromLTRB(izq, arriba, der, abajo),
    child: ListTile(
      leading: lead,
      title: Text(Titulo.toUpperCase(),
        style: TextStyle(
          color: darkBlueColor,
          fontWeight: FontWeight.bold,),
      ),
      subtitle: Text(Subtitulo),
      trailing: icon,
      onTap: ()
      {
        if(enabled != false)
        {
          Code.backAction(context, wget, num);
        }
        else
        {
          _showAlert('AVISO', 'Página en construcción.');
        }
      },
    ),
  );

  _showAlert(String title, String msj) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msj),
    );
    showDialog(context: context, builder:
        (_) => alertDialog);
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

  bool canSend = true;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    Code cd2 = Code();
    switch(result)
    {
      case ConnectivityResult.none:
      // _showAlert('AVISO!', 'Sin conexion a red, la ubicacion se tomara automaticamente, recuerde pulsar el boton de guardar antes de salir');
        cd2.show('Sin conexion a red', 3, Colors.red, 20, context);
        break;
      case ConnectivityResult.wifi:
        canSend = true;
        break;
      default:
        canSend = false;
        break;
    }
  }

  Code cd = new Code();
}