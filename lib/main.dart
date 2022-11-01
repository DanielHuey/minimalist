import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minimalist/res/config.dart';

void main() {
  runApp(const MinimalApp());
}

class MinimalApp extends StatefulWidget {
  const MinimalApp({super.key});

  @override
  State<MinimalApp> createState() => _MinimalAppState();
}

class _MinimalAppState extends State<MinimalApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> anim;

  static bool switchToggle = false;
  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400));
    anim = CurvedAnimation(parent: controller1, curve: Curves.elasticInOut)
      ..addListener(() {
        setState(() {});
      });
    globalTheme.addListener(() {
      debugPrint('Listening');
      setState(() {});
    });
  }

  static Color switchColor(bool black) {
    return black ? Colors.black54 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: globalTheme.theme(true),
      darkTheme: globalTheme.theme(false),
      themeMode: globalTheme.currentMode(),
      home: Scaffold(
        body: homeBody(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: switchColor(switchToggle),
          title: Text(
            'Hi mini🌴',
            style: TextStyle(color: switchColor(!switchToggle)),
          ),
          centerTitle: true,
          actions: [
            Switch(
              activeColor: Colors.grey[800],
              inactiveTrackColor: Colors.pinkAccent,
              value: switchToggle,
              onChanged: (value) {
                setState(() {
                  switchToggle = !switchToggle;
                  globalTheme.switchTheme();
                });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 5 + (anim.value*10),
          onPressed: () {
            setState(() {
              controller1.isDismissed
                  ? controller1.forward()
                  : controller1.reverse();
            });
          },
          icon: const Icon(Icons.home),
          label: const Text('Home'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

Widget homeBody() {
  return Column(
    children: [
      Expanded(
        flex: 8,
        child: Container(
          decoration: BoxDecoration(
            color: _MinimalAppState.switchColor(_MinimalAppState.switchToggle),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      Expanded(flex: 2, child: Container()),
    ],
  );
}
