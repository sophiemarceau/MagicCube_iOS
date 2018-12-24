//
//  AboutViewController.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (strong,nonatomic) MagicLabel * gradeLabel;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)initdata{
    self.title = @"关于魔方";
}

- (void)addSubViews{
    
    CGFloat height = SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT;
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(149)) * 0.5, SCALE_W(60), SCALE_W(149), SCALE_W(61))];
    logoView.image = [UIImage imageNamed:@"mofangLogo"];
    [self.view addSubview:logoView];
    
    self.gradeLabel = [self createLabel:CGRectMake(0, SCALE_W(149), SCREEN_WIDTH, 16)];
    self.gradeLabel.font = UIFontRegularOfSize(16);
    
    self.gradeLabel.text = [NSString stringWithFormat:@"当前版本v%@",kCurrentVersion];//@"当前版本v1.2.0";
    
    [self.view addSubview:self.gradeLabel];
    
    MagicLabel  * titlelabel = [self createLabel:CGRectMake(0, height - 180, SCREEN_WIDTH, 12)];
    titlelabel.textColor = [UIColor colorWithHexString:@"626A75" alpha:0.5];
    titlelabel.font = UIFontRegularOfSize(12);
    titlelabel.text = @"魔方官网";
    [self.view addSubview:titlelabel];
    
    MagicLabel * addressLabel = [self createLabel:CGRectMake(0, height - 161, SCREEN_WIDTH, 16)];
    addressLabel.text = @"http://mofang.biyi.top";
    [self.view addSubview:addressLabel];
    
    MagicLabel * phoneTitleLabel = [self createLabel:CGRectMake(0, height - 127, SCREEN_WIDTH, 12)];
    phoneTitleLabel.text = @"客服电话";
    phoneTitleLabel.textColor = [UIColor colorWithHexString:@"626A75" alpha:0.5];
    phoneTitleLabel.font = UIFontRegularOfSize(12);
    [self.view addSubview:phoneTitleLabel];
    
    MagicLabel * phoneLabel = [self createLabel:CGRectMake(0, height - 108, SCREEN_WIDTH, 14)];
    phoneLabel.text = @"010-85112088";
    [self.view addSubview:phoneLabel];
    
    MagicLabel * copyrightLabel = [self createLabel:CGRectMake(0, height - 54, SCREEN_WIDTH, 16)];
    copyrightLabel.text = @"© mofang.com 魔方分销 版权所有";
    copyrightLabel.font = UIFontRegularOfSize(12);
    [self.view addSubview:copyrightLabel];
}

- (MagicLabel *)createLabel:(CGRect)frame{
    MagicLabel * label = [[MagicLabel alloc] initWithFrame:frame];
    label.textColor = Black626A75Color;
    label.font = UIFontRegularOfSize(14);
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
