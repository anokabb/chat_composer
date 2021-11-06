#import "ChatComposerPlugin.h"
#if __has_include(<chat_composer/chat_composer-Swift.h>)
#import <chat_composer/chat_composer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "chat_composer-Swift.h"
#endif

@implementation ChatComposerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftChatComposerPlugin registerWithRegistrar:registrar];
}
@end
