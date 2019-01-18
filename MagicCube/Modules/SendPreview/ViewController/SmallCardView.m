//
//  SmallCardView.m
//  MagicCube
//
//  Created by wanmeizty on 24/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SmallCardView.h"

@interface SmallCardView ()<UITextFieldDelegate>
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) MagicLabel * detailLabel;
@property (strong,nonatomic) MagicLabel * saleLabel;
@property (strong,nonatomic) RedButton * priceBtn;
//@property (strong,nonatomic) UITextField * priceTextField;
//@property (strong,nonatomic) UIImageView * bgView;
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
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.imgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.saleLabel];
    [self addSubview:self.priceBtn];
//    [self addSubview:self.priceTextField];
}

- (void)setUpData:(NSDictionary *)dict{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
    
//    self.image = [UIImage imageNamed:@"homeCellBgIcon"];
    self.nameLabel.text = [dict objectForKey:@"name"];//@"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.detailLabel.text = [dict objectForKey:@"subTitle"];//@"干燕窝原料印尼进口 CAIQ溯源";
    self.saleLabel.text = @"官方零售价";
    
    NSString * price = [NSString stringWithFormat:@"%.2f元",[[dict objectForKey:@"price"] doubleValue]];
//    self.priceTextField.text = price;
    [self.priceBtn setTitle:price forState:UIControlStateNormal];
//    if ([dict objectForKey:@"image"]) {
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"home_jieqinghaowu"]];//[UIImage imageNamed:@"home_jieqinghaowu"];
//    }
    
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(20), 10, SCALE_W(90), 90)];
    }
    return _imgView;
}

-(MagicLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(136), SCALE_W(11.5), SCALE_W(156), SCALE_W(30))];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = UIFontMediumOfSize(12);
        _nameLabel.textColor = Black1Color;

    }
    return _nameLabel;
}

-(MagicLabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(137), SCALE_W(43), SCALE_W(140), SCALE_W(11))];
        _detailLabel.textColor = Gray858Color;
        _detailLabel.font = UIFontRegularOfSize(8);
    }
    return _detailLabel;
}

-(MagicLabel *)saleLabel{
    if (!_saleLabel) {
        _saleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - SCALE_W(14.5)- SCALE_W(50), SCALE_W(61.5), SCALE_W(50), SCALE_W(12))];
        _saleLabel.textColor = Gray666Color;
        _saleLabel.font = UIFontLightOfSize(10);
        
    }
    return _saleLabel;
}



-(RedButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [[RedButton alloc] initWithFrame:CGRectMake(self.frame.size.width- SCALE_W(14.5) - SCALE_W(95), SCALE_W(78.5), SCALE_W(95), SCALE_W(23))];
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
