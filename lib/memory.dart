import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supernova/utils/globals.dart';

import 'package:system_info2/system_info2.dart';

class Memory extends StatefulWidget {
  const Memory({super.key});

  @override
  State<Memory> createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  late final Timer _timer;
  final GlobalKey<State> _memoryKey = GlobalKey<State>();
  int _memory = 1000;

  @override
  void initState() {
    _timer = Timer.periodic(
      2.seconds,
      (Timer timer) {
        if (_memoryKey.currentState != null) {
          _memoryKey.currentState!.setState(() => _memory = SysInfo.getFreePhysicalMemory() ~/ (1024 * 1024));
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: grey.withOpacity(.5),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
            offset: const Offset(5, 5),
            spreadRadius: 5,
          ),
        ],
      ),
      width: 200,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: grey.withOpacity(.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StatefulBuilder(
                  key: _memoryKey,
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
