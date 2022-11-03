import Flutter
import UIKit

public class SwiftKioskModePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.mews.kiosk_mode/kiosk_mode", binaryMessenger: registrar.messenger())
        let instance = SwiftKioskModePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let eventChannel = FlutterEventChannel(name: "com.mews.kiosk_mode/kiosk_mode_stream", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(KioskModeStreamHandler())
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isInKioskMode":
            isInKioskMode(result)
        case "isManagedKiosk":
            isManagedKiosk(result)
        case "startKioskMode":
            startKioskMode(result)
        case "stopKioskMode":
            stopKioskMode(result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func isInKioskMode(_ result: @escaping FlutterResult) {
        result(UIAccessibility.isGuidedAccessEnabled)
    }
    
    private func isManagedKiosk(_ result: @escaping FlutterResult) {
        result(false)
    }

    private func startKioskMode(_ result: @escaping FlutterResult) {
        requestGuidedAccessSession(enabled: true, completionHandler: { result($0) })
    }
    
    private func stopKioskMode(_ result: @escaping FlutterResult) {
        requestGuidedAccessSession(enabled: false, completionHandler: { result($0) })
    }
    
    private func requestGuidedAccessSession(enabled: Bool, completionHandler: @escaping (Bool) -> Void) {
        UIAccessibility.requestGuidedAccessSession(enabled: enabled, completionHandler: completionHandler)
    }
}

class KioskModeStreamHandler: NSObject, FlutterStreamHandler {
    private var sink: FlutterEventSink? = nil
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(notification:)),
            name: UIAccessibility.guidedAccessStatusDidChangeNotification,
            object: nil
        )
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }
    
    @objc private func handleNotification(notification: NSNotification) {
        if let sink = sink {
            sink(UIAccessibility.isGuidedAccessEnabled)
        }
    }
}
