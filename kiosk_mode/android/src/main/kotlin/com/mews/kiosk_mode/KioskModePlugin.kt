package com.mews.kiosk_mode

import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.view.ViewGroup
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class KioskModePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.mews.kiosk_mode/kiosk_mode")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "startKioskMode") {
            activity?.let { a ->
                // ensures that startLockTask() will not throw
                // see https://stackoverflow.com/questions/27826431/activity-startlocktask-occasionally-throws-illegalargumentexception
                a.findViewById<ViewGroup>(android.R.id.content).getChildAt(0).post {
                    try {
                        a.startLockTask()
                        result.success(true)
                    } catch (e: IllegalArgumentException) {
                        result.success(false)
                    }
                }
            } ?: result.success(false)
        } else if (call.method == "stopKioskMode") {
            activity?.stopLockTask()
            result.success(null)
        } else if (call.method == "isInKioskMode") {
            val service = activity?.getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
            if (service == null) {
                result.success(null)
                return
            }

            val isInKioskMode = when (service.lockTaskModeState) {
                ActivityManager.LOCK_TASK_MODE_NONE -> false
                ActivityManager.LOCK_TASK_MODE_PINNED,
                ActivityManager.LOCK_TASK_MODE_LOCKED -> true
                else -> false
            }

            result.success(isInKioskMode)
        } else if (call.method == "isManagedKiosk") {
            val service = activity?.getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
            if (service == null) {
                result.success(null)
                return
            }

            result.success(service.lockTaskModeState == ActivityManager.LOCK_TASK_MODE_LOCKED)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {
        this.activity = null
    }
}
