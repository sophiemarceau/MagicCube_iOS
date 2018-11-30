//
//  UIButton+ImageTitleAlign.m
//  MagicCube
//
//  Created by wanmeizty on 30/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "UIButton+ImageTitleAlign.h"

@implementation UIButton (ImageTitleAlign)
- (void)centerAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight space:(CGFloat)space{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    if (isImgLeftTitleRight) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.titleLabel.frame.size.width, 0, self.titleLabel.frame.size.width + space * 0.5)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space * 0.5, 0, 0)];
    }else{
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width + space * 0.5)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.frame.size.width + space * 0.5, 0, -self.titleLabel.frame.size.width)];
    }
}

- (void)leftAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight middleSpace:(CGFloat)middleSpace leftSpace:(CGFloat)leftSpace{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (isImgLeftTitleRight) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,leftSpace,0,0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,leftSpace + middleSpace,0,0)];
    }else{
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-self.imageView.frame.size.width + leftSpace,0,0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,self.titleLabel.frame.size.width + leftSpace+ middleSpace,0,0)];
    }
}

- (void)rightAlignmentImgLeftTitleRight:(BOOL)isImgLeftTitleRight middleSpace:(CGFloat)middleSpace rightSpace:(CGFloat)rightSpace{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (isImgLeftTitleRight) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightSpace + middleSpace)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightSpace)];
    }else{
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,self.imageView.frame.size.width+ middleSpace + rightSpace)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-self.titleLabel.frame.size.width+ rightSpace)];
    }
}
@end
