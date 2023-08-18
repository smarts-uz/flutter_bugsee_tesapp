import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bugsee_flutter/bugsee.dart';

Future<void> launchBugsee(
  void Function(bool isBugseeLaunched) appRunner,
) async {
  // var launchOptions;
  var bugseeToken = "";
  if (Platform.isAndroid) {
    bugseeToken = "fbd5c38f-7847-4f32-9af3-2f14ca2474a0";
    // launchOptions = AndroidLaunchOptions();
  } else if (Platform.isIOS) {
    bugseeToken = "6dc9b8a9-0bbd-4f06-ba9c-4241e6f8ac15";
    // launchOptions = IOSLaunchOptions();
  }
  await Bugsee.launch(bugseeToken, appRunCallback: appRunner);
}

Future<void> main() async {
  HttpOverrides.global = Bugsee.defaultHttpOverrides;
  await launchBugsee((bool isBugseeLaunched) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => throw Exception('test bug'),
            icon: const Icon(Icons.bug_report),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
