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
@end

@implementation UserHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createBGColor];
        [self addSubview:self.iconView];
        [self addSubview:self.nameBtn];
        [self addSubview:self.balenceLabel];
        [self addSubview:self.magicPointLabel];
        [self addSubview:self.menberBtn];
    }
    return self;
}

- (void)createBGColor{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"FE4545"].CGColor, (__bridge id)[UIColor colorWithHexString:@"E02E24"].CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.frame;
    [self.layer addSublayer:gradientLayer];
}

- (void)configWithDict:(NSDictionary *)dict{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:@"home_jieqinghaowu"]];
    [self.nameBtn setImage:[UIImage imageNamed:@"zuanshihuiyuan"] forState:UIControlStateNormal];
    [self.nameBtn setTitle:@"用户名" forState:UIControlStateNormal];
    _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_nameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _nameBtn.imageView.width , 0, _nameBtn.imageView.width)];
    [_nameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _nameBtn.titleLabel.width + 5, 0, -_nameBtn.titleLabel.width - 5)];
    
    self.balenceLabel.text = @"会员卡余额：￥28";
    self.magicPointLabel.text = @"魔方工分：466";
    
    [self.menberBtn setTitle:@"升级合伙人身份" forState:UIControlStateNormal];
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height - 58) * 0.5, 58, 58)];
    }
    return _iconView;
}

- (UIButton *)nameBtn{
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 24, 160, 16)];
        [_nameBtn setTitle:@"用户名" forState:UIControlStateNormal];
        [_nameBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        _nameBtn.titleLabel.font = UIFontMediumOfSize(16);
        
        
    }
    return _nameBtn;
}

- (MagicLabel *)balenceLabel{
    if (!_balenceLabel) {
        _balenceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(80, 46, 160, 12)];
        _balenceLabel.font = UIFontRegularOfSize(12);
        _balenceLabel.textColor = BHColorWhite;
    }
    return _balenceLabel;
}

-(MagicLabel *)magicPointLabel{
    if (!_magicPointLabel) {
        _magicPointLabel = [MagicLabel initWithFrame:CGRectMake(80, 63, 160, 12)];
        _magicPointLabel.font = UIFontRegularOfSize(12);
        _magicPointLabel.textColor = BHColorWhite;
    }
    return _magicPointLabel;
}

- (UIButton *)menberBtn{
    if (!_menberBtn) {
        _menberBtn = [[UIButton alloc] initWithFrame:CGRectMake(244, 33, 121, 32)];
        _menberBtn.titleLabel.font = UIFontMediumOfSize(14);
        _menberBtn.layer.cornerRadius = 5;
        _menberBtn.layer.masksToBounds = YES;
        _menberBtn.backgroundColor = BHColorWhite;
        [_menberBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        [_menberBtn addTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menberBtn;
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
