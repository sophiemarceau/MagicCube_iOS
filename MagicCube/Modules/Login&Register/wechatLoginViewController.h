//
//  wechatLoginViewController.h
//  MagicCube
//
//  Created by sophie on 2018/12/6.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WechatLoginType) {
    wechatRegister = 0,
    wechatLogin
};
@interface wechatLoginViewController : BaseViewController

@property (nonatomic, assign) WechatLoginType wechatLoginType;
@property (nonatomic, strong) NSString *localSessionStr;
@end

NS_ASSUME_NONNULL_END
