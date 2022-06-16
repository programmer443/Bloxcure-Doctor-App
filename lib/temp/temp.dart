import 'package:doctorbloxcure/module/constant.dart';
import 'package:doctorbloxcure/pages/LoginOptions.dart';
import 'package:flutter/material.dart';

var ip;

class Temp extends StatelessWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _ipController = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _ipController,
            decoration: const InputDecoration(hintText: "Enter IP"),
          ),
          ElevatedButton(
              onPressed: () {
                ip = 'http://${_ipController.text}:3000';
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginOptions(),
                  ));
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
