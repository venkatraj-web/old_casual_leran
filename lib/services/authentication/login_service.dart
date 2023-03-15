import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:casual/models/casual.dart';
import 'package:casual/repository/repository.dart';

import '../../Exceptions/exception_handlers.dart';

class LoginService {
  Repository? _repository;

  LoginService(){
    _repository = Repository();
  }

  Future<dynamic> login(Casual data) async{
    var responseJson;
   try {
    final response = await _repository!.httpPost('casual/login', json.encode(data.toJson()));
    print(response.statusCode);
     responseJson = _returnResponse(response);
   } on SocketException {
     throw FetchDataException('No Internet connection');
   } catch (e) {
     print("dai");
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

// _response(response) async{
//     print(response.request?.url);
//     switch(response.statusCode){
//       case 200:
//         var responseJson = json.decode(response.body.toString());
//         return responseJson;
//       case 400:
//       case 401:
//       case 403:
//       case 500:
//       default:
//         throw FetchDataException();
//     }
//   }