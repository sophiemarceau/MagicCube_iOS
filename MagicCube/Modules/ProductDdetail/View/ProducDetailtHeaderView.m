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
//        [self.bgView addSubview:self.titleLabel];
//        [self.bgView addSubview:self.priceLabel];
//        [self.bgView addSubview:self.numLabel];
//        [self.bgView addSubview:self.redBgView];
    }
    return self;
}


//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}


- (void)configwidth:(NSDictionary *)dict{
//    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"url"]]] placeholderImage:[UIImage imageNamed:@"详情"]];
//    self.numLabel.text = @"已经出售99323个";
//    self.titleLabel.text = @"【商品名称】Asnières 工坊是品牌的灵魂Asnières 工坊是品牌的灵魂";
//    NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(17),NSForegroundColorAttributeName:RedMagicColor};
//    NSString *deliveryPrice =@"¥ 588  零售指导价";
//    NSString *price = @"¥ 588";
//    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subString:price];
//    self.priceLabel.attributedText = attributestring;
//
//    NSDictionary * attubtrDict1 = @{NSFontAttributeName:UIFontRegularOfSize(22),NSForegroundColorAttributeName:[UIColor whiteColor]};
//    NSString *deliveryPrice1 =@"代理价低至 3 折";
//    NSString *price1 = @"3";
//    NSAttributedString * attributestring1 = [MagicRichTool initWithString:deliveryPrice1 dict:attubtrDict1 subString:price1];
//    self.redBgLabel.attributedText = attributestring1;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 173.5)];
        _bgView.backgroundColor = KBGCell;
    }
    return _bgView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13.5, self.bgView.width, 145)];
//        _picImageView.backgroundColor = [UIColor greenColor];
        NSString *nameStr =  [NSString stringWithFormat:@"首页_%d",[self getRandomNumber:1 to:3]];
        _picImageView.image = [UIImage imageNamed:nameStr];
    }
    return _picImageView;
}



//-(UILabel *)titleLabel{
//    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.picImageView.height +10, self.bgView.width -20, 50)];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.textColor = BlackMagicColor;
//        _titleLabel.font = UIFontRegularOfSize(16);
//        _titleLabel.numberOfLines = 2;
//
//    }
//    return _titleLabel;
//}
//
//-(UILabel *)priceLabel{
//    if (_priceLabel == nil) {
//        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom + 5.5, (self.bgView.width -20)/2, 18)];
//        _priceLabel.backgroundColor = [UIColor clearColor];
//        _priceLabel.textColor = GrayMagicColor;
//        _priceLabel.font = UIFontRegularOfSize(14);
//    }
//    return _priceLabel;
//}
//
//-(UILabel *)numLabel{
//    if (_numLabel == nil) {
//        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.priceLabel.bottom + 7, (self.bgView.width -20)/2, 18)];
//        _numLabel.backgroundColor = [UIColor clearColor];
//        _numLabel.textColor = GrayMagicColor;
//        _numLabel.font = UIFontRegularOfSize(14);
//        _numLabel.text = @"已经出售99323个";
//    }
//    return _numLabel;
//}
//
//-(UILabel *)redBgLabel{
//    if (_redBgLabel == nil) {
//        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6 , self.redBgView.width, 20)];
//        _redBgLabel.backgroundColor = [UIColor clearColor];
//        _redBgLabel.textColor = [UIColor whiteColor];
//        _redBgLabel.textAlignment = NSTextAlignmentCenter;
//        _redBgLabel.font = UIFontRegularOfSize(14);
//
//    }
//    return _redBgLabel;
//}
//
//-(UIView *)redBgView{
//    if (_redBgView == nil) {
//        _redBgView = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.width - 130.5 -10, self.bgView.height - 35 -10 , 130.5, 35)];
//        _redBgView.backgroundColor = RedMagicColor;
//        _redBgView.layer.masksToBounds = YES;
//        _redBgView.layer.cornerRadius = 4;
//        [_redBgView addSubview:self.redBgLabel];
//    }
//    return _redBgView;
//}
@end
