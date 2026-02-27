# free_contact_picker

Flutter plugin for pick contact on Android/iOS without any permission.
With this plugin a Flutter app can ask its user to select a contact from his/her address book. The information associated with the contact is returned to the app.

## Install
With Flutter:

```commandline
flutter pub add free_contact_picker
```

Or Add the following line to your `pubspec.yaml` file (and run an implicit ```flutter pub get```)
```yaml
dependencies:
  free_contact_picker: ^1.0.1
```

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
