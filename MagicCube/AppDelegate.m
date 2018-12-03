//
//  AppDelegate.m
//  MagicCube
//
//  Created by wanmeizty on 20/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "WXApiManager.h"
#import "WXApi.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    MainViewController *mainVc = [[MainViewController alloc] init];
    self.window.rootViewController = mainVc;
    
    
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    
    //向微信注册
    [WXApi registerApp:kWechatAppKey enableMTA:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([url.scheme isEqualToString:kWechatAppKey]){
        NSLog(@"url-openURL--->%@",url.absoluteString);
//        if ([url.absoluteString rangeOfString:@"://oauth?code="].location != NSNotFound){
//            NSArray * arr = [url.absoluteString componentsSeparatedByString:@"&state="];
//            if (arr != nil && arr.count == 2 && [arr[1] isEqualToString:WechatStatueStr]) {
//                return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//            }
//        }
    }
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


@end
