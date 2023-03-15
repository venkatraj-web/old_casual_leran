import 'dart:convert';

import 'package:casual/repository/db_connection.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Exceptions/exception_handlers.dart';

class Repository{

  String _baseUrl = "http://192.168.1.3:8000/api";
  // String _baseUrl = "https://jsonplaceholder.typicode.com";
  // String _baseUrl = "http://192.168.1.3:8000/api/casual";
  // String _baseUrl = "http://192.168.1.5:8000/api";
  DatabaseConnection? _connection;
  Repository(){
  _connection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await _connection?.initDatabase();
    return _database;
  }

  httpGet(String api) async{
   return await http.get(Uri.parse(_baseUrl + "/" + api));
  }

  httpGetById(String api, cityId) async{
    return await http.get(Uri.parse(_baseUrl + "/" + api + "/" + cityId.toString()));
  }

  saveLocal(table, data) async{
    var conn = await database;
    // print(conn);
    return await conn?.insert(table,data);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn!.rawQuery('SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }

  updateLocal(table, columnName, data) async{
    var conn = await database;
    return await conn!.update(table, data, where: '$columnName=?', whereArgs: [data['jobId']]);
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn!.query(table);
  }
  
  // Token Authentication

  // Map<String, String> header = new Map();
  // header["content-type"] =  "application/x-www-form-urlencoded";
  // header["token"] =  "token from device";
  // SharedPreferences _prefs = await SharedPreferences.getInstance();
  // var token = _prefs.getString('token');
  // print(token.runtimeType);

  _getheaders() async{
    // var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2Nhc3VhbC9sb2dpbiIsImlhdCI6MTY3MTE3ODQ5NSwiZXhwIjoxNjcxMTgyMDk1LCJuYmYiOjE2NzExNzg0OTUsImp0aSI6ImVOeVZvbjJjYTdCckNkRWsiLCJzdWIiOiIyIiwicHJ2IjoiNTRkNTJlMjIwMDU1NTBiYWRjZmY3NGM2YzBlYzZiYTk0ZmRiMTMzZSJ9.yoj4bzgrCKX6pjSCB98-oUUHfOVqarRqBkUOPp4Jqk4";
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    // print(token.runtimeType);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept" : "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token"
    };
    return headers;
  }

  httpTokenGet(String api) async{
    // print('token $token');
    print('url '+ _baseUrl);
    return await http.get(Uri.parse(_baseUrl + '/' + api),headers: await _getheaders());
  }

  httpPost(String api, data) async{
    print(data);
    return await http.post(Uri.parse(_baseUrl + '/' + api), body: data, headers: await _getheaders());
  }

  }