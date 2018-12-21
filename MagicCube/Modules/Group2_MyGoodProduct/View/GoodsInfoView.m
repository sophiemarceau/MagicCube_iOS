//
//  GoodsInfoView.m
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "GoodsInfoView.h"

@implementation GoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView * goodsInfoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCALE_W(56), SCREEN_WIDTH, SCALE_W(182.5 - 76))];
    goodsInfoView.image = [UIImage imageNamed:@"fangweituan"];
    goodsInfoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:goodsInfoView];
    
    
    
    MagicLabel * infoLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_W(46))];
    infoLabel.text = @"商品信息";
    infoLabel.textColor = Gray666Color;
    [self addSubview:infoLabel];
    
    NSArray * titles = @[@"本卡产品认证生产商为厦门燕之屋生物工程发展有限公司",@"本卡产品认证发货商为厦门燕之屋生物工程发展有限公司",@"本卡信息已在蚂蚁金服区块链存证备查"];
    NSArray * imgs = @[@"changshang",@"huoyuan",@"fangwei"];
    int index = 0;
    for (NSString * title in titles) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(22), SCALE_W(11) + SCALE_W(42) + SCALE_W(45.5) * index, SCALE_W(21), SCALE_W(21))];
        imgView.image = [UIImage imageNamed:imgs[index]];
        imgView.tag  =400 + index;
        [self addSubview:imgView];
        
        MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(50), SCALE_W(16.5) + SCALE_W(42)+ SCALE_W(45.5) * index, SCREEN_WIDTH - 10 - SCALE_W(50), 12)];
        label.textColor = [UIColor colorWithHexString:@"7F7569"];
        label.text = title;
        label.tag = 200+ index;
        label.font = UIFontRegularOfSize(SCALE_W(12));
        [self addSubview:label];
        
        if (index < 2) {
            MagicLabel *descLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(15), SCALE_W(38)  + SCALE_W(42) + SCALE_W(45.5) * index, SCREEN_WIDTH - SCALE_W(30), 9)];
            descLabel.font  = UIFontRegularOfSize(SCALE_W(9));
            descLabel.text = @"由厦门燕之屋生物工程发展有限公司数字签名确认";
            descLabel.textColor = [UIColor colorWithHexString:@"948B7F" alpha:0.6];
            [self addSubview:descLabel];
            descLabel.tag = 300 + index;
        }else{
            UIButton * lookbtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(112), SCALE_W(12.5) + SCALE_W(42)+ SCALE_W(45.5) * index, SCALE_W(80), 16)];
            lookbtn.layer.cornerRadius = 2;
            lookbtn.titleLabel.font = UIFontRegularOfSize(10);
            lookbtn.layer.borderColor = Gray666Color.CGColor;
            lookbtn.layer.borderWidth = 0.5;
            lookbtn.layer.masksToBounds = YES;
            [lookbtn setTitleColor:Gray666Color forState:UIControlStateNormal];
            [lookbtn setTitle:@"查看数字签名" forState:UIControlStateNormal];
            [self addSubview:lookbtn];
            
        }
        index++;
    }
    
    MagicLineView * line4 = [[MagicLineView alloc] initWithFrame:CGRectMake(0, SCALE_W(45.5), SCREEN_WIDTH, 0.5)];
    [self addSubview:line4];
}

- (void)setUPdata:(NSDictionary *)dict{
    NSString * supplier = [dict objectForKey:@"supplier"];
    NSString * manufacturer = [dict objectForKey:@"manufacturer"];
    
    MagicLabel *manufacturerLabel = [self viewWithTag:200];
    manufacturerLabel.text = [NSString stringWithFormat:@"本卡产品认证生产商为%@",manufacturer];
    
    MagicLabel *supplierLabel = [self viewWithTag:201];
    supplierLabel.text = [NSString stringWithFormat:@"本卡产品认证发货商为%@",supplier];
    
    MagicLabel *manufacturerSignLabel = [self viewWithTag:300];
    manufacturerSignLabel.text = [NSString stringWithFormat:@"由%@数字签名确认",manufacturer];
    
    MagicLabel *supplierSignLabel = [self viewWithTag:301];
    supplierSignLabel.text = [NSString stringWithFormat:@"由%@数字签名确认",supplier];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
