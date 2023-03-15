import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetService{

  StreamSubscription? subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() async {
    print("getConnectivity-1");

    subscription = await Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      print("getConnectivity-2");
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        // setState(() {
        isAlertSet = true;
        // });
        print("getConnectivity");
      }
    });
    print(subscription.toString());
  }

  showDialogBox(){
    print("internet");
  //   return showCupertinoDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text("No Connection"),
  //     content: Text("Please Check Your Internet Connectivity!"),
  //     actions: [
  //       TextButton(
  //         onPressed: () async {
  //           Navigator.of(context).pop('Cancel');
  //           // setState(() {
  //             isAlertSet = false;
  //           // });
  //           isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //           if(!isDeviceConnected){
  //             showDialogBox(context);
  //             // setState(() {
  //               isAlertSet = true;
  //             // });
  //           }
  //         },
  //         child: Text("Ok"),
  //       ),
  //     ],
  //   ),
  // );

  }
}