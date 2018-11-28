//
//  MemberLevelView.h
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberLevelView : UIView
- (instancetype)initWithFrame:(CGRect)frame imgW:(CGFloat)width;
- (void)configView:(NSString *)imgName levelText:(NSString *)levelStr;
@end

NS_ASSUME_NONNULL_END
