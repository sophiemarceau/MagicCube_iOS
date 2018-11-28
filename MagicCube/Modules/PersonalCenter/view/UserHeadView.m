//
//  UserHeadView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "UserHeadView.h"

@interface UserHeadView ()
@property (strong,nonatomic) UIImageView * iconView;
@property (strong,nonatomic) UIButton * nameBtn;
@property (strong,nonatomic) MagicLabel * balenceLabel;
@property (strong,nonatomic) MagicLabel * magicPointLabel;
@property (strong,nonatomic) UIButton * menberBtn;
@property (strong,nonatomic) UIImageView * redBGView;
@property (strong,nonatomic) MagicLabel * memberTypeLabel;

@property (strong,nonatomic) UIView * shadowView;

@end

@implementation UserHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.redBGView];
        [self.redBGView addSubview:self.iconView];
        [self.redBGView addSubview:self.nameBtn];
        [self.redBGView addSubview:self.memberTypeLabel];
        
        [self.redBGView addSubview:self.balenceLabel];
        
        
        [self addSubview:self.magicPointLabel];
//        [self addSubview:self.menberBtn];
        
        [self addSubview:self.shadowView];
    }
    return self;
}

- (void)createBGColor{
    
}

- (void)configWithDict:(NSDictionary *)dict{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Bitmap"]]] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
    [self.nameBtn setImage:[UIImage imageNamed:@"zuanshihuiyuan"] forState:UIControlStateNormal];
    [self.nameBtn setTitle:@"用户名" forState:UIControlStateNormal];
    _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_nameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _nameBtn.imageView.width , 0, _nameBtn.imageView.width)];
    [_nameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _nameBtn.titleLabel.width + 5, 0, -_nameBtn.titleLabel.width - 5)];
    
    self.balenceLabel.text = @" 会员卡余额：￥28";
    self.magicPointLabel.text = @"魔方工分：466";
    self.memberTypeLabel.text = @"砖石会员";
    [self.menberBtn setTitle:@"升级合伙人身份" forState:UIControlStateNormal];
}

-(UIImageView *)redBGView{
    if (!_redBGView) {
        _redBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(162))];
        [_redBGView setImage:[UIImage imageNamed:@"redBgIcon"]];
    }
    return _redBGView;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(50), SCALE_W(60), SCALE_W(60))];
        _iconView.layer.cornerRadius = _iconView.height * 0.5;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UIButton *)nameBtn{
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCALE_W(94), SCALE_W(61), 160, SCALE_W(16))];
        [_nameBtn setTitle:@"用户名" forState:UIControlStateNormal];
        [_nameBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        _nameBtn.titleLabel.font = UIFontMediumOfSize(16);
        
        
    }
    return _nameBtn;
}

-(MagicLabel *)memberTypeLabel{
    if (!_memberTypeLabel) {
        _memberTypeLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(167), SCALE_W(66), SCALE_W(80), SCALE_W(10))];
        _memberTypeLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        _memberTypeLabel.textColor = KBGCell;
    }
    return _memberTypeLabel;
}

- (MagicLabel *)balenceLabel{
    if (!_balenceLabel) {
        _balenceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(92), SCALE_W(85), SCALE_W(123.5), SCALE_W(23.5))];
        _balenceLabel.font = UIFontRegularOfSize(12);
        _balenceLabel.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.2];
        _balenceLabel.layer.cornerRadius = 3;
        _balenceLabel.layer.masksToBounds = YES;
        _balenceLabel.textColor = BHColorWhite;
    }
    return _balenceLabel;
}

-(MagicLabel *)magicPointLabel{
    if (!_magicPointLabel) {
        _magicPointLabel = [MagicLabel initWithFrame:CGRectMake(10, SCALE_W(260), SCALE_W(160), 14)];
        _magicPointLabel.font = UIFontRegularOfSize(14);
        _magicPointLabel.textColor = Gray666Color;
    }
    return _magicPointLabel;
}

- (UIButton *)menberBtn{
    if (!_menberBtn) {
        _menberBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCALE_W(244), 33, SCALE_W(121), 32)];
        _menberBtn.titleLabel.font = UIFontMediumOfSize(14);
        _menberBtn.layer.cornerRadius = 5;
        _menberBtn.layer.masksToBounds = YES;
        _menberBtn.backgroundColor = BHColorWhite;
        [_menberBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        [_menberBtn addTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menberBtn;
}

-(UIView *)shadowView{
    if (!_shadowView) {
//        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH - 20, 112)];
//        _shadowView.backgroundColor = [UIColor whiteColor];
//        _shadowView.layer.shadowOffset = CGSizeMake(1, 1);
//        _shadowView.layer.shadowOpacity = 0.8;
//        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _shadowView.layer.shadowRadius = 2;
        
        _shadowView            = [UIView new];
        _shadowView.frame               = CGRectMake(10, 130, SCREEN_WIDTH - 20, 112);
        _shadowView.backgroundColor     = [UIColor whiteColor];
        _shadowView.layer.cornerRadius  = 5;
        _shadowView.layer.masksToBounds = NO;

        _shadowView.layer.shadowColor   = [UIColor colorWithHexString:@"000000" alpha:0.16].CGColor;
        _shadowView.layer.shadowOffset  = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowRadius  = 5;

    }
    return _shadowView;
}

- (void)joinClick{
    if (self.joinMember) {
        self.joinMember();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
