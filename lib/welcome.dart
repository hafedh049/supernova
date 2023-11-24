import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FutureBuilder<>(
          future: null,
          builder: (BuildContext context, AsyncSnapshot<> snapshot) {
            if(snapshot.hasData){
              return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("WELCOME USER"),
                const SizedBox(height: 10),
                Text(data),
              ],
            );
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return ;
            }
          }
        ),
      ),
    );
  }
}
