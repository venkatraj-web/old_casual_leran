import 'package:casual/models/casual_job_list.dart';
import 'package:casual/services/cart_service.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget {
   // CasualJobList? jobDetail;
  CasualJobList jobDetail;
   JobDetailsScreen({required this.jobDetail});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCarts();
  }

  CartService _cartService = CartService();
  late List<CasualJobList> _cartItem;
  _getCarts() async{
    _cartItem = <CasualJobList>[];
    var cartItems = await _cartService.getCartItems();
    // print(cartItems);
    cartItems.forEach((data){
      var model = CasualJobList();
      model.id = data['jobId'];
      model.job_title = data['jobName'];
      model.amount = data['jobAmount'];
      model.quantity = data['jobQuantity'];
      setState(() {
        _cartItem.add(model);
      });
    });
  }

  _addToCart(BuildContext context, CasualJobList jobDetail) async{
    var result = await _cartService.addToCart(jobDetail);
    if(result > 0){
      print("Yes");
    }else{
      print("no");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(this.widget.jobDetail.reporting_person.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.jobDetail.job_title.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 30,
              height: 150,
              child: Stack(
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: (){},
                      icon: Icon(Icons.shopping_cart)
                  ),
                  Positioned(
                      child: Stack(
                        children: [
                          Icon(Icons.brightness_1, size: 25, color: Colors.black,),
                          Positioned(
                              top: 4.0,
                              right: 8.0,
                              child: Center(child: Text(_cartItem.length.toString()))
                          )
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Job Id  : ${widget.jobDetail.id}'),
          ),
          ListTile(
            title: Text('Job Title : ${widget.jobDetail.job_title}'),
          ),
          ListTile(
            title: Text('Job Amount : ${widget.jobDetail.amount}'),
          ),
          ListTile(
            title: Text('Job Description : ${widget.jobDetail.job_description.toString()}'),
          ),
          ListTile(
            title: Text('Reporting Person : ${widget.jobDetail.reporting_person}'),
          ),
          ListTile(
            title: Text('Things to Brings : ${widget.jobDetail.things_to_bring}'),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 2.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: (){
              _addToCart(context, widget.jobDetail);
              
              // final snackBar = SnackBar(
              //   content: Text('You Applied this Job'),
              //   action: SnackBarAction(
              //     label: 'Applied',
              //     onPressed: (){
              //       // Some code to undo the change.
              //     },
              //   ),
              // );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, child: Text("Apply")
          )
        ],
      ),
    );
  }
}
