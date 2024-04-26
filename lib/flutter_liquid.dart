
import 'flutter_liquid_platform_interface.dart';

class FlutterLiquid {
  Future<String?> getPlatformVersion() {
    return FlutterLiquidPlatform.instance.getPlatformVersion();
  }
}
