//
//  BaseNavigationViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "BaseViewController.h"
@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)load {
    NSArray *colorArray = @[KBGCell,KBGCell];
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT);
    UIImage *barImg = [UIImage BgImageFromColors: colorArray withFrame: frame];
    [[UINavigationBar appearance] setBackgroundImage:barImg forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage imageWithColor:KBGCell];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BlackMagicColor, NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    if ([viewController isKindOfClass:[BaseViewController class]]) {
    //        ((BaseViewController *)viewController).hidesBottomBarWhenPushed = [(BaseViewController *)viewController shouldHideBottomBarWhenPushed];
    //    } else {
    //
    //    }
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    UIImage *buttonNormal = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [viewController.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
    [viewController.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = backItem;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
//        UIViewController* vc = viewControllers[viewControllers.count-1];
//        vc.hidesBottomBarWhenPushed = [(BaseViewController *)vc shouldHideBottomBarWhenPushed];
    [super setViewControllers:viewControllers animated:animated];
}


@end
