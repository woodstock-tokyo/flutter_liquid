import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_liquid/flutter_liquid.dart';
import 'package:flutter_liquid/flutter_liquid_platform_interface.dart';
import 'package:flutter_liquid/flutter_liquid_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLiquidPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLiquidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLiquidPlatform initialPlatform = FlutterLiquidPlatform.instance;

  test('$MethodChannelFlutterLiquid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLiquid>());
  });

  test('getPlatformVersion', () async {
    FlutterLiquid flutterLiquidPlugin = FlutterLiquid();
    MockFlutterLiquidPlatform fakePlatform = MockFlutterLiquidPlatform();
    FlutterLiquidPlatform.instance = fakePlatform;

    expect(await flutterLiquidPlugin.getPlatformVersion(), '42');
  });
}
