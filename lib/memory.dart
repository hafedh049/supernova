import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
                const SizedBox(height: 10),
                StreamBuilder<Object>(
                  stream: null,
                  builder: (BuildContext context, snapshot) {
                    return Text("Available : 1024", style: TextStyle(fontSize: 14.sp));
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
