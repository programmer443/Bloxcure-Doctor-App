// ignore_for_file: file_names

import 'package:doctorbloxcure/module/ProfileData.dart';
import 'package:flutter/material.dart';

import 'SideBar.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      drawer: SideBar(profile: profile),
      appBar: AppBar(
        title:  const Center(
          child:
           Text('Doctor Profile')
        ),
        backgroundColor: const Color.fromARGB(255, 17, 103, 103),
      ),
        body: Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
             Container(
                height: 200.0,
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
                                        'assets/images/pic.png'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        ),
                                  ),
                                ],
                              ),
                            ],
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
                                  'Patient ID',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      ),
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
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: profile.doctorID,
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    enabled: false,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0),
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
                                      color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Last Name',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      ),
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
                            children:  <Widget>[
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: profile.firstName,
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    enabled: false,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: profile.lastName,
                                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                  enabled: false,
                                ),
                              ),
                            ],
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
                                  'CNIC',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Speciality',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                      ),
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
                            children:  <Widget>[
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: profile.CNIC),
                                    enabled: false,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      hintText: profile.speciality),
                                  enabled: false,
                                ),
                              ),
                            ],
                          )),
                          
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                             Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                 Text(
                                    'Mobile',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                             Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      hintText: profile.phoneNumber),
                                  enabled: false,
                                ),
                              ),
                            ],
                          )),
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
}
