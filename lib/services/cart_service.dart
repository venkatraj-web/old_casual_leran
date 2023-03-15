
import 'package:casual/models/casual_job_list.dart';
import 'package:casual/repository/repository.dart';

class CartService{
  Repository? _repository;

  CartService(){
    _repository = Repository();
  }

  addToCart(CasualJobList jobDetail) async{
    List<Map> items = await _repository!.getLocalByCondition('job','jobId',jobDetail.id);
    print(items);
    if(items.length > 0){
      print(items.first['jobQuantity']);
      jobDetail.quantity = items.first['jobQuantity'] + 1;
      print(jobDetail.quantity);
      return await _repository!.updateLocal('job', 'jobId', jobDetail.toMap());
    }

    jobDetail.quantity = 1;
    var result = await _repository!.saveLocal('job', jobDetail.toMap());
    print(result);
    return result;
  }

  getCartItems() async {
    return await _repository!.getAllLocal('job');
  }
  

}