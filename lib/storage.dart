import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:storage_info/storage_info.dart';
import 'package:supernova/utils/globals.dart';

class Storage extends StatefulWidget {
  const Storage({super.key});

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final GlobalKey<State> _storageKey = GlobalKey<State>();

  final double _totalStorage = 0;

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
                Row(
                  children: <Widget>[
                    FutureBuilder<double>(
                      future: StorageInfo.getExternalStorageTotalSpaceInGB,
                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                        if (snapshot.hasData) {
                          return Text("${_totalStorage.toStringAsFixed(1)} GB", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold));
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              LottieBuilder.asset("assets/wait.json", width: 20, height: 20),
                              const Text(" GB", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          );
                        } else {
                          return Text(snapshot.error.toString());
                        }
                      },
                    ),
                    const Text("Storage: ", style: TextStyle(fontSize: 11, color: grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: StatefulBuilder(
                key: _storageKey,
                builder: (BuildContext context, void Function(void Function()) _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(width: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(_totalStorage.toStringAsFixed(1), style: const TextStyle(fontSize: 18)),
                          Text(_totalStorage.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
