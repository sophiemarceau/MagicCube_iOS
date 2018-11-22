//
//  MagicLineView.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicLineView.h"

@implementation MagicLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Color:(UIColor *)color{
    self = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
    }
    return self;
}

+ (MagicLineView *)initFame:(CGRect)frame{
    return [[MagicLineView alloc] initWithFrame:frame];
}

+ (MagicLineView *)initwithFrame:(CGRect)frame color:(UIColor *)color{
    return [[MagicLineView alloc] initWithFrame:frame Color:color];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
