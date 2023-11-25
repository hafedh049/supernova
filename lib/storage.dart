import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:supernova/utils/globals.dart';

import 'package:system_info2/system_info2.dart';

class Storage extends StatefulWidget {
  const Storage({super.key});

  @override
  State<Storage> createState() => _MemoryState();
}

class _MemoryState extends State<Storage> {
  final GlobalKey<State> _storageKey = GlobalKey<State>();

  final int _gigaByte = 1024 * 1024 * 1024;
  final int _totalStorage = SysInfo.();

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
                const Icon(Bootstrap.memory, size: 15),
                const SizedBox(width: 10),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: "Storage: ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
                      TextSpan(text: "${(_totalStorage ~/ _gigaByte).toInt()} GB", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              key: _storageKey,
              builder: (BuildContext context, void Function(void Function()) _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Available : $_memory MB", style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 20),
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
