//
//  ChangeDeviceViewController.h
//  MagicCube
//
//  Created by sophie on 2018/12/11.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ChangeDeviceType) {
    changeByPwd = 0,
    changeByCodeMessage
};

@interface ChangeDeviceViewController : BaseViewController
@property (nonatomic, assign) ChangeDeviceType changeDeviceStyle;
@end

NS_ASSUME_NONNULL_END
