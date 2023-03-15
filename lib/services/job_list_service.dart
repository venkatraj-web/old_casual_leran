import 'package:casual/repository/repository.dart';

class JobListService{
  Repository? _repository;
  JobListService(){
    _repository = Repository();
  }

  getJobLists() async {
    return await _repository!.httpGet("job-list");
    // return await _repository!.httpGet("photos");
  }

  getJobListsByCityId(int? CityId) async{
    return await _repository!.httpGetById("job-list-by-city", CityId);
  }
}