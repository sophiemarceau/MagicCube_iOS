//
//  ZTYAlertView.m
//  MagicCube
//
//  Created by wanmeizty on 11/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "ZTYAlertView.h"

@interface ZTYAlertView ()
@property (strong,nonatomic) UIView * bgview;
@property (strong,nonatomic) MagicLabel * titleLabel;
@property (strong,nonatomic) UIButton * sureBtn;
@end

@implementation ZTYAlertView

- (instancetype)initWithFrame:(CGRect)frame{
//    frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = SCALE_W(270);
        self.bgview = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width) * 0.5, (SCREEN_HEIGHT - SCALE_W(303)) * 0.45, width, SCALE_W(303))];
        self.bgview.backgroundColor = [UIColor whiteColor];
        self.bgview.layer.masksToBounds = YES;
        self.bgview.layer.cornerRadius = 12;
        [self addSubview:self.bgview];
        
        self.titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, 0, width, SCALE_W(49))];
        self.titleLabel.font = UIFontMediumOfSize(16);
        self.titleLabel.textColor = BHColorWhite;
        self.titleLabel.textAlignment =NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"alertTilteBg"]];
        self.titleLabel.text = @"魔方工分奖励细则";
        [self.bgview addSubview:self.titleLabel];
        
        int index = 0;
        NSArray * array = @[@{},@{},@{}];
        for (NSDictionary * dict in array) {
            UIView * pointView = [[UIView alloc] initWithFrame:CGRectMake(SCALE_W(29) , SCALE_W(32 + 49) + index * SCALE_W(58), SCALE_W(5), SCALE_W(5))];
            pointView.backgroundColor = Gray666Color;
            pointView.layer.cornerRadius = SCALE_W(2.5);
            pointView.layer.masksToBounds = YES;
            [self.bgview addSubview:pointView];
            
            MagicLabel * headLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(39), SCALE_W(22 + 49) + SCALE_W(58) * index, width - SCALE_W(39), SCALE_W(23))];
            headLabel.font = UIFontMediumOfSize(14);
            headLabel.textColor = Black626A75Color;
            [self.bgview addSubview:headLabel];
            
            MagicLabel * detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(39), SCALE_W(45 + 49) + SCALE_W(58) * index, width - SCALE_W(39), SCALE_W(23))];
            detailLabel.font = UIFontRegularOfSize(14);
            detailLabel.textColor = Gray666Color;
            [self.bgview addSubview:detailLabel];
            
            headLabel.text = @"分销商品：";
            detailLabel.text = @"每代理一件商品送1分";
            index ++;
            
        }
        
        MagicLineView * lineView = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(303) - SCALE_W(44) - 0.5, width, 0.5)];
        [self.bgview addSubview:lineView];
        
        self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCALE_W(303) - SCALE_W(44), width, SCALE_W(44))];
        [self.sureBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        [self.sureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = UIFontRegularOfSize(16);
        [self.sureBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.bgview addSubview:self.sureBtn];
        
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
    }
    return self;
}

- (void)click{
    [self removeAllSubviews];
    [self removeFromSuperview];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
