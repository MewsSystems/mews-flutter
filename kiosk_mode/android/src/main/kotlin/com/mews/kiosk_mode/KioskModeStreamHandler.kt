package com.mews.kiosk_mode

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.fixedRateTimer

typealias KioskModeHandler = () -> Boolean?

class KioskModeStreamHandler(val isKioskMode: KioskModeHandler) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var timer: Timer? = null
    private var previousIsKioskModeState: Boolean? = null
    private val uiThreadHandler: Handler = Handler(Looper.getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        val period: Int = (arguments as Map<*, *>)["androidQueryPeriod"] as Int

        eventSink = events
        timer = fixedRateTimer(period = period.toLong(), daemon = true) {
            val newIsKioskModeState = isKioskMode()
            if (newIsKioskModeState != previousIsKioskModeState) {
                previousIsKioskModeState = newIsKioskModeState
                uiThreadHandler.post() {
                    eventSink?.success(newIsKioskModeState)
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        timer?.cancel()
        timer = null
    }
}