
import 'free_contact_picker_platform_interface.dart';

class FreeContactPicker {
  void pickContact(Function(Map<String, dynamic>) onSuccess, {Function(String)? onError}) {
    FreeContactPickerPlatform.instance.pickContact(onSuccess, onError: onError);
  }
}
