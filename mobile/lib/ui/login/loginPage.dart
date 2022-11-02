import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tds_project_mobile/utils/blocClass.dart';
import '../../utils/Code.dart';
import 'dart:developer' as developer;


//Variables
//-------------------------------------------------------------------
//Variable color, Tono "principal"
const darkBlueColor = Color(0xff486579);

//Variable para ajustar el heist de los sizedBox
const _altura = 35.0;

class loginPageView extends StatefulWidget {

  @override
  _loginPageViewState createState() => _loginPageViewState();
}

class _loginPageViewState extends State<loginPageView> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  String? userName;
  String? PWD;

  final _formKey = GlobalKey<FormState>();

  var _ctrlUser = TextEditingController();
  var _ctrlPWD = TextEditingController();
  var _ctrlEmail = TextEditingController();

  String txt0 ="Usuario";
  String txt1 ="Contraseña";
  String btn_Txt = "Enter";
  String titulo = "Login";

  @override
  void initState(){
    super.initState();
    setState(() {
      initConnectivity();

      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Center(
          child: Text(titulo,
            style: TextStyle(color: Color.fromARGB(255, 245, 235, 235),),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _form(),
          ],
        ),
      ),
    );
  }

  int coluVal = 0;
  List<Icon> ico =
  [
    Icon(Icons.visibility_off_rounded,
        size: 18,
        color: Colors.grey),
    Icon(Icons.remove_red_eye_rounded,
        size: 18,
        color: Colors.green.shade600),
  ];

  _form() =>Expanded(
    child: Container(
      margin:  EdgeInsets.fromLTRB(20, 30, 20, 30),
      //color: Colors.white,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Form(
          key: _formKey,
          child:  SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 2,),
                /*Container(
                  height: 190,
                  margin: EdgeInsets.fromLTRB( 18, 0, 18, 0),
                  //padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(""),
                    ),
                  ),
                ),*/
                Code.getDivider(),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child:
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: null,
                          minLines: 1,
                          controller: _ctrlUser,
                          decoration: InputDecoration(labelText: txt0,
                            enabled: autoLead,
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.assignment_ind_rounded,
                              color: darkBlueColor,
                              size: 26,),
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              icon: Icon(Icons.clear,
                                size: 18,),
                              onPressed: () {_ctrlUser.clear();},
                            ),
                          ),
                          onSaved: (val) {
                            userName = val.toString();
                          },
                          validator: (val){
                            if(val!.isEmpty) {
                              return "Complete el campo";
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _ctrlPWD,
                          obscureText: seePwd,
                          decoration: InputDecoration(labelText: txt1,
                            enabled: autoLead,
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.lock_rounded,
                              color: darkBlueColor,
                              size: 26,),
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              icon: ico[coluVal],
                              onPressed: () {
                                setState(() {
                                  switch(seePwd)
                                  {
                                    case true:
                                      seePwd = false;
                                      coluVal = 1;
                                      break;
                                    case false:
                                      seePwd = true;
                                      coluVal = 0;
                                      break;
                                  }
                                });
                              },
                            ),),
                          onSaved: (val) {
                            PWD = val.toString();
                          },
                          validator: (val) {if(val!.isEmpty) {
                            return "Complete el campo";
                          }
                          },
                        ),
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.all(10.0),
                              height: 40,
                              width: 100,
                              //child: Directionality(
                              //textDirection: TextDirection.rtl,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:  Colors.green,
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.black54,
                                  //shape: StadiumBorder(),
                                ),
                                onPressed: () async{
                                  await _onSubmit();
                                },
                                child: Text(btn_Txt,
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                //icon: cd.icon,
                              ),
                              //),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
                Code.getDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  bool seePwd = true;

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      cd.changeBloc(1);
      context.read<MyBloc>().add(EventPageStudentListView());
    }
  }

  late bool pass;

  _clearText(){
    _ctrlUser.clear();
    _ctrlPWD.clear();
  }

  Code cd = new Code();
  Code cd2 = new Code();
  bool autoLead = true;

  _showAlert()
  {
    AlertDialog alert = AlertDialog(
        title: Text('Procesando sesion'),
        content: Container(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            )
        )
    );

    showDialog(context: context,
        builder:
            (_)=> alert);
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
        cd2.show('Sin conexion a red', 3, Colors.red, 20, context);
        break;
      default:
        break;
    }

    _connectionStatus = result;

  }

}