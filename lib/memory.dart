import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<bool> _slots = List<bool>.generate(14, (int index) => false);
  final int _megaByte = 1024 * 1024;
  final int _gegaByte = 1024 * 1024 * 1024;

  @override
  void initState() {
    _timer = Timer.periodic(
      1.seconds,
      (Timer timer) {
        final int freeMemory = SysInfo.getFreePhysicalMemory();
        if (_memory != freeMemory ~/ _megaByte) {
          if (_memoryKey.currentState != null) {
            final int totalMemory = SysInfo.getTotalPhysicalMemory();
            final int slotMemory = totalMemory ~/ 14;
            _slots.clear();
            _slots = List<bool>.generate(14, (int index) => (index * slotMemory <= freeMemory));
            _memoryKey.currentState!.setState(() => _memory = SysInfo.getFreePhysicalMemory() ~/ _megaByte);
          }
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _slots.clear();
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
          BoxShadow(
            color: grey.withOpacity(.5),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
            offset: const Offset(5, 5),
            spreadRadius: 5,
          ),
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
                Image.asset("assets/icons/memory.png", width: 25, height: 25),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              key: _memoryKey,
              builder: (BuildContext context, void Function(void Function()) _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Available : $_memory", style: TextStyle(fontSize: 13.sp)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (bool slot in _slots) ...<Widget>[
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: slot ? blue : grey.withOpacity(.4)),
                          ),
                        ],
                      ],
                    ),
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
