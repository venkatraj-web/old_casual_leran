import 'dart:convert';

import 'package:casual/models/casual.dart';
import 'package:casual/screens/login_screen.dart';
import 'package:casual/services/profile_service.dart';
import 'package:casual/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  Casual casual;
  ProfileScreen({required this.casual});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // ProfileService _profileService = ProfileService();
  // List<Casual> _casual = <Casual>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getProfile();
  }

  // _getProfile() async{
  //   var profileData = await _profileService.getProfile();
  //   var result = json.decode(profileData.body);
  //   print(result);
  //   var data = result['user'];
  //   print(data);
  //   var model = Casual();
  //   model.id = data['id'];
  //   model.casual_name = data['casual_name'];
  //   model.email = data['email'];
  //   model.id_proof = data['id_proof'];
  //   setState(() {
  //     _casual.add(model);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
        ElevatedButton(onPressed: () async{
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          _prefs.remove('token');
          print('Logout ' + _prefs.getString('token').toString());
          
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new LoginScreen()));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => new LoginScreen()), (route) => false);
        }, child: Text('Logout')),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ListTileDesign(fieldName: 'ID', fieldData: widget.casual.id.toString(),),
            ListTileDesign(fieldName: 'Casual ID', fieldData: widget.casual.casual_id.toString(),),
            ListTileDesign(fieldName: 'Name', fieldData: widget.casual.casual_name.toString(),),
            ListTileDesign(fieldName: 'Email', fieldData: widget.casual.email.toString(),),
            ListTileDesign(fieldName: 'Id Proof', fieldData: widget.casual.id_proof.toString(),),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
