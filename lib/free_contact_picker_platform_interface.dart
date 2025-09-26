import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'free_contact_picker_method_channel.dart';

abstract class FreeContactPickerPlatform extends PlatformInterface {
  /// Constructs a FreeContactPickerPlatform.
  FreeContactPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FreeContactPickerPlatform _instance = MethodChannelFreeContactPicker();

  /// The default instance of [FreeContactPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFreeContactPicker].
  static FreeContactPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FreeContactPickerPlatform] when
  /// they register themselves.
  static set instance(FreeContactPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void pickContact(Function(Map<String, dynamic>) onSuccess, {Function(String)? onError}) {
    throw UnimplementedError('pickContact() has not been implemented.');
  }
}
