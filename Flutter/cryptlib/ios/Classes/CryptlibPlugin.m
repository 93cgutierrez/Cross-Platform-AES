#import "CryptlibPlugin.h"
#if __has_include(<cryptlib/cryptlib-Swift.h>)
#import <cryptlib/cryptlib-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cryptlib-Swift.h"
#endif

@implementation CryptlibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCryptlibPlugin registerWithRegistrar:registrar];
}
@end
