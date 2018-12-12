//
//  BaseViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)){
    }else{self.automaticallyAdjustsScrollViewInsets = NO;}
    self.view.backgroundColor = KBGColor;
    
    if (self.presentingViewController) {
         UIImage *dismissImage = [[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:dismissImage forState:UIControlStateNormal];
        [backButton sizeToFit];
        //点击事件
        [backButton addTarget:self action:@selector(dissMiss:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        //    [[UIBarButtonItem alloc] initWithImage:goBackImage style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        //    leftBackItem.tintColor = UIColorFromRGB(0x1A1A1A);
        [leftBackItem setTitle:@""];
        self.navigationItem.leftBarButtonItem = leftBackItem;
    }
}

- (void)dissMiss:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(jpush:) name:NotificationJGPush object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationJGPush object:nil];
    NMRemovLoadIng;
}

-(void)jpush:(NSNotification *)noti
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [[TTJPushNoticeManager shareManger] jpushwithParam:[noti object] WithVC:self];
    });
}

@end
