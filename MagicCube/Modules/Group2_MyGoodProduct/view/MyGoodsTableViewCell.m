//
//  MyGoodsTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MyGoodsTableViewCell.h"

@interface MyGoodsTableViewCell ()
@property (strong,nonatomic) UIImageView * goodsImgView;
@property (strong,nonatomic) MagicLabel * goodsNameLabel;
@property (strong,nonatomic) MagicLabel * deliveryPriceLabel;
@property (strong,nonatomic) MagicLabel * distributionPriceLabel;
@property (strong,nonatomic) MagicLabel * descLabel;
@end

@implementation MyGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat left = 125;
        CGFloat cellHeight = [MyGoodsTableViewCell cellHeight];
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        self.goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 100, 100)];
        [self.contentView addSubview:self.goodsImgView];
        
        self.goodsNameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(left, 18.5, SCREEN_WIDTH - left - 10, 16)];
        self.goodsNameLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.goodsNameLabel.textColor = BlackMagicColor;
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.deliveryPriceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(left, 48.5, SCREEN_WIDTH - left - 10, 18)];
        [self.contentView addSubview:self.deliveryPriceLabel];
        
        self.distributionPriceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(left, 71.5, SCREEN_WIDTH - left - 10, 18)];
        [self.contentView addSubview:self.distributionPriceLabel];
        
        self.descLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(left, 100, SCREEN_WIDTH - left - 10, 14)];
        [self.contentView addSubview:self.descLabel];
        
        MagicLineView * lineView = [MagicLineView initFame:CGRectMake(0, cellHeight - 10, SCREEN_WIDTH, 10)];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)configDict:(NSDictionary *)dict{
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"url"]]] placeholderImage:[UIImage imageNamed:@"home_jieqinghaowu"]];
    
    self.goodsNameLabel.text = @"【商品名称】Asnières 工坊是品…";
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    NSDictionary * attubtrDict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice =@"¥ 288  提货价(黄金会员价)";
    
    
    NSString *price = @"¥ 288";
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subString:price];
    self.deliveryPriceLabel.attributedText = attributestring;
    
    NSString *distrubteString=@"¥ 588  分销价";
    NSString *distrubeprice = @"¥ 588";
    NSAttributedString * attributestring2 = [MagicRichTool initWithString:distrubteString dict:attubtrDict subString:distrubeprice];
    self.distributionPriceLabel.attributedText = attributestring2;
    
    
    NSDictionary * descattubtrDict = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:14],NSForegroundColorAttributeName:BlackMagicColor};
    NSString * descString =  @"23 次浏览，已出售 5个";
    NSArray * array = @[@{subDictKey:descattubtrDict,substrKey:@"23"},@{subDictKey:descattubtrDict,substrKey:@"5"}];
    NSAttributedString * descRSting = [MagicRichTool initWithString:descString attrbutes:array];
    self.descLabel.attributedText = descRSting;
    
}

+ (CGFloat)cellHeight{
    return 138;
}

@end
