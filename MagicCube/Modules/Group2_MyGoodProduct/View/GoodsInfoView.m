//
//  GoodsInfoView.m
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "GoodsInfoView.h"

@implementation GoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView * goodsInfoView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - SCALE_W(58)) * 0.5, SCALE_W(21), SCALE_W(58), SCALE_W(58))];
    goodsInfoView.image = [UIImage imageNamed:@"detailseal"];
    goodsInfoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:goodsInfoView];
    
    
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(66), SCALE_W(25) , SCALE_W(22), SCALE_W(23.5))];
    imgView.image = [UIImage imageNamed:@"detalfangwei"];
    [self addSubview:imgView];
    
    MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(93.5), SCALE_W(28.5), SCREEN_WIDTH - SCALE_W(93.5) - SCALE_W(10), 12)];
    label.textColor = [UIColor colorWithHexString:@"7F7569"];
    label.font = UIFontRegularOfSize(SCALE_W(12));
    label.text = @"本卡信息已在蚂蚁金服区块链存证备查";
    [self addSubview:label];
    
    UIButton * lookbtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(80)) * 0.5, SCALE_W(61), SCALE_W(80), 16)];
    lookbtn.layer.cornerRadius = 2;
    lookbtn.titleLabel.font = UIFontRegularOfSize(10);
    lookbtn.layer.borderColor = Gray666Color.CGColor;
    lookbtn.layer.borderWidth = 0.5;
    lookbtn.layer.masksToBounds = YES;
    [lookbtn setTitleColor:Gray666Color forState:UIControlStateNormal];
    [lookbtn setTitle:@"查看数字签名" forState:UIControlStateNormal];
    [self addSubview:lookbtn];
    
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(10))];
    [self addSubview:line];
    
    MagicLineView * line2 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, self.height - SCALE_W(10), SCREEN_WIDTH, SCALE_W(10))];
    [self addSubview:line2];
}

- (void)setUPdata:(NSDictionary *)dict{
    
}


@end
