import 'package:better_cpu_reader/cpu_reader.dart';
import 'package:better_cpu_reader/cpuinfo.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:supernova/utils/globals.dart';

class CPU extends StatefulWidget {
  const CPU({super.key});

  @override
  State<CPU> createState() => _MemoryState();
}

class _MemoryState extends State<CPU> {
  final GlobalKey<State> _cpuKey = GlobalKey<State>();
  final ValueNotifier<double> _frequencyNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    //_frequencyNotifier.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _frequencyNotifier.dispose();
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
                      stream: CpuReader.asStream(1.seconds),
                      builder: (BuildContext context, AsyncSnapshot<CpuInfo> snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              DashedCircularProgressBar.aspectRatio(
                                aspectRatio: 1,
                                valueNotifier: _frequencyNotifier,
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
                                  valueListenable: _frequencyNotifier,
                                  builder: (BuildContext context, double value, Widget? _) => Text(
                                    '${value.toInt()}%',
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 60),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 150),
                              Text("${snapshot.data!.currentFrequencies} MHz", style: const TextStyle(fontSize: 13)),
                            ],
                          );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              LottieBuilder.asset("assets/wait.json", width: 20, height: 20),
                              const Text(" MHz", style: TextStyle(fontSize: 13)),
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
