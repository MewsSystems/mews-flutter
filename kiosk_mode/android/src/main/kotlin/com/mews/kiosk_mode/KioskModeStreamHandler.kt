package com.mews.kiosk_mode

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.fixedRateTimer


class KioskModeStreamHandler(val isKioskMode: () -> Boolean) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var timer: Timer? = null
    private var previousState: Boolean = false
    private val uiThreadHandler: Handler = Handler(Looper.getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        val period: Int = (arguments as Map<*, *>)["androidQueryPeriod"] as Int

        eventSink = events
        timer = fixedRateTimer(period = period.toLong(), daemon = true) {
            val currentState = isKioskMode()
            if (currentState != previousState) {
                previousState = currentState
                uiThreadHandler.post() {
                    eventSink?.success(currentState)
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink?.endOfStream()
        eventSink = null
        timer?.cancel()
        timer = null
    }
}