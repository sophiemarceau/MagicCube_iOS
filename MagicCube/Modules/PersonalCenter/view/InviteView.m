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
        MagicLabel * noteLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(22), SCREEN_WIDTH - 20, SCALE_W(36))];
        noteLabel.text = @"您可以邀请好友共同组队，获得团队超额分销收益。\n业绩排名前50%团队可根据排名获得额外5-50%分销收益。";
        noteLabel.textAlignment = NSTextAlignmentCenter;
        noteLabel.numberOfLines = 2;
        noteLabel.font = UIFontRegularOfSize(SCALE_W(12));
        [self addSubview:noteLabel];
        
        UIButton * inviteBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(196)) * 0.5, SCALE_W(88), SCALE_W(196), SCALE_W(38))];
        inviteBtn.layer.cornerRadius = 3;
        inviteBtn.layer.masksToBounds = YES;
        inviteBtn.layer.borderColor = RedMagicColor.CGColor;
        inviteBtn.layer.borderWidth = 0.5;
        [inviteBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        [inviteBtn setTitle:@"邀请好友组队" forState:UIControlStateNormal];
        inviteBtn.backgroundColor = BHColorWhite;
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
