//
//  RedButton.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "RedButton.h"

@implementation RedButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configstatus];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self configstatus];
    }
    return self;
}

- (void)configstatus{
    [self setTitleColor:BHColorWhite forState:UIControlStateNormal];
    self.backgroundColor = RedMagicColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height * 0.1;
    self.titleLabel.font = UIFontRegularOfSize(14);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
