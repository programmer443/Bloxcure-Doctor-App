// ignore_for_file: file_names, avoid_print

import 'package:doctorbloxcure/module/ProfileData.dart';
import 'package:doctorbloxcure/pages/PatientList.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Profile.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 103, 103),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/dprofile.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 255, 242), fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  profile.phoneNumber,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 150, 255, 2), fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            profile: profile,
                          )))
            },
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism),
            title: const Text('Treatment'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientList(
                            profile: profile,
                          )))
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()))
            },
          ),
        ],
      ),
    );
  }
}
