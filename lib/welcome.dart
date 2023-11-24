import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Future<String> _guess() async => Platform.I.operatingSystem.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: _guess(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("WELCOME USER", style: TextStyle(fontSize: 16.sp)),
                  const SizedBox(height: 10),
                  Text("ON ${snapshot.data!.toUpperCase()}", style: TextStyle(fontSize: 16.sp)),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }
}
