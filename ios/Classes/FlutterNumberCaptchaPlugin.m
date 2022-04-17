#import "FlutterNumberCaptchaPlugin.h"
#if __has_include(<flutter_number_captcha/flutter_number_captcha-Swift.h>)
#import <flutter_number_captcha/flutter_number_captcha-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_number_captcha-Swift.h"
#endif

@implementation FlutterNumberCaptchaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNumberCaptchaPlugin registerWithRegistrar:registrar];
}
@end
