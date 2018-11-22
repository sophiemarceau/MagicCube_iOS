//
//  MagicLineView.h
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 横线view
@interface MagicLineView : UIView
- (instancetype)initWithFrame:(CGRect)frame Color:(UIColor *)color;

+ (MagicLineView *)initFame:(CGRect)frame;

+ (MagicLineView *)initwithFrame:(CGRect)frame color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
