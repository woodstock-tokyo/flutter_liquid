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
  String _result = 'Unknown';
  final _flutterLiquidPlugin = FlutterLiquid();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    try {
      await _flutterLiquidPlugin.startVerify(
        token: const String.fromEnvironment('TOKEN'),
        applicant: const String.fromEnvironment('APPLICANT'),
        endpoint: const String.fromEnvironment('ENDPOINT'),
        apiKey: const String.fromEnvironment('API_KEY'),
      );
      version = await _flutterLiquidPlugin.getVersion();
    } on PlatformException catch (e) {
      version = 'Failed to get platform version.';
      debugPrint('LIQUID: $e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = version;
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
                'Result: $_result',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await _flutterLiquidPlugin.identifyIdChip();
                    setState(() {
                      _result = result.toString();
                    });
                  } catch (e, stacktrace) {
                    debugPrint('LIQUID: $e');
                    debugPrint('LIQUID: $stacktrace');
                  }
                },
                child: const Text('Identify ID Chip'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await _flutterLiquidPlugin.verifyIdChip(
                        liquidDocumentType:
                            'MY_NUMBER_CARD_WITH_MY_NUMBER', // For example, MY_NUMBER_CARD_WITH_MY_NUMBER, RESIDENCE_CARD, PASSPORT...
                        verificationMethod: 'COMPLY_HE');
                    setState(() {
                      _result = result.toString();
                    });
                  } catch (e, stacktrace) {
                    debugPrint('LIQUID: $e');
                    debugPrint('LIQUID: $stacktrace');
                  }
                },
                child: const Text('Verify ID Chip'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await _flutterLiquidPlugin.verifyFace();
                    setState(() {
                      _result = result.toString();
                    });
                  } catch (e, stacktrace) {
                    debugPrint('LIQUID: $e');
                    debugPrint('LIQUID: $stacktrace');
                  }
                },
                child: const Text('Verify Face'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
