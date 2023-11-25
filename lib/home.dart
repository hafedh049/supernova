import 'package:flutter/material.dart';
import 'package:supernova/battery.dart';
import 'package:supernova/cpu.dart';
import 'package:supernova/display.dart';
import 'package:supernova/memory.dart';
import 'package:supernova/network.dart';
import 'package:supernova/storage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              Memory(),
              CPU(),
              Storage(),
              Display(),
              Network(),
              Battery(),
            ],
          ),
        ),
      ),
    );
  }
}
