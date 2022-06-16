// ignore: unused_import
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctorbloxcure/module/constant.dart';
import 'package:doctorbloxcure/temp/temp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/module/ProfileData.dart';
import 'Enroll.dart';
import 'Profile.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = new FlutterSecureStorage();
  Dio dio = Dio();
  PlatformFile? _platformFile;
  var isLoading = false;
  String res = '';

  // ignore: non_constant_identifier_names
  SelectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _platformFile = result.files.first;
      final file = File('${_platformFile?.path}');
      var contents = await file.readAsString();
      setState(() {
        res = contents;
      });
    }
  }

   Future<void> updateCookie(var response) async {
    var cookie;
    var rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookie =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
        await storage.write(key: "token", value: cookie[0]);
        String? value = await storage.read(key: "token");
        print("Token $value");
  }


  Future<void> _submit() async {
    // final String ip = Constants.ip;
    String url = "$ip/doctor/login";
    setState(() {
      isLoading = true;
    });
    print('Sent Response: $res');
    try {
      var response = await dio.post(url, data: res);
      updateCookie(response);
    var responseBody = response.data;
    // print('Rec Response: $responseBody');
    final profile = ProfileData(
      doctorID: '${responseBody['doctorID']}',
      firstName: '${responseBody['firstName']}',
      lastName: '${responseBody['lastName']}',
      CNIC: '${responseBody['CNIC']}',
      gender: '${responseBody['gender']}',
      phoneNumber: '${responseBody['phoneNumber']}',
      speciality: '${responseBody['speciality']}',
      mspID: '${responseBody['mspID']}',
      );
      setState(() {
        isLoading = false;
      });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Profile(profile: profile)),
        (route) => false);
    }  on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error', style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                content: const Text("Unable to login. Please try again."),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(17, 18, 41, 255),
      body: SingleChildScrollView(
        child: Form(
          child: Column(children: <Widget>[
            Image.asset(
              'assets/images/bloxcure.png',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(84, 0, 0, 0),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        'Doctor Login',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: (() => SelectFile()),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      minimumSize: const Size.fromHeight(30),
                      primary: const Color.fromARGB(0, 2, 2, 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.grey),
                      )),
                  child: const Text(
                    'Upload Wallet',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 68, 252, 255),
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: (() => {_submit()}),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          minimumSize: const Size.fromHeight(30),
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55),
              child: ElevatedButton(
                  onPressed: (() => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Enroll(),
                          ),
                        )
                      }),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      minimumSize: const Size.fromHeight(30),
                      primary: const Color.fromARGB(184, 193, 230, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 18, 117, 163)),
                      )),
                  child: const Text(
                    'ENROLL NOW',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
        ),
      ),
    ));
  }
}
