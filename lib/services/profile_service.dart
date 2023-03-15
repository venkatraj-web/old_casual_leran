import 'package:casual/repository/repository.dart';

class ProfileService{
  Repository? _repository;
  
  ProfileService(){
    _repository = Repository();
  }
  
  getProfile() async{
    return await _repository!.httpTokenGet('casual/profile');
  }
  
}