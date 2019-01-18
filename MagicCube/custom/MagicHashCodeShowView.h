//
//  MagicHashCodeShowView.h
//  MagicCube
//
//  Created by wanmeizty on 18/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicHashCodeShowView : UIView
- (instancetype)initWithFrame:(CGRect)frame code:(NSString *)code;
- (void)hideView;
- (void)showCode:(NSString *)code;
@end

NS_ASSUME_NONNULL_END
