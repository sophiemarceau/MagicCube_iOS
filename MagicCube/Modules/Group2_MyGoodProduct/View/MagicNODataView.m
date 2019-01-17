//
//  MagicNODataView.m
//  MagicCube
//
//  Created by wanmeizty on 9/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "MagicNODataView.h"
#import "AppDelegate.h"

@interface MagicNODataView ()
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * titleLabel;
@property (strong,nonatomic) UIButton * addBtn;
@end
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
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 114) * 0.5, SCALE_W(190), 114, 134)];
    imgView.image = [UIImage imageNamed:@"nodata"];
    [self addSubview:imgView];
    self.imgView = imgView;
    
    MagicLabel * label = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(344.5), SCREEN_WIDTH, 14)];
    [self addSubview:label];
    label.textColor = Gray858Color;
    label.text = @"还没有可分销的卡片";
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = label;
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) * 0.5, SCALE_W(379), 150, 16)];
    [btn setTitle:@"去添加" forState:UIControlStateNormal];
    [btn setTitleColor:RedMagicColor forState:UIControlStateNormal];
    btn.titleLabel.font = UIFontRegularOfSize(16);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.addBtn = btn;
}

-(void)setUpImageName:(NSString *)imageName title:(NSString *)title addShow:(BOOL)showAdd{
    
    self.titleLabel.text = title;
    self.imgView.image = [UIImage imageNamed:imageName];
    self.addBtn.hidden = !showAdd;
    
    CGSize size = [UIImage imageNamed:imageName].size;
    self.imgView.frame = CGRectMake((self.width - size.width) * 0.5, (self.height - size.height - 34) * 0.45, size.width, size.height);
    
    self.titleLabel.frame = CGRectMake(0, self.imgView.bottom + 20, self.width, 14);
    
    self.addBtn.y = self.titleLabel.bottom + 20;
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
