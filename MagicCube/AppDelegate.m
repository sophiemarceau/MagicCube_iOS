//
//  AppDelegate.m
//  MagicCube
//
//  Created by wanmeizty on 20/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "WXApiManager.h"
#import "WXApi.h"
#import "BaseNavigationViewController.h"

@interface AppDelegate (){
   
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在登陆界面判断登陆成功之后发送通知,将所选的TabbarItem传回,使用通知传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logSelect:) name:NOTIFICATION_NAME_LOGINStatusChange object:nil];     //接收
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setupKeyWindow];
    //向微信注册
    [WXApi registerApp:kWechatAppKey enableMTA:YES];
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    
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
//    if([url.scheme isEqualToString:kWechatAppKey]){
//        NSLog(@"url-openURL--->%@",url.absoluteString);
//        if ([url.absoluteString rangeOfString:@"://oauth?code="].location != NSNotFound){
//            NSArray * arr = [url.absoluteString componentsSeparatedByString:@"&state="];
//            if (arr != nil && arr.count == 2 && [arr[1] isEqualToString:kWechatStatueStr]) {
//                return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//            }
//        }
//    }
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
     NSLog(@"url-openURL--->%@",url.absoluteString);
     return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)logSelect:(NSNotification *)text{
//    [self.mainVc.homeVc requestData];
    [self setupKeyWindow];
}

- (void)setupKeyWindow {
    [UIView transitionWithView:self.window duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        if(User.token){
            self.mainVc = [[MainViewController alloc] init];
            self.window.rootViewController = self.mainVc;
        }else{
            RegisterViewController *vc = [[RegisterViewController alloc] init];
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
            self.window.rootViewController = nav;
        }
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
}


//自定义专场动画(该方法不适用于Nav)
-(void)animation{
//    CATransition *animation = [CATransition animation];
//    //动画时间
//    animation.duration = 0.3f;
//    //过滤效果
//    animation.type = kCATransitionReveal;
////    //枚举值:
////    kCATransitionPush 推入效果
////    kCATransitionMoveIn 移入效果
////    kCATransitionReveal 截开效果
////    kCATransitionFade 渐入渐出效果
//    //动画执行完毕时是否被移除
//    animation.removedOnCompletion = YES;
//    //设置方向-该属性从下往上弹出
//    animation.subtype = kCATransitionFromBottom;
////    枚举值:
////    kCATransitionFromRight//右侧弹出
////    kCATransitionFromLeft//左侧弹出
////    kCATransitionFromTop//顶部弹出
////    kCATransitionFromBottom//底部弹出
//    [self.window.layer addAnimation:animation forKey:nil];
//    self.window.rootViewController = tabbarController;
//
   
}
@end
