import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supernova/utils/globals.dart';

class Display extends StatelessWidget {
  const Display({super.key});

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
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: white, width: 4),
              ),
            ),
            Transform.rotate(
              angle: -pi / 2,
              child: Container(
                color: white,
                width: 4,
                height: sqrt(pow(100, 2) + pow(100, 2)),
              ),
            ),
            CircleAvatar(
              backgroundColor: grey,
              radius: 25,
              child: Column(
                children: <Widget>[
                  Text(
                    MediaQuery.sizeOf(context).aspectRatio.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${MediaQuery.sizeOf(context).height} x ${MediaQuery.sizeOf(context).width}",
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
