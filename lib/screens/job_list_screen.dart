import 'dart:convert';

import 'package:casual/models/casual_job_list.dart';
import 'package:casual/models/city.dart';
import 'package:casual/screens/job_details_screen.dart';
import 'package:casual/services/job_list_service.dart';
import 'package:flutter/material.dart';

class JobListScreen extends StatefulWidget {
  // final String cityName;
   List<City> city;
  // const JobListScreen({super.key, required this.cityName});
   JobListScreen({required this.city});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  JobListService _jobListService = JobListService();

  List<CasualJobList> _casualJobList = <CasualJobList>[];
  
  @override
  void initState() {
    super.initState();
    _getJobLists();
  }
  
  _getJobLists() async {
    // print(this.widget.city[0].id.runtimeType);
    var jobs = await _jobListService.getJobListsByCityId(this.widget.city[0].id);
    var results = json.decode(jobs.body);
    print(results['job-list']);
    results['job-list'].forEach((data){
      var model = CasualJobList();
      // print(data['things_to_bring']);
      // print(json.decode(data['things_to_bring']));
      // print(json.encode(data['things_to_bring']));
      model.id = data['id'];
      model.casual_job_id = data['casual_job_id'];
      model.job_title = data['job_title'];
      model.amount = data['amount'];
      model.outlet_name = data['outlet_name'];
      model.reporting_person = data['reporting_person'];
      model.things_to_bring = json.decode(data['things_to_bring']);
      model.job_description = data['job_description'];
      model.casual_job_id = data['casual_job_id'];
      setState(() {
        _casualJobList.add(model);
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.city[0].name.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150,
              width: 30,
              child: Stack(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: (){

                    },
                    icon: Icon(Icons.shopping_cart)),
                  Positioned(child: Stack(
                    children: [
                      Icon(Icons.brightness_1,color: Colors.black,size: 25,),
                      Positioned(
                          top: 4.0,
                          right: 8.0,
                          child: Center(child: Text('0')))
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.lightGreenAccent,
        child: ListView.builder(
          itemCount: _casualJobList.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${index}) Job Name : ${_casualJobList[index].job_title}'),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsScreen(jobDetail: _casualJobList[index],)));
                }, child: Text("View"))
              ],
            );
          },),
      ),
    );
  }
}
