import 'dart:async';
import 'dart:convert';

import 'package:casual/models/city.dart';
import 'package:casual/screens/login_screen.dart';
import 'package:casual/screens/profile_screen.dart';
import 'package:casual/services/city_service.dart';
import 'package:casual/services/job_list_service.dart';
import 'package:casual/widgets/carousel_slider.dart';
import 'package:casual/widgets/city.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/casual.dart';
import '../services/profile_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  JobListService _jobListService = JobListService();
  CityService _cityService = CityService();
  ProfileService _profileService = ProfileService();
  List<Casual> _casual = <Casual>[];

  List<City> _cityList = <City>[];

  var items = [
    NetworkImage(
        'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
    NetworkImage(
        'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
  ];

  // ===========Internet Checking================

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;



  @override
  void initState() {
    _checkConnectivityState();
    getConnectivity();
    // TODO: implement initState
    super.initState();
    // _getAllJobLists();
    Timer(
      Duration(seconds: 2),
      () {
        _getCities();
        _getProfile();
      },
    );
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        print("object");
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        print(result);
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          print(result);
          setState(() {
            isAlertSet = true;
          });
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network');
      showDialogBox();
      print(result);
    }

    setState(() {
      // _connectivityResult = result;
      isAlertSet = true;
    });
  }

  // ===========Internet Checking================

  _getAllJobLists() async {
    // print("venkatraj");
    var jobLists = await _jobListService.getJobLists();
    var result = json.decode(jobLists.body);
    // print(result['status']);
    result.forEach((data) {
      setState(() {
        items.add(NetworkImage(data['url']));
      });
    });
    // print(items);
  }

  _getCities() async {
    print("venkatraj");
    try {
      var cities = await _cityService.getCities();
      print(cities);
      // var result_city = json.decode(cities.body);
      var result_city = await cities;
      print(result_city);
      result_city['cities'].forEach((data) {
        var model = City();
        model.id = data['id'];
        model.name = data['city_name'];
        setState(() {
          _cityList.add(model);
        });
      });
    } on Exception catch (e) {
      print("City 2nd Catch");
      print('error : ' + e.toString());
      print(e);
      // showDialog(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //           title: const Text("An Error Occurred!"),
      //           content: Text(e.toString()),
      //           actions: [
      //             ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: const Text("Okay!")),
      //           ],
      //         ));

      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text("No Connection"),
          content: Text("Please check your Connectivity"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() {
                    isAlertSet = false;
                  });
                  isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() {
                      isAlertSet = true;
                    });
                  }
                },
                child: Text("OK")),
          ],
        ),
      );
    }
    // print(_cityList[1].name);
  }

  _getProfile() async {
    var profileData = await _profileService.getProfile();
    var result = json.decode(profileData.body);
    if (profileData.statusCode == 401) {
      print('profile : ${result}');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      var data = result['user'];
      print(data);
      var model = Casual();
      model.id = data['id'];
      model.casual_id = data['casual_id'];
      model.casual_name = data['casual_name'];
      model.email = data['email'];
      model.id_proof = data['id_proof'];
      setState(() {
        _casual.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
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
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart)),
                  Positioned(
                      child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 25,
                        color: Colors.black,
                      ),
                      Positioned(
                          top: 4.0, right: 8.0, child: Center(child: Text("0")))
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            carouselSlider(items),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("City"),
            ),
            CityWidget(
              cityList: _cityList,
            ),
            Divider(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                casual: _casual[0],
                              )));
                  print('Clicked');
                },
                child: Text("Profile")),
          ],
        ),
      ),
    );
  }

  showDialogBox() {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your Connectivity"),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: Text("OK")),
        ],
      ),
    );
  }
}
