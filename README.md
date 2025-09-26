# free_contact_picker

Flutter plugin for pick contact on Android/iOS without any permission.
With this plugin a Flutter app can ask its user to select a contact from his/her address book. The information associated with the contact is returned to the app.

## Example

```
    import 'package:free_contact_picker/free_contact_picker.dart';

    FreeContactPicker().pickContact((contact) {
      print('name: ${contact['name']}');
      print('phone: ${contact['phone']}');
    });
```

or with error handler

```
    FreeContactPicker().pickContact((contact) {
      print('name: ${contact['name']}');
      print('phone: ${contact['phone']}');
    }, onError: (msg) => print(msg));
```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

