//
//  MagicHashCodeShowView.m
//  MagicCube
//
//  Created by wanmeizty on 18/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "MagicHashCodeShowView.h"

@interface MagicHashCodeShowView ()
@property (strong,nonatomic) MagicLabel * codeLabel;
@end

@implementation MagicHashCodeShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame code:(NSString *)code
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:code];
    }
    return self;
}

-(void)createUI:(NSString *)code{
    
    self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(268)) * 0.5, (self.height - SCALE_W(334)) * 0.4, SCALE_W(268), SCALE_W(334))];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = BHColorWhite;
    [self addSubview:bgView];
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(20), bgView.width, SCALE_W(16))];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = UIFontMediumOfSize(16);
    titleLabel.textColor = BlackMagicColor;
    titleLabel.text = @"区块链存证摘要";
    [bgView addSubview:titleLabel];
    
    UIView *codebgView = [[UIView alloc] initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(56), bgView.width - SCALE_W(40), SCALE_W(76))];
    codebgView.backgroundColor = [UIColor colorWithHexString:@"FBF3F3"];
    codebgView.layer.cornerRadius = 3;
    codebgView.layer.masksToBounds = YES;
    [bgView addSubview:codebgView];
    
    MagicLabel * codeLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(15), SCALE_W(10), codebgView.width - SCALE_W(30), SCALE_W(56))];
    codeLabel.numberOfLines = 0;
    codeLabel.textColor = Gray666Color;
    codeLabel.text = code;
    codeLabel.font = UIFontRegularOfSize(10);
    
    [codebgView addSubview:codeLabel];
    self.codeLabel = codeLabel;
    
    MagicLabel * nodeLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(154), bgView.width - SCALE_W(40), 60)];
    nodeLabel.text = @"说明：区块链上的存症摘要可以证明原始数据的完整可信及上链时间，在技术上杜绝伪造或篡改的可能性。";
    nodeLabel.numberOfLines = 0;
    nodeLabel.font = UIFontRegularOfSize(12);
    nodeLabel.textColor = Gray666Color;
    [bgView addSubview:nodeLabel];
    
    RedButton * sureBtn = [[RedButton alloc] initWithFrame:CGRectMake((bgView.width - SCALE_W(139)) * 0.5, bgView.height - SCALE_W(28) - SCALE_W(32), SCALE_W(139), SCALE_W(32))];
    [sureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = UIFontRegularOfSize(15);
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sureBtn];
    
}

- (void)tapClick{
    [self hideView];
}

- (void)hideView{
    self.hidden = YES;
    [self removeAllSubviews];
    [self removeFromSuperview];
}

- (void)showCode:(NSString *)code{
    self.codeLabel.text = code;
    self.hidden = NO;
    
}

- (void)sure{
    [self hideView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
