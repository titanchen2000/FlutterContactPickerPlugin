import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'contact_picker_method_channel.dart';

abstract class ContactPickerPlatform extends PlatformInterface {
  /// Constructs a ContactPickerPlatform.
  ContactPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ContactPickerPlatform _instance = MethodChannelContactPicker();

  /// The default instance of [ContactPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelContactPicker].
  static ContactPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ContactPickerPlatform] when
  /// they register themselves.
  static set instance(ContactPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void pickContact(Function(Map<String, dynamic>) onSuccess, {Function(String)? onError}) {
    throw UnimplementedError('pickContact() has not been implemented.');
  }
}
