import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_liquid.dart';
import 'flutter_liquid_platform_interface.dart';

/// An implementation of [FlutterLiquidPlatform] that uses method channels.
class MethodChannelFlutterLiquid extends FlutterLiquidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_liquid');

  @override
  Future<String> getVersion() async {
    final result = await methodChannel.invokeMethod<String>('getVersion');
    if (result == null) throw FlutterError('getVersion() returned null');
    return result;
  }

  @override
  Future<String?> startVerify({
    required String endpoint,
    required String apiKey,
    String? token,
    String? applicant,
  }) async {
    return await methodChannel.invokeMethod<String?>(
      'startVerify',
      <String, dynamic>{
        'endpoint': endpoint,
        'apiKey': apiKey,
        'token': token,
        'applicant': applicant,
      },
    );
  }

  @override
  Future<IdentifyIdChipResult> identifyIdChip() async {
    final result =
        await methodChannel.invokeMapMethod<String, dynamic>('identifyIdChip');
    if (result == null) throw FlutterError('identifyIdChip() returned null');

    return IdentifyIdChipResult.fromMap(result);
  }

  @override
  Future<VerifyIdChipResult> verifyIdChip(
      {required String liquidDocumentType,
      required String verificationMethod}) async {
    final result = await methodChannel.invokeMapMethod<String, dynamic>(
      'verifyIdChip',
      <String, dynamic>{
        'liquid_document_type': liquidDocumentType,
        'verification_method': verificationMethod,
      },
    );
    if (result == null) throw FlutterError('verifyIdChip() returned null');

    return VerifyIdChipResult.fromMap(result);
  }

  @override
  Future<VerifyFaceResult> verifyFace() async {
    final result =
        await methodChannel.invokeMapMethod<String, dynamic>('verifyFace');
    if (result == null) throw FlutterError('verifyFace() returned null');

    return VerifyFaceResult.fromMap(result);
  }

  @override
  Future<void> activate() {
    return methodChannel.invokeMethod<void>('activate');
  }
}
