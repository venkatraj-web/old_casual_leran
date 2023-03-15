import 'package:casual/models/city.dart';
import 'package:casual/screens/job_list_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HomeCity extends StatefulWidget {
  // String cityName;
  List<City> cityData;
  // or use
  // final City cityData;
  // HomeCity({required this.cityName});
  HomeCity({required this.cityData});

  @override
  State<HomeCity> createState() => _HomeCityState();
}

class _HomeCityState extends State<HomeCity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.0,
      width: 140.0,
      child: InkWell(
        onTap: (){
          print(widget.cityData[0].name.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => JobListScreen(city: this.widget.cityData,)));
        },
        child: Card(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20.0),
              child: Text(widget.cityData[0].name.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
