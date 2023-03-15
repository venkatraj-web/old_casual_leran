import 'package:flutter/material.dart';

class ListTileDesign extends StatefulWidget {

  String fieldName;
  String fieldData;
  ListTileDesign({required this.fieldName,required this.fieldData});

  @override
  State<ListTileDesign> createState() => _ListTileDesignState();
}

class _ListTileDesignState extends State<ListTileDesign> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.widget.fieldName + ' : ' + this.widget.fieldData),
    );
  }
}
