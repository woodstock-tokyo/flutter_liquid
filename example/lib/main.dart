import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_liquid/flutter_liquid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _connectionId = 'Unknown';
  final _flutterLiquidPlugin = FlutterLiquid();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String connectionId;
    try {
      platformVersion = await _flutterLiquidPlugin.getVersion();
      connectionId = await _flutterLiquidPlugin.startVerify(
            endpoint: const String.fromEnvironment('ENDPOINT'),
            apiKey: const String.fromEnvironment('API_KEY'),
          ) ??
          'Unknown';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      connectionId = 'Failed to start verify.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _connectionId = connectionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Version: $_platformVersion', textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Connection id: $_connectionId',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await _flutterLiquidPlugin.identifyIdChip(
                    documentTypeJpki: 1,
                    verificationMethodJpki: 1,
                  );
                },
                child: const Text('Start eKYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
