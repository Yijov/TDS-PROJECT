import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../utils/Code.dart';
import '../../utils/blocClass.dart';
import '../../utils/dbHelper.dart';

class navBar extends StatelessWidget {

  //DataBaseHelper _dbHelper = DataBaseHelper.instance;
  bool condicionIf = true;

  List<String> _tipo =
  [
    'Charles de Gaulle', //0
    '27 de Febrero', //1
    'Institucion', //2
    'Cerrar sesion', //3
  ];

  String subTitle = "Ruta";
  String msj = "Espere a que la accion finalize";
  String msjTitle = "Aviso!";

  List<MyEvent> eventList =
  [
    EventMap(), //0
    EventLoginPageView() //1
  ];
  List<int> numList =
  [
    2, //0 Map
    0, //1 Login
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                /*Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("lib/img/LogoTrade_transparencia__horizontal.png"),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          Code.getDivider(),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            title: Text(_tipo[0],
              style: TextStyle(
                  fontWeight: FontWeight.w600
              ),),
            trailing: Icon(Icons.keyboard_arrow_right_rounded,
              color: Code.darkBlueColor,
              size: 24.0,
            ),
            onTap: () {
                if(Code.submit != true)
                {
                  Code.backAction(context, eventList[0], numList[0]);
                }else
                {
                  Code.showAlert(context, msjTitle, msj);
                }
            },
          ),
          Code.getDivider(),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            title: Text(_tipo[1],
              style: TextStyle(
                  fontWeight: FontWeight.w600
              ),),
            trailing: Icon(Icons.keyboard_arrow_right_rounded,
              color: Code.darkBlueColor,
              size: 24.0,
            ),
            onTap: (){
                if(Code.submit != true)
                {
                  Code.backAction(context, eventList[0], numList[0]);
                }else
                {
                  Code.showAlert(context, msjTitle, msj);
                }
            },
          ),
          Code.getDivider(),
          ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,0,30,0),
              title: Text(_tipo[2],style: TextStyle(
                      fontWeight: FontWeight.w600)),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  color: Code.darkBlueColor,
                  size: 24.0),
              onTap: ()
              {
                if(Code.submit != true)
                {
                  Code.backAction(context, eventList[0], numList[0]);
                }else
                {
                  Code.showAlert(context, msjTitle, msj);
                }
              }
          ),
          Code.getDivider(),
          ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,0,30,0),
              title: Text(_tipo[3],style: TextStyle(
                  fontWeight: FontWeight.w600)),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  color: Code.darkBlueColor,
                  size: 24.0),
              onTap: () async
              {
                if(Code.submit != true)
                {
                  Code.backAction(context, eventList[1], numList[1]);
                }else
                {
                  Code.showAlert(context, msjTitle, msj);
                }
              }
          ),
          Code.getDivider(),
        ],
      ),
    );
  }

  DataBaseHelper _dbHelper = DataBaseHelper.instance;
  Code cd = new Code();
}