

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tds_project_mobile/utils/blocClass.dart';


class Code
{

  static List<String> listSearch = [];
  static bool submit = false;
  static int numSwitch = 0;
  static final darkBlueColor = Color(0xff486579);

  static backAction(BuildContext con, MyEvent event, int switchVal)
  {
    numSwitch = switchVal;
    con.read<MyBloc>().add(event);
  }

  show(String title, int time, var color, double altura,BuildContext context)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: altura,
          child: Center(
            child: Text(title),
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: time),
      ),
    );
  }

  static getDivider()
  {
    return Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          Text("*", style: TextStyle(color: darkBlueColor),),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
        ]
    );
  }

  changeBloc(int i){
    numSwitch = i;
  }

  static ScreenSize(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static showAlert(BuildContext con,String title, String msj) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msj),
    );
    showDialog(context: con, builder:
        (_) => alertDialog);
  }

}