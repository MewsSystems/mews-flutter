package com.mews.kiosk_mode

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.fixedRateTimer


class KioskModeStreamHandler(val getKioskModeState: () -> Boolean?) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var timer: Timer? = null
    private var previousState: Boolean? = getKioskModeState()
    private val mainHandler: Handler = Handler(Looper.getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        val period: Int = (arguments as Map<*, *>)["androidQueryPeriod"] as Int
        eventSink = events
        timer = fixedRateTimer(period = period.toLong(), daemon = true) {
          emit()
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink?.endOfStream()
        eventSink = null
        timer?.cancel()
        timer = null
    }

    fun emit() {
        val currentState = getKioskModeState()
        if (currentState != previousState) {
            previousState = currentState
            eventSink?.let {
                mainHandler.post { it.success(currentState) }
            }
        }
    }
}
