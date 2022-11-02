import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tds_project_mobile/api/api_login.dart';
import 'package:tds_project_mobile/models/user.dart';

import '../utils/dbHelper.dart';

class Api_User
{
  static final url = "";
  static DataBaseHelper _dbHelper = DataBaseHelper.instance;

  static postApiUser(user model) async
  {
    int i = 0;
    try
    {
      final response = await http.post(Uri.parse(url),
      body: jsonEncode({

      }),
        headers:
        {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer ${ApiLogin.token}"
        }
      ).then((http.Response response)
      {
        final statusCode = response.statusCode;
        if(statusCode <200 || statusCode > 400 || json == null)
        {
          throw Exception("Error mientras obtenia la data " + statusCode.toString());
        }

        print(response.body + " Respues del servidor");

        user obj = user.fromJson(jsonDecode(response.body));

        return i;

      });
    }
    catch(err)
    {
      print("Entro al catch del metodo post Api_User " + err.toString());
    }
  }

}