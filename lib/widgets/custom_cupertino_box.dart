import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CustomCupertinoBox {

  // CustomCupertinoBox(){
  //
  // }

  bool isDeviceConnected = false;
  bool isAlertSet = false;

  changeAlertSet(bool result){
    this.isAlertSet = result;
  }

CupertinoBox(BuildContext context){
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text("No Connection1"),
      content: Text("Please check your Connectivity"),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              // setState(() {
                this.isAlertSet = false;
              // });

              this.isDeviceConnected =
              await InternetConnectionChecker().hasConnection;
              if (!this.isDeviceConnected) {
                // showDialogBox();
                CupertinoBox(context);
                // setState(() {
                  this.isAlertSet = true;
                // });
              }
            },
            child: Text("OK")),
      ],
    ),
  );
}
}