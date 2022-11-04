package com.mews.kiosk_mode

import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.view.ViewGroup
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

private const val methodChannelName = "com.mews.kiosk_mode/kiosk_mode"
private const val eventChannelName = "com.mews.kiosk_mode/kiosk_mode_stream"

class KioskModePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, methodChannelName)
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, eventChannelName)
        eventChannel.setStreamHandler(KioskModeStreamHandler(this::isInKioskMode))
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startKioskMode" -> startKioskMode(result)
            "stopKioskMode" -> stopKioskMode(result)
            "isInKioskMode" -> isInKioskMode(result)
            "isManagedKiosk" -> isManagedKiosk(result)
            else -> result.notImplemented()
        }
    }

    private fun startKioskMode(result: MethodChannel.Result) {
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
    }

    private fun stopKioskMode(result: MethodChannel.Result) {
        val isInKioskMode = isInKioskMode() ?: false

        if(isInKioskMode) {
            activity?.stopLockTask()
            result.success(true)
        } else {
            result.success(false)
        }
    }


    private fun isManagedKiosk(result: MethodChannel.Result) {
        val service = activity?.getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
        if (service == null) {
            result.success(null)
            return
        }

        result.success(service.lockTaskModeState == ActivityManager.LOCK_TASK_MODE_LOCKED)
    }

    private fun isInKioskMode(result: MethodChannel.Result) {
        result.success(isInKioskMode())
    }

    private fun isInKioskMode(): Boolean? {
        val service = activity?.getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
            ?: return null

        return when (service.lockTaskModeState) {
            ActivityManager.LOCK_TASK_MODE_PINNED,
            ActivityManager.LOCK_TASK_MODE_LOCKED -> true
            else -> false
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
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
