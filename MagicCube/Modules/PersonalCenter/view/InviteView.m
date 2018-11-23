//
//  InviteView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "InviteView.h"

@implementation InviteView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        MagicLabel * noteLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 14)];
        noteLabel.textColor = Gray666Color;
        noteLabel.text = @"组队代理，可获额外分销分成+利润分成";
        noteLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:noteLabel];
        
        RedButton * inviteBtn = [[RedButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 192) * 0.5, 99, 192, 38)];
        [inviteBtn setTitle:@"邀请好友一起组队" forState:UIControlStateNormal];
        [self addSubview:inviteBtn];
        
        self.backgroundColor = BHColorWhite;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
