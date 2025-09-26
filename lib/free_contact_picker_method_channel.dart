import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'free_contact_picker_platform_interface.dart';

/// An implementation of [FreeContactPickerPlatform] that uses method channels.
class MethodChannelFreeContactPicker extends FreeContactPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('free_contact_picker');

  @override
  void pickContact(Function(Map<String, dynamic>) onSuccess, {Function(String)? onError}) async {
    try {
      final Map<String, dynamic>? result = await methodChannel.invokeMapMethod('pickContact');
      if (result != null) {
        onSuccess(result);
      } else {
        onError?.call('PICK_CONTACT_FAILED, result is null');
      }
    } on PlatformException catch (e) {
      onError?.call('${e.code}, ${e.message}');
    }
  }
}
