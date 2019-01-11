//
//  MagicCardView.m
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicCardView.h"
#import "NSString+Size.h"

@interface MagicCardView ()
@property (strong,nonatomic) UIImageView * cardBGView;
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * titleLabel;
@property (strong,nonatomic) MagicLabel * unitLabel;
@property (strong,nonatomic) MagicLabel * opinionLabel;
@property (strong,nonatomic) RedButton * priceBtn;
@property (strong,nonatomic) MagicLineView * lineView;
@property (strong,nonatomic) MagicLabel * distrubePriceLabel;
//@property (strong,nonatomic) MagicLabel * distrubeInfoLabel;
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
//    [self.cardBGView addSubview:self.imgView];
    [self.cardBGView addSubview:self.titleLabel];
    [self.cardBGView addSubview:self.unitLabel];
    [self.cardBGView addSubview:self.opinionLabel];
    [self.cardBGView addSubview:self.priceBtn];
    [self.cardBGView addSubview:self.lineView];
    [self.cardBGView addSubview:self.distrubePriceLabel];
//    [self.cardBGView addSubview:self.distrubeInfoLabel];
}

- (void)setUpDistributeDict:(NSDictionary *)dataDict{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"image"]]];
//    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_jiankanghaowu"]];
    [self.cardBGView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
    self.titleLabel.text = [dataDict objectForKey:@"name"];// @"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.unitLabel.text = [dataDict objectForKey:@"subTitle"];//@"干燕窝原料印尼进口 CAIQ溯源";
    self.opinionLabel.text = @"建议零售价";
    NSString * originalPrice = [NSString stringWithFormat:@"%.2f",[[dataDict objectForKey:@"price"] doubleValue]];
    [self.priceBtn setTitle:originalPrice forState:UIControlStateNormal];
    
    
    NSDictionary * attubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    NSString *discount = [NSString stringWithFormat:@"%d",(int)([[dataDict objectForKey:@"discount"] floatValue] * 100)];
    NSString *price = [NSString stringWithFormat:@"%.2f",[[dataDict objectForKey:@"price"] doubleValue]];;
    NSString *deliveryPrice =[NSString stringWithFormat:@"分销提货价 %@元（%@折）",price,discount];
    NSArray *attrArray = @[price,discount];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
    self.distrubePriceLabel.attributedText = attributestring;//@"分销提货价 688元（5折）";

    
    NSDictionary * attubtrInfoDict = @{NSForegroundColorAttributeName:RedMagicColor};
    
    NSString *commission = [NSString stringWithFormat:@"%.2f",[[dataDict objectForKey:@"commission"] doubleValue]];
    NSString *accessCount = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"accessCount"] integerValue]];
    NSString *salesVolume = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"salesVolume"] integerValue]];
    NSString *distrubeInfo =[NSString stringWithFormat:@"%@客户浏览，%@张被购买，返利%@元",accessCount,salesVolume,commission];
    NSArray *distrubeInfoArray = @[accessCount,salesVolume,commission];
    NSAttributedString * distrubeInfoArrayattributestring = [MagicRichTool initWithString:distrubeInfo dict:attubtrInfoDict subStringArray:distrubeInfoArray];
    self.distrubePriceLabel.attributedText = distrubeInfoArrayattributestring;//@"36客户浏览  已分销8张，分销利润23765元";
}

- (void)setUpDistributeDetailDict:(NSDictionary *)dataDict{
    if ([dataDict objectForKey:@"image"]) {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"image"]]];
//        [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_jiankanghaowu"]];
        [self.cardBGView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
    }
    NSString *nameStr =  [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"name"]];
    CGFloat height = [nameStr heightWithFont: UIFontMediumOfSize(14) constrainedToWidth:SCALE_W(110 +72.5)];
    if (height < 40) {
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.origin.y, SCALE_W(110 +72.5), height);
    }else{
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.origin.y, SCALE_W(110 +72.5), 40);
    }
    self.titleLabel.text = nameStr;
    
    self.unitLabel.text = [dataDict objectForKey:@"subTitle"];
    self.opinionLabel.text = @"建议零售价";
    NSString * originalPrice = [NSString stringWithFormat:@"%.2f元",[[dataDict objectForKey:@"price"] doubleValue]];
    [self.priceBtn setTitle:originalPrice forState:UIControlStateNormal];
    
    NSString *salesVolume = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"salesVolume"]];
    NSString *distribuionCount = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"distributionCount"]];
    NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(8.5),NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice = [NSString stringWithFormat:@"最高可赚%@元/张,已有%@人发卡",salesVolume,distribuionCount];
    NSString *price1 = salesVolume;
    NSString *price2 = distribuionCount;
    NSArray *attrArray = @[price1,price2];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
    self.distrubePriceLabel.attributedText = attributestring;

}

- (void)setUpGoodsDict:(NSDictionary *)dataDict{

    if ([dataDict objectForKey:@"image"]) {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"image"]]];
//        [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_jiankanghaowu"]];
        [self.cardBGView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
        
    }
    
    self.titleLabel.text = [dataDict objectForKey:@"name"];
    self.unitLabel.text = [dataDict objectForKey:@"subTitle"];
    
    self.opinionLabel.text = @"会员分销价";
    [self.priceBtn setTitle:[dataDict objectForKey:@"discountDesc"] forState:UIControlStateNormal];
    
    NSDictionary * attubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    NSString *distributionCount = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"distributionCount"] integerValue]];
    NSString *salesVolume = [NSString stringWithFormat:@"%ld",[[dataDict objectForKey:@"salesVolume"] integerValue]];;
    NSString *deliveryPrice =[NSString stringWithFormat:@"最高可赚%@元/张,已有%@人发卡",salesVolume,distributionCount];
    
    NSArray *attrArray = @[salesVolume,distributionCount];
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
    self.distrubePriceLabel.attributedText = attributestring;//@"分销提货价 688元（5折）";
    
}

-(UIImageView *)cardBGView{
    if (!_cardBGView) {
        _cardBGView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, self.frame.size.height)];
//        _cardBGView.image = [UIImage imageNamed:@"homeCellBgIcon"];
//        _cardBGView.layer.borderColor = LineGrayColor.CGColor;
//        _cardBGView.layer.borderWidth = 0.5;
        
        
        _cardBGView.backgroundColor = [UIColor colorWithHexString:@"4b4773"];
//        _cardBGView.layer.masksToBounds=YES; //这行去掉
        _cardBGView.layer.cornerRadius = 10;
        _cardBGView.layer.shadowColor = [UIColor colorWithHexString:@"000000"].CGColor;
        _cardBGView.layer.shadowOffset = CGSizeMake(0, 1);
        _cardBGView.layer.shadowOpacity = 0.5;
        _cardBGView.layer.shadowRadius = 1;
       
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
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
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
        _lineView = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(111), SCREEN_WIDTH - SCALE_W(20) - SCALE_W(10) - SCALE_W(173), 0.5)];
        _lineView.backgroundColor = GrayMagicColor;
    }
    return _lineView;
}

- (MagicLabel *)distrubePriceLabel{
    if (!_distrubePriceLabel) {
        _distrubePriceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(117), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), SCALE_W(10))];
        _distrubePriceLabel.font = UIFontRegularOfSize(8.5);
        _distrubePriceLabel.textColor = Gray666Color;
    }
    return _distrubePriceLabel;
}

//- (MagicLabel *)distrubeInfoLabel{
//    if (!_distrubeInfoLabel) {
//        _distrubeInfoLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(173), SCALE_W(122), SCREEN_WIDTH - SCALE_W(173) - SCALE_W(20) - SCALE_W(14), SCALE_W(10))];
//        _distrubeInfoLabel.font = UIFontRegularOfSize(8.5);
//        _distrubeInfoLabel.textColor = Gray2A2Color;
//    }
//    return _distrubeInfoLabel;
//}

@end
