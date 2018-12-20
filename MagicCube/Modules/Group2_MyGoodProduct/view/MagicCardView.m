//
//  MagicCardView.m
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicCardView.h"

@interface MagicCardView ()
@property (strong,nonatomic) UIImageView * cardBGView;
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * titleLabel;
@property (strong,nonatomic) MagicLabel * unitLabel;
@property (strong,nonatomic) MagicLabel * opinionLabel;
@property (strong,nonatomic) RedButton * priceBtn;
@property (strong,nonatomic) MagicLineView * lineView;
@property (strong,nonatomic) MagicLabel * distrubePriceLabel;
@property (strong,nonatomic) MagicLabel * distrubeInfoLabel;
@end

@implementation MagicCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.cardBGView];
    [self.cardBGView addSubview:self.imgView];
    [self.cardBGView addSubview:self.titleLabel];
    [self.cardBGView addSubview:self.unitLabel];
    [self.cardBGView addSubview:self.opinionLabel];
    [self.cardBGView addSubview:self.priceBtn];
    [self.cardBGView addSubview:self.lineView];
    [self.cardBGView addSubview:self.distrubePriceLabel];
    [self.cardBGView addSubview:self.distrubeInfoLabel];
}

- (void)setUpDistributeDict:(NSDictionary *)dataDict{
    
//    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"image"]]];
//    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_jiankanghaowu"]];
    self.titleLabel.text = @"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.unitLabel.text = @"干燕窝原料印尼进口 CAIQ溯源";
    self.opinionLabel.text = @"会员分销价";
    [self.priceBtn setTitle:@"低至6折" forState:UIControlStateNormal];
    self.distrubePriceLabel.text = @"分销提货价 688元（5折）";
    self.distrubePriceLabel.frame = CGRectMake(SCALE_W(173), SCALE_W(108.5), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), SCALE_W(12));
    self.distrubeInfoLabel.text = @"36客户浏览  已分销8张，分销利润23765元";
    self.distrubeInfoLabel.hidden = NO;
    self.lineView.y = SCALE_W(105.5);
    
}

- (void)setUpGoodsDict:(NSDictionary *)dataDict{

    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"image"]]];
    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_jiankanghaowu"]];

    
    self.titleLabel.text = [dataDict objectForKey:@"name"];//@"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.unitLabel.text = [dataDict objectForKey:@"subTitle"];//@"干燕窝原料印尼进口 CAIQ溯源";
    
    self.opinionLabel.text = @"会员分销价";
    [self.priceBtn setTitle:[dataDict objectForKey:@"discountDesc"] forState:UIControlStateNormal];
    // 位会员分销了这张卡,已售出
    NSDictionary * attubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    
    
    NSString *distributionCount = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"distributionCount"] integerValue]];
    NSString *salesVolume = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"salesVolume"] integerValue]];;
    NSString *deliveryPrice =[NSString stringWithFormat:@"%@位会员分销了这张卡,已售出%@件",salesVolume,distributionCount];
    NSArray *attrArray = @[salesVolume,distributionCount];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
    self.distrubePriceLabel.attributedText = attributestring;//@"分销提货价 688元（5折）";
    
    self.distrubePriceLabel.frame = CGRectMake(SCALE_W(173), SCALE_W(117.5), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), 8.5);
    self.distrubeInfoLabel.hidden = YES;
    self.lineView.y = SCALE_W(110);
}

-(UIImageView *)cardBGView{
    if (!_cardBGView) {
        _cardBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        _cardBGView.image = [UIImage imageNamed:@"homeCellBgIcon"];
    }
    return _cardBGView;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(35), SCALE_W(25), SCALE_W(100), SCALE_W(139- 50))];
    }
    return _imgView;
}

- (MagicLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(13), SCREEN_WIDTH - SCALE_W(20) - SCALE_W(14) - SCALE_W(173), SCALE_W(40))];
        _titleLabel.textColor = Black1Color;
        _titleLabel.font = UIFontMediumOfSize(14);
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

-(MagicLabel *)unitLabel{
    if (!_unitLabel) {
        _unitLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(55), SCREEN_WIDTH - SCALE_W(20) - SCALE_W(14) - SCALE_W(173), SCALE_W(14))];
        _unitLabel.textColor = Gray858Color;
        _unitLabel.font = UIFontRegularOfSize(10);
    }
    return _unitLabel;
}

-(MagicLabel *)opinionLabel{
    if (!_opinionLabel) {
        _opinionLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(84), SCALE_W(75), SCALE_W(12))];
        _opinionLabel.textColor = RedMagicColor;
        _opinionLabel.font = UIFontLightOfSize(SCALE_W(12));
    }
    return _opinionLabel;
}

- (RedButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [[RedButton alloc] initWithFrame:CGRectMake(SCALE_W(245), SCALE_W(78), SCALE_W(90), SCALE_W(23))];
        _priceBtn.userInteractionEnabled = NO;
        _priceBtn.titleLabel.font = UIFontLightOfSize(14);
        [_priceBtn setLayerCornerRadius:SCALE_W(23) * 0.5];
    }
    return _priceBtn;
}

- (MagicLineView *)lineView{
    if (!_lineView) {
        _lineView = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(105.5), SCREEN_WIDTH - SCALE_W(20) - SCALE_W(10) - SCALE_W(173), 0.5)];
        _lineView.backgroundColor = GrayMagicColor;
    }
    return _lineView;
}

- (MagicLabel *)distrubePriceLabel{
    if (!_distrubePriceLabel) {
        _distrubePriceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(108.5), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), SCALE_W(12))];
        _distrubePriceLabel.font = UIFontRegularOfSize(8.5);
        _distrubePriceLabel.textColor = Gray666Color;
    }
    return _distrubePriceLabel;
}

- (MagicLabel *)distrubeInfoLabel{
    if (!_distrubeInfoLabel) {
        _distrubeInfoLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(122), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), SCALE_W(10))];
        _distrubeInfoLabel.font = UIFontRegularOfSize(8.5);
        _distrubeInfoLabel.textColor = Gray2A2Color;
    }
    return _distrubeInfoLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
