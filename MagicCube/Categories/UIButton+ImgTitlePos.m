//
//  UIButton+ImgTitlePos.m
//  MagicCube
//
//  Created by wanmeizty on 29/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "UIButton+ImgTitlePos.h"

@implementation UIButton (ImgTitlePos)

- (void)posImgLeftTitleRightCenterInval:(CGFloat)invalW{
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.titleLabel.width - invalW, 0, self.titleLabel.width + invalW)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.imageView.width, 0, -self.imageView.width)];
}

- (void)posImgLeftTitleRightLeftInval:(CGFloat)invalW{
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.titleLabel.width, 0, self.titleLabel.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.imageView.width, 0, -self.imageView.width)];
}

- (void)posImgLeftTitleRightRightInval:(CGFloat)invalW{
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.titleLabel.width, 0, self.titleLabel.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.imageView.width, 0, -self.imageView.width)];
}
@end
