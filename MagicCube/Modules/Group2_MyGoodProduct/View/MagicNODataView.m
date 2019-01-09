//
//  MagicNODataView.m
//  MagicCube
//
//  Created by wanmeizty on 9/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "MagicNODataView.h"
#import "AppDelegate.h"

@implementation MagicNODataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 113.5) * 0.5, SCALE_W(190), 113.5, 130)];
    imgView.image = [UIImage imageNamed:@"nodata"];
    [self addSubview:imgView];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 93) * 0.5, SCALE_W(307), 93, 14)];
    view.backgroundColor = [UIColor colorWithHexString:@"EFEFEF" alpha:0.6];
    [self addSubview:view];
    
    MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(345), SCREEN_WIDTH, 14)];
    [self addSubview:label];
    label.textColor = [UIColor colorWithHexString:@"B5B5B5"];
    label.text = @"还没有可分销的卡片";
    label.textAlignment = NSTextAlignmentCenter;
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) * 0.5, SCALE_W(380), 150, 16)];
    [btn setTitle:@"去添加" forState:UIControlStateNormal];
    [btn setTitleColor:RedMagicColor forState:UIControlStateNormal];
    btn.titleLabel.font = UIFontRegularOfSize(16);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)click:(UIButton *)btn{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.mainVc setSelectedIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
