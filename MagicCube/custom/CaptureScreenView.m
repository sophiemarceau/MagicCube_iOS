//
//  CaptureScreenView.m
//  MagicCube
//
//  Created by wanmeizty on 10/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "CaptureScreenView.h"

@implementation CaptureScreenView

+(UIImage *)getCapture:(NSDictionary *)dict{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 450, 360)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 450, 210)];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]];
    [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [bgView addSubview:imageview];
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(225, 21, 207, 60)];
    titleLabel.font = UIFontMediumOfSize(22);
    titleLabel.textColor = Black1Color;
    titleLabel.numberOfLines = 2;
    titleLabel.text = [dict objectForKey:@"name"];
    [imageview addSubview:titleLabel];
    
    MagicLabel * detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(225, 83, 220, 22)];
    detailLabel.font = UIFontRegularOfSize(16);
    detailLabel.textColor = Gray858Color;
    detailLabel.text = [dict objectForKey:@"subTitle"];
    [imageview addSubview:detailLabel];
    NSString * price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"price"] doubleValue]];
    RedButton * priceLabel = [[RedButton alloc] initWithFrame:CGRectMake(226, 120, 150, 42)];
    [priceLabel setTitle:price forState:UIControlStateNormal];
    priceLabel.titleLabel.font = UIFontRegularOfSize(28);
    [priceLabel setLayerCornerRadius:21];
    [imageview addSubview:priceLabel];

    RedButton * btn = [[RedButton alloc] initWithFrame:CGRectMake(86, 236, 278, 60)];
    [btn setTitle:@"查看" forState:UIControlStateNormal];
    btn.titleLabel.font = UIFontRegularOfSize(30);
    [bgView addSubview:btn];
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(51, 311, 38, 38)];
    imgView.image = [UIImage imageNamed:@"fangwei"];
    [bgView addSubview:imgView];
    
    MagicLabel * textLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(95, 320, 350, 24)];
    textLabel.text = @"本卡已在蚂蚁金服区块链存证备查";
    textLabel.textColor = GrayMagicColor;
    textLabel.font = UIFontRegularOfSize(20);
    [bgView addSubview:textLabel];
    
    UIImage* viewImage = nil;
    UIGraphicsBeginImageContextWithOptions(bgView.frame.size, bgView.opaque, 0.0);
    {
        [bgView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return viewImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
