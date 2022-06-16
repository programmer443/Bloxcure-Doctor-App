// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:doctorbloxcure/module/constant.dart';
import 'package:doctorbloxcure/module/patientData.dart';
import 'package:doctorbloxcure/module/ProfileData.dart';
import 'package:doctorbloxcure/pages/PatientEdit.dart';
import 'package:flutter/material.dart';
import 'package:doctorbloxcure/temp/temp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'SideBar.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final storage = const FlutterSecureStorage();
  // final String ip = Constants.ip;
  late Response response;
  bool isLoading = false;
  Dio dio = Dio();
  var responseBody;

  Future<void> permissionedPatients() async {
    setState(() {
      isLoading = true;
    });
    String url = "$ip/doctor/patients-access-acquired";
    try {
      String? value = await storage.read(key: "token");
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      // print('RECV Response: $response');
      responseBody = response.data;
      setState(() {
        isLoading = false;
      });
    } on DioError catch (_) {
      // print('Error Response: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> editPatient(id) async {
    setState(() {
      isLoading = true;
    });
    String url = "$ip/doctor/query-patient";
    try {
      String? value = await storage.read(key: "token");
      var response = await dio.post(
        url,
        data: {"patientID": id},
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      var responseData = response.data;
      // print('RECV Response: $responseData');
      final patient = PatientData(
        patientID: '${responseData['patientID']}',
        firstName: '${responseData['firstName']}',
        lastName: '${responseData['lastName']}',
        birthDate: '${responseData['birthDate']}',
        gender: '${responseData['gender']}',
        blood: '${responseData['blood']}',
        allergies: '${responseData['allergies']}',
        symptoms: '${responseData['symptoms']}',
        diagnosis: '${responseData['diagnosis']}',
        treatment: '${responseData['treatment']}',
        followUp: '${responseData['followUp']}',
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => PatientEdit(
                    patient: patient,
                    profile: widget.profile,
                  )),
          (route) => false);

      setState(() {
        isLoading = false;
      });
    } on DioError catch (_) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  initState() {
    permissionedPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(profile: widget.profile),
      appBar: AppBar(
        title: const Center(child: Text('Patient List')),
        backgroundColor: const Color.fromARGB(255, 17, 103, 103),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  responseBody.isEmpty
                      ? const Center(child: Text("No Patient to show"))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: responseBody.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(
                                  responseBody[index]["doctorID"].toString()),
                              color: const Color.fromARGB(152, 38, 91, 81),
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          'assets/images/patient.png'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${responseBody[index]['firstName']} '
                                            ' ${responseBody[index]['lastName']}',
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            responseBody[index]['patientID'],
                                            style: const TextStyle(
                                                color: Colors.amberAccent),
                                          ),
                                          Text(
                                            responseBody[index]['gender'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Text(
                                            responseBody[index]["phoneNumber"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      trailing: ElevatedButton(
                                          onPressed: () => editPatient(
                                              responseBody[index]['patientID']),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          child: const Text("View")),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
