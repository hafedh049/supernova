import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supernova/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (
        BuildContext context,
        Orientation orientation,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Welcome(),
          theme: ThemeData.dark(),
        );
      },
    );
  }
}
