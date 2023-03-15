import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:casual/models/casual.dart';
import 'package:casual/screens/login_screen.dart';
import 'package:casual/services/authentication/register_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterService _registerService = new RegisterService();

  final _registerForm = GlobalKey<FormState>();
  Map<String, dynamic> _errors = Map<String, dynamic>();
  Map<String, dynamic> _errors2 = Map<String, dynamic>();

  TextEditingController casual_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password_confirmation = TextEditingController();
  TextEditingController casual_phone_no = TextEditingController();
  TextEditingController city_id = TextEditingController();
  TextEditingController gender = TextEditingController();

  Casual? _casualData = Casual();
  List<Casual> _casual = [];
  String? _gender, _idProof;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _errors = _casualData?.getFieldNameWithNull();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    casual_name.dispose();
    email.dispose();
    password.dispose();
    password_confirmation.dispose();
    city_id.dispose();
    gender.dispose();
    casual_phone_no.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Casual Register")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _registerForm,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: casual_name,
                  decoration: const InputDecoration(
                    labelText: "Casual Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Provide a name!';
                    }
                    if (_errors['casual_name'] != null) {
                      return _errors['casual_name'];
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email-id!";
                    }
                    if (_errors['email'] != null) {
                      return _errors['email'];
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: casual_phone_no,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Casual Phone No",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Mobile No!";
                    }
                    if (_errors['casual_phone_no'] != null) {
                      return _errors['casual_phone_no'];
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    print(_errors);
                    print(_errors.containsKey('password'));
                    // if(value!.isNotEmpty){
                    //   print(_errors);
                    //   print(_errors['password'].isEmpty);
                    //   return "suma :  ${_errors['password'][0]}";
                    // }
                    if (_errors['password'] != null) {
                      print('password Error1 : ${_errors['password']}');
                      return _errors['password'];
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password_confirmation,
                  decoration: InputDecoration(
                    labelText: "Password Confirmation",
                    prefixIcon: Icon(Icons.password_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: city_id,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "City Id",
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter City-id!";
                    }
                    if (_errors['city_id'] != null) {
                      return _errors['city_id'];
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: new Text("Gender :"),
                ),
                Column(
                  children: [
                    RadioListTile(
                      title: Text("Male"),
                      value: "male",
                      groupValue: _gender,
                      onChanged: ((value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    RadioListTile(
                      title: Text("Female"),
                      value: "female",
                      groupValue: _gender,
                      onChanged: ((value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    RadioListTile(
                      title: Text("Other"),
                      value: "other",
                      groupValue: _gender,
                      onChanged: ((value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    _errors['gender'] != null
                        ? Text(
                            _errors['gender'],
                            style: TextStyle(color: Colors.red),
                          )
                        : Text(""),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: new Text("Id Proof :"),
                ),
                Column(
                  children: [
                    RadioListTile(
                      title: Text("National Id Card"),
                      value: "national_id_card",
                      groupValue: _idProof,
                      onChanged: ((value) {
                        setState(() {
                          _idProof = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    RadioListTile(
                      title: Text("Driving License"),
                      value: "driving_license",
                      groupValue: _idProof,
                      onChanged: ((value) {
                        setState(() {
                          _idProof = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    RadioListTile(
                      title: Text("Pancard"),
                      value: "pancard",
                      groupValue: _idProof,
                      onChanged: ((value) {
                        setState(() {
                          _idProof = value.toString();
                        });
                      }),
                      dense: true,
                    ),
                    _errors['id_proof'] != null
                        ? Text(
                      _errors['id_proof'],
                      style: TextStyle(color: Colors.red),
                    )
                        : Text(""),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          var model = Casual();
                          model.casual_name = casual_name.text;
                          model.email = email.text;
                          model.password = password.text;
                          model.password_confirmation =
                              password_confirmation.text;
                          model.casual_phone_no =
                              int.tryParse(casual_phone_no.text);
                          model.city_id = int.tryParse(city_id.text);
                          // model.gender = gender.text;
                          model.gender = _gender;
                          model.id_proof = _idProof;

                          print(password.text);

                          _register(context, model);
                          // setState(() {
                          //   _casual.add(model);
                          // });
                        },
                        child: Text("Register Now!")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Login !!")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _register(BuildContext context, Casual data) async {
    var isValid = _registerForm.currentState!.validate();
    // if(!isValid){
    //   return;
    // }
    setState(() {
      _errors = _casualData?.getFieldNameWithNull();
    });
    print('data : ${data.city_id}');
    http.Response response = await _registerService.createCasual(data);
    var resultData = await json.decode(response.body);
    print(resultData);
    print(response.statusCode);
    if (response.statusCode == 422) {
      // print("mass");
      // print('dataCasual : ${_casualData?.getFieldNameWithNull()['casual_name']}');

      // print("Before : ${_errors}");
      resultData.forEach((k, v) {
        print("${k} : ${v}");
        _errors.forEach((key, value) {
          if (k == key) {
            setState(() {
              _errors[k] = v[0];
            });
            print("======");
            print(_errors[key]);
          }
        });
      });
      // print("After : ${_errors}");

      print('password Error : ${_errors['password']}');

      setState(() {
        // _errors = _errors;
        _registerForm.currentState!.validate();
      });

      // setState(() {
      //   _errors = resultData;
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(resultData['message']),
      ));
    }
  }
}
