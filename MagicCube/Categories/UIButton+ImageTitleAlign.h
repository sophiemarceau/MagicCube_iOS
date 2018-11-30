//
//  UIButton+ImageTitleAlign.h
//  MagicCube
//
//  Created by wanmeizty on 30/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//图片与文字并存左中右对齐方式
@interface UIButton (ImageTitleAlign)
// 居中对齐
- (void)centerAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight space:(CGFloat)space;

// 左对齐
- (void)leftAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight middleSpace:(CGFloat)middleSpace leftSpace:(CGFloat)leftSpace;

// 右对齐
- (void)rightAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight middleSpace:(CGFloat)middleSpace rightSpace:(CGFloat)rightSpace;
@end

NS_ASSUME_NONNULL_END
