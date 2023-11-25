import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:supernova/utils/globals.dart';

class Battery extends StatefulWidget {
  const Battery({super.key});

  @override
  State<Battery> createState() => _MemoryState();
}

class _MemoryState extends State<Battery> {
  final ValueNotifier<double> _batteryNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    _batteryNotifier.dispose();
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
            child: const Row(
              children: <Widget>[
                Icon(Bootstrap.cpu_fill, size: 15),
                SizedBox(width: 10),
                Text("Battery ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DashedCircularProgressBar.aspectRatio(
                  aspectRatio: 1,
                  valueNotifier: _batteryNotifier,
                  progress: 37,
                  startAngle: 225,
                  sweepAngle: 270,
                  foregroundColor: Colors.green,
                  backgroundColor: grey,
                  foregroundStrokeWidth: 15,
                  backgroundStrokeWidth: 15,
                  animation: true,
                  seekSize: 6,
                  seekColor: const Color(0xffeeeeee),
                  child: ValueListenableBuilder(
                    valueListenable: _batteryNotifier,
                    builder: (BuildContext context, double value, Widget? _) => Text(
                      '${value.toInt()}%',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 60),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(LineAwesome.dice_d6_solid, size: 15, color: grey),
                        SizedBox(width: 10),
                        Text("Good", style: TextStyle(fontSize: 9, color: grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(FontAwesome.cube, size: 15, color: grey),
                        SizedBox(width: 10),
                        Text("5000 mAh", style: TextStyle(fontSize: 9, color: grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Bootstrap.sun, size: 15, color: grey),
                        SizedBox(width: 10),
                        Text("22°C / 72°F", style: TextStyle(fontSize: 9, color: grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Bootstrap.clock, size: 15, color: grey),
                        SizedBox(width: 10),
                        Text("00:00", style: TextStyle(fontSize: 9, color: grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
