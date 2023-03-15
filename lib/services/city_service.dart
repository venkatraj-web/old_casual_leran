import 'dart:convert';
import 'dart:io';

import 'package:casual/repository/repository.dart';

import '../Exceptions/exception_handlers.dart';
import 'package:http/http.dart' as http;

class CityService {
  Repository? _repository;

  CityService() {
    _repository = Repository();
  }

  getCities() async {
    var responseJson;
    // return await _repository!.httpGet("city");
    try {
      http.Response response = await _repository!.httpGet("city");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("get City");
      print(e);
      throw e;
    }
    return responseJson;
  }

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      print(json.decode(response.body)['message']);
      // throw UnAuthorizedException(response.body.toString());
      throw UnAuthorizedException(json.decode(response.body)['message']);
    case 422:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response
              .statusCode}');
  }
}
}