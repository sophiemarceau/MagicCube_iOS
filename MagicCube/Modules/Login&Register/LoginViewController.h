//
//  LoginViewController.h
//  MagicCube
//
//  Created by sophie on 2018/12/5.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 登录回调
 
 @param isComplete 是否完成登录
 */
typedef void (^BHLoginCompletion)(BOOL isComplete);

typedef NS_ENUM(NSInteger, LoginStyle) {
    pwdLogin = 0,
    codeMessageLogin
};


@interface LoginViewController : BaseViewController
@property (nonatomic, assign) LoginStyle loginStyle;
+(void) OpenLogin:(UIViewController *)viewController callback:(BHLoginCompletion) loginComplation;

@end

NS_ASSUME_NONNULL_END
