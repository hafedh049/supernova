import 'dart:async';

import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:supernova/utils/globals.dart';

class CPU extends StatefulWidget {
  const CPU({super.key});

  @override
  State<CPU> createState() => _MemoryState();
}

class _MemoryState extends State<CPU> {
  final GlobalKey<State> _cpuKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(color: grey.withOpacity(.5), blurStyle: BlurStyle.outer, blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: grey.withOpacity(.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Bootstrap.cpu_fill, size: 15),
                SizedBox(width: 10),
                Text("CPU ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              key: _cpuKey,
              builder: (BuildContext context, void Function(void Function()) _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    StreamBuilder<CpuInfo>(
                      stream: CpuReader.cpuStream(1000),
                      builder: (BuildContext context, AsyncSnapshot<CpuInfo> snapshot) {
                        if (snapshot.hasData) {
                          return Text("${snapshot.data!.currentFrequencies} MHz", style: const TextStyle(fontSize: 13));
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(" MHz", style: const TextStyle(fontSize: 13)),
                            ],
                          );
                        } else {
                          return Text(snapshot.error.toString());
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
