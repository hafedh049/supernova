import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:supernova/utils/globals.dart';

class Network extends StatefulWidget {
  const Network({super.key});

  @override
  State<Network> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  final FlutterInternetSpeedTest speedTest = FlutterInternetSpeedTest();
  double _downloadRate = 0.0;
  String _downloadUnit = "B/s";
  double _uploadRate = 0.0;
  String _uploadUnit = "B/s";

  late final Timer _timer;
  final GlobalKey<State> _networkKey = GlobalKey<State>();

  @override
  void initState() {
    _timer = Timer.periodic(
      1.seconds,
      (Timer timer) {
        if (_networkKey.currentState != null) {
          _networkKey.currentState!.setState(() {});
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
                const Text("Network: ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
                StreamBuilder<ConnectivityResult>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return streamSnapshot.data! == ConnectivityResult.none
                          ? const Text("____", style: TextStyle(letterSpacing: 1.5, fontSize: 11, fontWeight: FontWeight.bold))
                          : FutureBuilder<String>(
                              future: Ipify.ipv4(),
                              builder: (BuildContext context, AsyncSnapshot<String> futureSnapshot) {
                                if (futureSnapshot.hasData) {
                                  return Text(futureSnapshot.data!, style: const TextStyle(letterSpacing: 1.5, fontSize: 11, fontWeight: FontWeight.bold));
                                } else if (futureSnapshot.connectionState == ConnectionState.waiting) {
                                  return LottieBuilder.asset("assets/wait.json", width: 20, height: 20);
                                } else {
                                  return Text(streamSnapshot.error.toString());
                                }
                              },
                            );
                    } else if (streamSnapshot.connectionState == ConnectionState.waiting) {
                      return LottieBuilder.asset("assets/wait.json", width: 20, height: 20);
                    } else {
                      return Text(streamSnapshot.error.toString());
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return streamSnapshot.data! == ConnectivityResult.none
                        ? const Column(
                            children: <Widget>[
                              Icon(FontAwesome.network_wired, size: 64),
                              SizedBox(height: 10),
                              Text("Check your connection.", style: TextStyle(letterSpacing: 1.2, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          )
                        : StatefulBuilder(
                            key: _networkKey,
                            builder: (BuildContext context, void Function(void Function()) _) {
                              return FutureBuilder<bool>(
                                future: speedTest.startTesting(
                                  onDone: (TestResult downloadResult, TestResult uploadResult) {
                                    _downloadUnit = downloadResult.unit.name;
                                    _uploadUnit = uploadResult.unit.name;
                                    _downloadRate = downloadResult.transferRate;
                                    _uploadRate = uploadResult.transferRate;
                                  },
                                  onProgress: (double percent, TestResult data) {},
                                  onError: (String errorMessage, String speedTestError) {},
                                ),
                                builder: (BuildContext context, AsyncSnapshot<bool> futureSnapshot) {
                                  if (futureSnapshot.hasData) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Icon(FontAwesome.chevron_down, size: 15, color: blue),
                                            const SizedBox(width: 10),
                                            Text("${_downloadRate.toStringAsFixed(1)} $_downloadUnit", style: const TextStyle(letterSpacing: 1.5, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            const Icon(FontAwesome.chevron_up, size: 15, color: pink),
                                            const SizedBox(width: 10),
                                            Text("${_uploadRate.toStringAsFixed(1)} $_uploadUnit", style: const TextStyle(letterSpacing: 1.5, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else if (futureSnapshot.connectionState == ConnectionState.waiting) {
                                    return LottieBuilder.asset("assets/wait.json", width: 20, height: 20);
                                  } else {
                                    return Text(streamSnapshot.error.toString());
                                  }
                                },
                              );
                            });
                  } else if (streamSnapshot.connectionState == ConnectionState.waiting) {
                    return LottieBuilder.asset("assets/wait.json", width: 20, height: 20);
                  } else {
                    return Text(streamSnapshot.error.toString());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
