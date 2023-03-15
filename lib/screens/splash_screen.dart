import 'dart:async';

import 'package:casual/screens/login_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  // @override
  // void initState() {
  //   // getConnectivity();
  //   subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     // Got a new connectivity status!
  //     print(result);
  //   });
  //
  //   // TODO: implement initState
  //   super.initState();
  // }

  // getConnectivity() async{
  //   subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     // Got a new connectivity status!
  //     if (result == ConnectivityResult.mobile) {
  //       print("I am connected to a mobile network.");
  //     } else if (result == ConnectivityResult.wifi) {
  //       print("I am connected to a wifi network.");
  //     }else{
  //       showDialogBox();
  //       print("Not Connected");
  //     }
  //   });
  //
  //   // var connectivityResult = await (Connectivity().checkConnectivity());
  //   // if (connectivityResult == ConnectivityResult.mobile) {
  //   //   print("I am connected to a mobile network.");
  //   // } else if (connectivityResult == ConnectivityResult.wifi) {
  //   //   print("I am connected to a wifi network.");
  //   // }else{
  //   //   showDialogBox();
  //   //   print("Not Connecteded");
  //   // }
  // }

  // getConnectivity() => subscription = Connectivity()
  //         .onConnectivityChanged
  //         .listen((ConnectivityResult result) async {
  //           print("object");
  //       isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //       print(result);
  //       if (!isDeviceConnected && isAlertSet == false) {
  //         showDialogBox();
  //         print(result);
  //         setState(() {
  //           isAlertSet = true;
  //         });
  //       }
  //     });

  // @override
  // void dispose() {
  //   subscription.cancel();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  void initState() {
    _checkAuth().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>
            (token != null)
                ? HomeScreen()
                : LoginScreen()));
      });
    });

    super.initState();
  }

  Future _checkAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('token');
    });
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Splash Screen")),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginScreen()),
      //     ),
      //     child: const Text('Next Page'),
      //   ),
      // ),
    );
  }

  showDialogBox() {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your Connectivity"),
        actions: [
          TextButton(onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() {
              isAlertSet = false;
            });
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected){
              showDialogBox();
              setState(() {
                isAlertSet = true;
              });
            }
          }, child: Text("OK")),
        ],
      ),
    );
  }
}
