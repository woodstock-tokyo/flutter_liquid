import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_liquid/flutter_liquid.dart';
import 'package:flutter_liquid/flutter_liquid_platform_interface.dart';
import 'package:flutter_liquid/flutter_liquid_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLiquidPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLiquidPlatform {
  @override
  Future<void> activate() {
    throw UnimplementedError();
  }

  @override
  Future<String> getVersion() => Future.value('42');

  @override
  Future<IdentifyIdChipResult> identifyIdChip() {
    throw UnimplementedError();
  }

  @override
  Future<String?> startVerify(
      {required String endpoint,
      required String apiKey,
      String? token,
      String? applicant}) {
    throw UnimplementedError();
  }

  @override
  Future<VerifyFaceResult> verifyFace() {
    throw UnimplementedError();
  }

  @override
  Future<VerifyIdChipResult> verifyIdChip(
      {required String liquidDocumentType,
      required String verificationMethod}) {
    throw UnimplementedError();
  }
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

    expect(await flutterLiquidPlugin.getVersion(), '42');
  });
}
