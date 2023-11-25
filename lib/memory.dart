import 'package:flutter/material.dart';
import 'package:supernova/utils/globals.dart';

class Memory extends StatefulWidget {
  const Memory({super.key});

  @override
  State<Memory> createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
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
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
