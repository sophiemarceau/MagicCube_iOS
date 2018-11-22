//
//  MagicLabel.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicLabel.h"

@implementation MagicLabel


- (instancetype)init{
    if (self = [super init]) {
        self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.textColor = GrayMagicColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.textColor = GrayMagicColor;
    }
    return self;
}

+ (MagicLabel *)initWithFrame:(CGRect)frame{
    return [MagicLabel initWithFrame:frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
