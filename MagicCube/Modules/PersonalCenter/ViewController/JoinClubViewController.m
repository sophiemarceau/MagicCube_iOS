//
//  JoinClubViewController.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "JoinClubViewController.h"

@interface JoinClubViewController ()

@end

@implementation JoinClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubViews];
    // Do any additional setup after loading the view.
}


- (void)initdata{
    self.title = @"加入魔方社群";
}


- (void)addSubViews{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(140)) * 0.5, SCALE_W(82), SCALE_W(140), SCALE_W(140))];
    imageView.image = [UIImage imageNamed:@"mofanQrcode"];
    [self.view addSubview:imageView];
    
    MagicLabel * noteLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(248), SCREEN_WIDTH, 14)];
    noteLabel.textColor = Black626A75Color;
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.text = @"微信扫一扫添加好友";
    [self.view addSubview:noteLabel];
    
    MagicLabel * wechatNumLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(295), SCREEN_WIDTH, 16)];
    wechatNumLabel.textColor = Black626A75Color;
    wechatNumLabel.textAlignment = NSTextAlignmentCenter;
    wechatNumLabel.font = UIFontRegularOfSize(16);
    NSString * numberstr = @"微信号：mofangzhushou";
    wechatNumLabel.attributedText = [MagicRichTool initWithString:numberstr substring:@"mofangzhushou" font:UIFontRegularOfSize(16) color:RedMagicColor];
    [self.view addSubview:wechatNumLabel];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, SCALE_W(327), 100, 16)];
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    [btn setTitleColor:RedMagicColor forState:UIControlStateNormal];
    btn.titleLabel.font = UIFontRegularOfSize(16);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"mofangzhushou";
    [BHToast showMessage:@"复制成功"];
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
