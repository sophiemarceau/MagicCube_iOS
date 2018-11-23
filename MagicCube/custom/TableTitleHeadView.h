//
//  TableTitleHeadView.h
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableTitleHeadView : UIView
- (void)setUpTitle:(NSString *)title;
- (void)setTitleFrame:(CGRect)frame;
- (void)setLineFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
