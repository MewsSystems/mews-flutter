#import "KioskModePlugin.h"
#if __has_include(<kiosk_mode/kiosk_mode-Swift.h>)
#import <kiosk_mode/kiosk_mode-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kiosk_mode-Swift.h"
#endif

@implementation KioskModePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKioskModePlugin registerWithRegistrar:registrar];
}
@end
