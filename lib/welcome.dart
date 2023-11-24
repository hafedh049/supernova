import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Future<List<String>> _guess() async {
    final Platform platform = Platform.I;
    return <String>[
      platform.operatingSystem.name,
      platform.type.name,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _guess(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text("WELCOME USER"),
                  const SizedBox(height: 10),
                  Text(snapshot.data!.toString()),
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
