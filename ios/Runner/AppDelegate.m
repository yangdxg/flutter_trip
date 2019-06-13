#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "AsrPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    //注册自有的插件
    [AsrPlugin registerWithRegistrar:[self registrarForPlugin:@"AsrPlugain"]];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
