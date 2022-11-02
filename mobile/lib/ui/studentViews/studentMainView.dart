

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

  String titulo = "Cambio/Inst. Medidores";
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
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate()
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            onTap: () async {
            },
            child: Icon(Icons.upload_rounded),
          ),
        ),
        //drawer: navBar(),
        body: _isLoading
            ? Center(
            child: Container(
                child: CircularProgressIndicator()
            ) ): Center(
          child: Column(
            children: <Widget>[
              _List_2([],_iconsList[currentIcon]),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit() async
  {
    Code.submit = true;

    //await dataLoadFunction();
    //cd.changeBloc(1);
    //context.read<MyBloc>().add(EventMeasureInstallation());
    Code.submit = false;
  }

  _List_2( List<road> datos, Icon iconCurrent) => Expanded(
    child: Container(
      child: ListView.builder(
        //reverse: true,
        itemBuilder: (BuildContext, index){
          int rindex = datos.length - 1 - index;
          var data = datos[rindex];
          return Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 8, 15, 4),
                  leading: Icon(Icons.add_business),
                  title: Text('Relleno'),
                  subtitle: Text("Info extra: "),
                  trailing: Icon(Icons.keyboard_arrow_left_rounded),
                  onTap: () async {

                  },
                ),
                Code.getDivider(),
              ],
            ),
          );
        },
        itemCount: datos.length,
      ),
    ),
  );

  Code cd = new Code();

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

}

///Searchbar...
class CustomSearchDelegate extends SearchDelegate{

  DataBaseHelper _dbHelper = DataBaseHelper.instance;

  final List<String> listDescription = Code.listSearch;

  List<Icon> iconList =
  [
    Icon(Icons.plumbing_rounded,
        color: darkBlueColor,
        size: 35.0),

    Icon(Icons.plumbing_rounded,
        color: Colors.green.shade600,
        size: 35.0),
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      hintColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
      accentColor: Colors.white, // for the green line
      scaffoldBackgroundColor: Colors.grey.shade100, // for the body color
      brightness: Brightness.dark, // to get white statusbar icons
      //primaryColor:  , // set background color of SearchBar
      appBarTheme: const AppBarTheme(
        color: Colors.green, // affects AppBar's background color
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext){
    return [
      IconButton(
          icon: const Icon(Icons.clear, size: 20,),
          onPressed:(){
            query ='';
          }
      )
    ];
  }

  @override
  IconButton buildLeading (BuildContext context){
    return IconButton(
        icon: const Icon(Icons.keyboard_arrow_left_rounded),
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  ListView buildResults(BuildContext){
    List<String> matchQuery = [];
    for(var fruit in listDescription){
      if(fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: (){
          },
        );
      },
    );
  }

  @override
  ListView buildSuggestions(BuildContext){
    List<String> matchQuery = [];
    for(var fruit in listDescription){
      if(fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context,index){
          var description = matchQuery[index];
          return Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.keyboard_arrow_left_rounded),
                    contentPadding: EdgeInsets.fromLTRB(15, 8, 15, 4),
                    title: Text(description,
                      style: TextStyle(
                          color: darkBlueColor,
                          fontWeight: FontWeight.bold),),
                    subtitle: Text('Nuevo medidor: '),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded,
                      color: Colors.green,
                      size: 25,),
                    onTap: () async {

                    },
                  ),
                  Code.getDivider(),
                ]
            ),
          );
        }
    );
  }
  Code cd = new Code();
}