import 'package:casual/widgets/home_city.dart';
import 'package:flutter/material.dart';

import '../models/city.dart';

class CityWidget extends StatefulWidget {
  final List<City> cityList;
  CityWidget({required this.cityList});

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  // List<City> _city = <City>[];

  @override
  Widget build(BuildContext context) {
    // print(this.widget.cityList[1].name);
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.cityList.length,
        itemBuilder: (context, index){
          // print(this.widget.cityList[index]);
          List<City> _city = <City>[];
          var model = new City();
          model.name = widget.cityList[index].name;
          model.id = widget.cityList[index].id;
          _city.add(model);

          // return Text(this.widget.cityList[index].name);
          // return HomeCity(cityName: this.widget.cityList[index].name.toString());
          return HomeCity(cityData: _city,);
        }
      ),
    );
  }
}
