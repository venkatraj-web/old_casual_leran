import 'dart:convert';

import 'package:casual/models/casual.dart';
import 'package:casual/repository/repository.dart';

class RegisterService{
  Repository? _repository;

  RegisterService(){
    _repository = Repository();
  }

  createCasual(Casual data) async{
    return await _repository!.httpPost('casual/register', json.encode(data.toJson()));
  }
}