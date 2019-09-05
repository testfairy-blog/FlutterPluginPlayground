#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate
{
    FlutterMethodChannel* channel;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

  // Prepare channel
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
  self->channel = [FlutterMethodChannel methodChannelWithName:@"playground" binaryMessenger:controller];
    
  __weak typeof(self) weakSelf = self;
  [self->channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      @try {
          // Find a method with the same name in activity
          SEL method = NSSelectorFromString([call.method stringByAppendingString:@":result:"]);
          
          // Call method if exists
          [weakSelf performSelector: method withObject:call.arguments withObject:result];
      } @catch (NSException *exception) {
          NSLog(exception.description);
          result([FlutterError errorWithCode:@"Exception"
                                     message:exception.description
                                     details:nil]);
      } @finally {
      }
  }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) test:(id)args result:(FlutterResult)result {
    result(@"YAY from Objective-C!");
}

@end
