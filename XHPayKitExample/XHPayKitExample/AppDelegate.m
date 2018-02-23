//
//  AppDelegate.m
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/9.
//  Copyright © 2018年 it7090.com. All rights reserved.
//

#import "AppDelegate.h"
#import "XHPayKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
/** iOS9及以后 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[XHPayKit defaultManager] handleOpenURL:url];
    if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)
        
    }
    return result;
}
#endif
/** iOS9以下 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[XHPayKit defaultManager] handleOpenURL:url];
    if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)
        
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
