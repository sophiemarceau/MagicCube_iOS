//
//  ProducDetailtHeaderView.m
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ProducDetailtHeaderView.h"

@implementation ProducDetailtHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = KBGCell;
        [self addSubview: self.bgView];
        [self.bgView addSubview:self.picImageView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.priceLabel];
        [self.bgView addSubview:self.numLabel];
        [self.bgView addSubview:self.redBgLabel];
    }
    return self;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 175 + 114)];
        _bgView.backgroundColor = KBGCell;
    }
    return _bgView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, 175)];
        _picImageView.backgroundColor = [UIColor greenColor];
    }
    return _picImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.picImageView.height +10, self.bgView.width -20, 50)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.font = UIFontRegularOfSize(16);
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"【商品名称】AirJordan 工坊是品牌的灵魂AirJordan 工坊是品牌的灵魂";
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom + 5.5, (self.bgView.width -20)/2, 18)];
        _priceLabel.backgroundColor = [UIColor yellowColor];
        _priceLabel.textColor = GrayMagicColor;
        _priceLabel.font = UIFontRegularOfSize(17);
        _priceLabel.text = @"￥588  零售指导价";
    }
    return _priceLabel;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.priceLabel.bottom + 7, (self.bgView.width -20)/2, 18)];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = GrayMagicColor;
        _numLabel.font = UIFontRegularOfSize(14);
        _numLabel.text = @"已经出售99323个";
    }
    return _numLabel;
}

-(UILabel *)redBgLabel{
    if (_redBgLabel == nil) {
        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.width - 130.5 -10, self.bgView.height - 35 -10 , 130.5, 35)];
        _redBgLabel.backgroundColor = RedMagicColor;
        _redBgLabel.textColor = [UIColor whiteColor];
        _redBgLabel.textAlignment = NSTextAlignmentCenter;
        _redBgLabel.font = UIFontRegularOfSize(14);
        _redBgLabel.text = @"代理价低至3折";
        _redBgLabel.layer.masksToBounds = YES;
        _redBgLabel.layer.cornerRadius = 4;
    }
    return _redBgLabel;
}

@end
