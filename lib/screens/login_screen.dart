import 'dart:async';
import 'dart:convert';

import 'package:casual/models/casual.dart';
import 'package:casual/screens/home_screen.dart';
import 'package:casual/screens/register_screen.dart';
import 'package:casual/services/authentication/login_service.dart';
import 'package:casual/widgets/CustomSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginForm = GlobalKey<FormState>();
  LoginService _loginService = LoginService();
  String? _success = "";

  Map<String, dynamic> _errors = Map<String, dynamic>();

  Casual _casual = Casual();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _obscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _errors = _casual.getFieldNameWithNull();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Casual Login", textAlign: TextAlign.center)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Form(
            key: _loginForm,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    // style: TextStyle(color: Colors.white),
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: "example@gmail.com",
                      // hintStyle: TextStyle(color: Colors.lightGreenAccent),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'please enter email address!!';
                      }
                      if (_errors['email'] != null) {
                        return _errors['email'];
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    // style: TextStyle(color: Colors.white),
                    controller: _password,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      // labelStyle: TextStyle(
                      //   color: Colors.white,
                      // ),
                      suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "please enter password!!";
                      }
                      if (_errors['password'] != null) {
                        return _errors['password'];
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // print("email : ${_email.text}");
                        // print("password : ${_password.text}");
                        var model = Casual();
                        model.email = _email.text;
                        model.password = _password.text;
                        _login(context, model);
                        // if(_success != null){
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomSnackbar(message: _success.toString()),
                        //     behavior: SnackBarBehavior.floating,
                        //     backgroundColor: Colors.transparent,elevation: 0,));
                        // }

                      },
                      child: Text("Login")),
                  TextButton(
                      onPressed: () async {
                        // print(results['access_token']);
                        final _prefs = await SharedPreferences.getInstance();
                        print('Token : ${_prefs.getString('token')}');
                      },
                      child: Text('Get Token')),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: const Text("Register"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login(BuildContext context, Casual data) async {
    _loginForm.currentState!.validate();
    String? message = '';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _errors = _casual.getFieldNameWithNull();
    });
    try {
      var registeredUser = await _loginService.login(data);
      // var resultsData = await json.decode(registeredUser.body);
      var resultsData = await registeredUser;
      print('mass');
      print(registeredUser['status']);
      if (!registeredUser['status']) {
        resultsData['errors'].forEach((k, v) {
          // print("${k} : ${v} ");
          _errors.forEach((key, value) {
            if (k == key) {
              _errors[k] = v[0];
            }
          });
        });
        print(_errors);

        _loginForm.currentState!.validate();
      } else {
        _prefs.setString('token', resultsData['access_token']);
        setState(() {
          _success = resultsData['message'];
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomSnackbar(message: _success.toString()),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,elevation: 0,));
        Timer(Duration(seconds: 1), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }



      // if(resultsData['status'] == true){
      //   print(resultsData['access_token']);
      //   _prefs.setString('token', resultsData['access_token']);
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // }else if(registeredUser.statusCode == 400){
      //   print(registeredUser.statusCode);
      //   print(resultsData);
      //   // resultsData.forEach((k,v) => print('${k}: ${v}'));
      //   resultsData.forEach((k,v){
      //     // print(k);
      //     message = message! + v.toString();
      //   });
      //   message = resultsData['password'].toString();
      //   print(message);
      //
      // }else {
      //   print(resultsData);
      //   print(registeredUser.statusCode);
      //   message = resultsData['message'];
      //   print(message);
      // }
    } catch (e) {
      print("2nd catch");
      print(e);
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("An Error Occurred!"),
                content: Text(e.toString()),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Okay!")),
                ],
              ));
    }

    // final snackBar = SnackBar(
    //   // content: Text(resultsData['message'], textAlign: TextAlign.center),
    //   content: Text(await message, textAlign: TextAlign.center),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

     finally {
      setState(() {
        // results = resultsData;
      });
    }
  }
}
