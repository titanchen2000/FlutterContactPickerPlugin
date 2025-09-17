import 'contact_picker_platform_interface.dart';

class ContactPicker {
  void pickContact(Function(Map<String, dynamic>) onSuccess, {Function(String)? onError}) {
    ContactPickerPlatform.instance.pickContact(onSuccess, onError: onError);
  }
}
