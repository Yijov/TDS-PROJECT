import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tds_project_mobile/ui/login/loginPage.dart';
import 'package:tds_project_mobile/ui/studentViews/map.dart';
import 'package:tds_project_mobile/ui/studentViews/studentMainView.dart';
import 'package:tds_project_mobile/utils/Code.dart';
import 'package:tds_project_mobile/utils/blocClass.dart';

MaterialColor mycolor = MaterialColor(0xff43a047, <int, Color>{
  50: Color(0xff43a047),
  100: Color(0xff43a047),
  200: Color(0xff43a047),
  300: Color(0xff43a047),
  400: Color(0xff43a047),
  500: Color(0xff43a047),
  600: Color(0xff43a047),
  700: Color(0xff43a047),
  800: Color(0xff43a047),
  900: Color(0xff43a047),
},
);

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    BlocProvider(
      create: (context) => MyBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tracking-Mobile-App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<MyBloc, MyState>(
          builder: (_, state) {
            Widget wdg = loginPageView();
            switch(Code.numSwitch) {
              case 1:
                if (state is StatePageStudentListView)
                {wdg = pageStudentListView();}
                break;
              case 2:
                if (state is StateMap)
                {wdg = Map();}
                break;
              default:
                wdg = loginPageView();
                break;
            }
            return wdg;
          }
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(widget.title,
            style: TextStyle(color: Colors.white),),
        ),
      ),
      //drawer: navBar(),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(""),
            ),
          ),
        ),
      ),
    );
  }
}