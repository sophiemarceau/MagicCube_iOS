//
//  RewardView.m
//  MagicCube
//
//  Created by wanmeizty on 16/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "RewardView.h"
@interface RewardView ()
@property (strong,nonatomic) MagicLabel * rewardDescLabel;
@end
@implementation RewardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(10))];
    [self addSubview:line];
    
    MagicLabel * rewardTitleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(10), SCALE_W(10), SCREEN_WIDTH, SCALE_W(42))];
    rewardTitleLabel.text = @"抽奖返利";
    rewardTitleLabel.textColor = Gray666Color;
    [self addSubview:rewardTitleLabel];
    
    self.rewardDescLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(10), SCALE_W(52), SCREEN_WIDTH, SCALE_W(42))];
    self.rewardDescLabel.textColor = Gray666Color;
//    self.rewardDescLabel.text = @"用户通过您发的卡参与抽奖，您可获得抽奖充值金额的50%返利";
    self.rewardDescLabel.font = UIFontRegularOfSize(12);
    [self addSubview:self.rewardDescLabel];
    
    MagicLineView * rewardline2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(52), SCREEN_WIDTH, 0.5)];
    [self addSubview:rewardline2];
    
    MagicLineView * rewardline = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(94), SCREEN_WIDTH, SCALE_W(10))];
    [self addSubview:rewardline];
}

-(void)setUpdata:(int)percent{
    self.rewardDescLabel.text = [NSString stringWithFormat:@"用户通过您发的卡参与抽奖，您可获得抽奖充值金额的%d%%返利",percent]; //
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
