import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supernova/utils/globals.dart';

import 'package:system_info2/system_info2.dart';

class CPU extends StatefulWidget {
  const CPU({super.key});

  @override
  State<CPU> createState() => _MemoryState();
}

class _MemoryState extends State<CPU> {
  late final Timer _timer;
  final GlobalKey<State> _cpuKey = GlobalKey<State>();
  List<double> _clocks = <double>[];
  @override
  void initState() {
    _timer = Timer.periodic(
      1.seconds,
      (Timer timer) {},
    );
    super.initState();
  }

  @override
  void dispose() {
    _clocks.clear();
    _timer.cancel();
    super.dispose();
  }

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
            child: Row(
              children: <Widget>[
                const Icon(Bootstrap.cpu_fill, size: 15),
                const SizedBox(width: 10),
                Text("CPU: ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
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
                    Text("Available : $_clock MHz", style: const TextStyle(fontSize: 13)),
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
