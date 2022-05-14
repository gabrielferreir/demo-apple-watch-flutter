import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class StringService {
  final methodChannel =
  const MethodChannel("myWatchChannel");

  final StreamController<String> _stringStreamController =
  StreamController<String>();

  Stream<String> get stringStream => _stringStreamController.stream;

  StringService() {
    methodChannel.setMethodCallHandler((call) async {
      if (call.method == "new_string") {
        _stringStreamController.add(call.arguments as String);
      } else {
        print("Method not implemented: ${call.method}");
      }
    });
    methodChannel.invokeMethod("isReady");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', stringService: StringService()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.stringService}) : super(key: key);

  final String title;
  final StringService stringService;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const channel = MethodChannel('myWatchChannel');
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.stringService.stringStream.listen((newString) {
      setState(() {
        _counter = int.parse(newString);
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    channel.invokeMethod("sendStringToNative", _counter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              style: Theme.of(context).textTheme.headline4,
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
