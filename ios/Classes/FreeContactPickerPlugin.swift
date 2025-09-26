import Flutter
import UIKit
import ContactsUI

public class FreeContactPickerPlugin: NSObject, FlutterPlugin, CNContactPickerDelegate {
  private var result: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "free_contact_picker", binaryMessenger: registrar.messenger())
    let instance = FreeContactPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    self.result = result
    switch call.method {
    case "pickContact":
      let contactPicker = CNContactPickerViewController()
      contactPicker.delegate = self
      contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")

      if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
          rootVC.present(contactPicker, animated: true)
      } else {
          result(FlutterError(code: "UNAVAILABLE",message: "can't get root view controller", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    public func contactPicker(_ picker: CNContactPickerViewController,
                            didSelect contact: CNContact) {
        picker.dismiss(animated: true)

        let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""

        result?([
            "name": fullName,
            "phone": phoneNumber
        ])
    }

    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true)
        result?(nil)
    }
}
