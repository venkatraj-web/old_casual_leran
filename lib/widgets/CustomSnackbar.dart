import 'package:flutter/material.dart';

class CustomSnackbar extends StatefulWidget {
  String? message;
  CustomSnackbar({required this.message});

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 30,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: [
          Text(this.widget.message.toString()),

        ],
      ),
    );
  }
}
