//
//  SmallCardView.m
//  MagicCube
//
//  Created by wanmeizty on 24/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SmallCardView.h"

@interface SmallCardView ()
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) MagicLabel * detailLabel;
@property (strong,nonatomic) MagicLabel * saleLabel;
@property (strong,nonatomic) RedButton * priceBtn;
@end

@implementation SmallCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.imgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.saleLabel];
    [self addSubview:self.priceBtn];
}

- (void)setUpData:(NSDictionary *)dict{
    self.image = [UIImage imageNamed:@"homeCellBgIcon"];
    self.nameLabel.text = [dict objectForKey:@"name"];//@"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.detailLabel.text = [dict objectForKey:@"subTitle"];//@"干燕窝原料印尼进口 CAIQ溯源";
    self.saleLabel.text = @"售价";
    
    NSString * price = [NSString stringWithFormat:@"%.2f元",[[dict objectForKey:@"price"] doubleValue]];
    [self.priceBtn setTitle:price forState:UIControlStateNormal];
    if ([dict objectForKey:@"image"]) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"home_jieqinghaowu"]];//[UIImage imageNamed:@"home_jieqinghaowu"];
    }
    
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(20), 10, SCALE_W(90), 90)];
    }
    return _imgView;
}

-(MagicLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(124), 13, SCALE_W(146), 40)];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = UIFontMediumOfSize(14);
        _nameLabel.textColor = Black1Color;
    }
    return _nameLabel;
}

-(MagicLabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(124), 55, SCALE_W(146), 14)];
        _detailLabel.textColor = Gray858Color;
        _detailLabel.font = UIFontRegularOfSize(10);
    }
    return _detailLabel;
}

-(MagicLabel *)saleLabel{
    if (!_saleLabel) {
        _saleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(124), 78, SCALE_W(28), 12)];
        _saleLabel.textColor = Gray666Color;
        _saleLabel.font = UIFontLightOfSize(12);
        
    }
    return _saleLabel;
}

-(RedButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [[RedButton alloc] initWithFrame:CGRectMake(SCALE_W(168), 72.5, SCALE_W(102), 23)];
        _priceBtn.userInteractionEnabled = NO;
        _priceBtn.titleLabel.font = UIFontLightOfSize(14);
        [_priceBtn setLayerCornerRadius:23 * 0.5];
    }
    return _priceBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
