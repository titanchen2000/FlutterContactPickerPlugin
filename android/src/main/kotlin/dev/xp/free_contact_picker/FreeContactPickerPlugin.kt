package dev.xp.free_contact_picker

import android.app.Activity
import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import android.util.Log
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.io.use
import kotlin.let
import kotlin.to

class FreeContactPickerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var contactPickResult: Result
    private var launcher: ActivityResultLauncher<Intent>? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "free_contact_picker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        if (call.method == "pickContact") {
            if (launcher == null) {
                result.error("PICK_CONTACT_FAILED", "MainActivity must extends FlutterFragmentActivity", null)
                return
            }
            contactPickResult = result
            Intent(Intent.ACTION_PICK).apply {
                type = ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE
            }.also {
                launcher?.launch(it)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        if (binding.activity !is FlutterFragmentActivity) {
            return
        }
        launcher = (binding.activity as FlutterFragmentActivity).registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == Activity.RESULT_OK) {
                val data: Intent? = result.data
                data?.data?.let { uri ->
                    val contactInfo = getContactInfo(binding.activity.contentResolver, uri)
                    contactPickResult.success(
                        mapOf(
                            "name" to contactInfo.first,
                            "phone" to contactInfo.second
                        )
                    )
                } ?: contactPickResult.error("PICK_CONTACT_FAILED", "Unknown error", null)
            } else {
                contactPickResult.error("PICK_CONTACT_FAILED", "User canceled", null)
            }
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    private fun getContactInfo(resolver: ContentResolver, uri: Uri): Pair<String, String> {
        var name = ""
        var phoneNo = ""

        resolver.query(
            uri,
            arrayOf(
                ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME,
                ContactsContract.CommonDataKinds.Phone.NUMBER
            ),
            null,
            null,
            null
        )?.use { cursor ->
            if (cursor.moveToFirst()) {
                val nameIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
                if (nameIndex != -1) {
                    name = cursor.getString(nameIndex) ?: ""
                }

                val phoneIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)
                if (phoneIndex != -1) {
                    phoneNo = cursor.getString(phoneIndex) ?: ""
                }
            }
        }

        return Pair(name, phoneNo)
    }
}
