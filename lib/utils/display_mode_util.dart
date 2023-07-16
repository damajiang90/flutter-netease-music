import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class DisplayModeUtil {
  static List<DisplayMode> modes = <DisplayMode>[];
  static DisplayMode? active;
  static DisplayMode? preferred;
  static void debugPrintObject(Object? object) {
    debugPrint(object?.toString());
  }

  static Future<void> initDisplay() async {
    try {
      modes = await FlutterDisplayMode.supported;
      modes.forEach(debugPrintObject);

      /// On OnePlus 7 Pro:
      /// #0 0x0 @0Hz // Automatic
      /// #1 1080x2340 @ 60Hz
      /// #2 1080x2340 @ 90Hz
      /// #3 1440x3120 @ 90Hz
      /// #4 1440x3120 @ 60Hz

      /// On OnePlus 8 Pro:
      /// #0 0x0 @0Hz // Automatic
      /// #1 1080x2376 @ 60Hz
      /// #2 1440x3168 @ 120Hz
      /// #3 1440x3168 @ 60Hz
      /// #4 1080x2376 @ 120Hz
    } on PlatformException catch (e) {
      debugPrint(
        e.toString(),
      );

      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }
    preferred = await FlutterDisplayMode.preferred;
    debugPrint('displayModePreferred:$preferred');
    active = await FlutterDisplayMode.active;
    debugPrint('displayModeActivie:$active');
    await FlutterDisplayMode.setHighRefreshRate();
  }
}
