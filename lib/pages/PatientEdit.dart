// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctorbloxcure/module/ProfileData.dart';
import 'package:doctorbloxcure/module/constant.dart';
import 'package:doctorbloxcure/temp/temp.dart';
import 'package:doctorbloxcure/module/patientData.dart';
import 'package:doctorbloxcure/pages/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class PatientEdit extends StatefulWidget {
  final PatientData patient;
  final ProfileData profile;
  const PatientEdit({Key? key, required this.patient, required this.profile})
      : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<PatientEdit> {
  // final String ip = Constants['ip'];
  final storage = new FlutterSecureStorage();
  var _treatmentController = TextEditingController(),
      _followController = TextEditingController(),
      _diagnoController = TextEditingController(),
      _allergiesController = TextEditingController(),
      _symptomsController = TextEditingController();
  Dio dio = Dio();
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  Future<void> _submit() async {
    String url = "$ip/doctor/update-patient";
    String? value = await storage.read(key: "token");
    var editData = {
      "patientID": widget.patient.patientID,
      "allergies": _allergiesController.text.isEmpty
          ? widget.patient.allergies
          : _allergiesController.text,
      "symptoms": _symptomsController.text.isEmpty
          ? widget.patient.symptoms
          : _symptomsController.text,
      "diagnosis": _diagnoController.text.isEmpty
          ? widget.patient.diagnosis
          : _diagnoController.text,
      "treatment": _treatmentController.text.isEmpty
          ? widget.patient.treatment
          : _treatmentController.text,
      "followUp": _followController.text.isEmpty
          ? widget.patient.followUp
          : _followController.text,
    };
    // print('Sent Response: $editData and $value');
    try {
      var response = await dio.post(
        url,
        data: editData,
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      // print('Rec Response: $response');
    } on DioError catch (_) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error', style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                content: const Text("Unable to update Patient Data."),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }
  }

  Future<void> _getHistory() async {
    Directory? downloadsDirectory;
    String url = "$ip/doctor/query-patient-history";
    String? value = await storage.read(key: "token");
    try {
      var response = await dio.post(
        url,
        data: {"patientID": widget.patient.patientID},
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      print('Rec Response: $response');
      downloadsDirectory = await getExternalStorageDirectory();
            String newPath = "";
            List<String> paths = downloadsDirectory!.path.split("/");
            for (int x = 1; x < paths.length; x++) {
              String folder = paths[x];
              if (folder != "Android") {
                newPath += "/$folder";
              } else {
                break;
              }
            }

            newPath = "$newPath/Download/bloxcure/History";
            downloadsDirectory = Directory(newPath);
            File saveFile =
                File("${downloadsDirectory.path}/${widget.patient.patientID}History.txt");
            await downloadsDirectory.create(recursive: true);
            saveFile.writeAsString('$response');
      if (response.statusCode == 201) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    'Success',
                    style:
                        TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  content: const Text("File Downloaded Successfully."),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    } on DioError catch (_) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error', style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                content: const Text("Downloading Failed."),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(profile: widget.profile),
        appBar: AppBar(
          title: const Center(child: Text('Edit Patient')),
          backgroundColor: const Color.fromARGB(255, 17, 103, 103),
          actions: [
            IconButton(
                onPressed: () => _getHistory(),
                icon: const Icon(Icons.download))
          ],
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/patient.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                "PID",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: widget.patient.patientID),
                                  enabled: false,
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'First Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Last Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: widget.patient.firstName),
                                        enabled: false,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: widget.patient.lastName),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: widget.patient.birthDate),
                                enabled: false,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Blood Group',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Treatment',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: widget.patient.blood),
                                        enabled: false,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: TextField(
                                      controller: _treatmentController,
                                      decoration: InputDecoration(
                                          hintText: widget.patient.treatment),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                'Allergies',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: TextField(
                                controller: _allergiesController,
                                decoration: InputDecoration(
                                    hintText: widget.patient.allergies),
                                enabled: !_status,
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                'Symptoms',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: TextField(
                                controller: _symptomsController,
                                decoration: InputDecoration(
                                    hintText: widget.patient.symptoms),
                                enabled: !_status,
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                'Diagnosis',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: TextField(
                                controller: _diagnoController,
                                decoration: InputDecoration(
                                    hintText: widget.patient.diagnosis),
                                enabled: !_status,
                              )),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                'Follow Up',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: TextField(
                                controller: _followController,
                                decoration: InputDecoration(
                                    hintText: widget.patient.followUp),
                                enabled: !_status,
                              )),
                          !_status ? _getActionButtons() : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    _submit();
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Text("Save"),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Text("Cancel"),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
