
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tds_project_mobile/models/position_Travel.dart';
import 'package:tds_project_mobile/models/road.dart';
import 'package:tds_project_mobile/models/rol.dart';
import 'package:tds_project_mobile/models/travel.dart';
import 'package:tds_project_mobile/models/user.dart';

class DataBaseHelper {
  static const _dataBaseName = 'TDS-Tracking.db';
  static const _dataBaseVersion = 1;

  //singleton class
  DataBaseHelper._();

  static final DataBaseHelper instance = DataBaseHelper._();

  Future<Database> get database async {
    Database _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.toString(), _dataBaseName);
    return openDatabase(
        dbPath, version: _dataBaseVersion, onCreate: _onCreateBD);
  }

  _onCreateBD(Database db, int version) async {

    await db.execute('''
      Create table ${user.tblUser}
      (
        ${user.colIdUser} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${user.colIdRol} INTEGER NULL,
        ${user.colName} TEXT NULL,
        ${user.colUserName} TEXT NULL,
        ${user.colStudentCode} TEXT NULL,
        ${user.colIdentCard} TEXT NULL,
        ${user.colPassword} TEXT NULL,
        
        FOREIGN KEY (${user.colIdRol})
        REFERENCES ${rol.tblRol}
        (${rol.colIdRol})
      )
    ''');

    await db.execute(
      '''
      Create table ${rol.tblRol}
      (
        ${rol.colIdRol} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${rol.colDescription} TEXT NULL
      )
      '''
    );

    await db.execute('''
      Create table ${road.tblRoad}
      (
        ${road.colIdRoad} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${road.colIdUser} INTEGER NULL,
        ${road.colDescription} TEXT NULL,
        ${road.colSchedule} TEXT NULL
      )
    ''');

    await db.execute('''
      Create table ${travel.tblTravel}
      (
        ${travel.colIdTravel} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${travel.colIdUser} INTEGER NULL,
        ${travel.colIdRoad} INTEGER NULL,
        ${travel.colTime} TEXT NULL,
        
        FOREIGN KEY (${travel.colIdUser})
        REFERENCES ${user.tblUser}
        (${user.colIdUser}),
        
        FOREIGN KEY (${travel.colIdRoad})
        REFERENCES ${road.tblRoad}
        (${road.colIdRoad})
      )
    ''');

    await db.execute('''
      Create table ${position_Travel.tblPositionTravel}
      (
        ${position_Travel.colIdPosition} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${position_Travel.colIdTravel} INTEGER NULL,
        ${position_Travel.colLocationLatitude} TEXT NULL,
        ${position_Travel.colLocationLongitude} TEXT NULL,
        ${position_Travel.colTime} TEXT NUll,
        
        FOREIGN KEY (${position_Travel.colIdTravel})
        REFERENCES ${travel.tblTravel}
        (${travel.colIdTravel})
      )
    ''');
  }

}
