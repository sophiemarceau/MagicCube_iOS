//
//  MainViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationViewController.h"
#import "HomePageViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MyCenterViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:UIFontRegularOfSize(10),NSForegroundColorAttributeName:BHHexColor(@"ABB5BE")} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:UIFontRegularOfSize(10),NSForegroundColorAttributeName:BHHexColor(@"308CDD")} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTranslucent:NO];
    [self initChildVC];
}

- (void)initChildVC{
    HomePageViewController *homeVc = [[HomePageViewController alloc] init];
    BaseNavigationViewController *nav1 = [self setUpOneChildVcWithVc:homeVc Image:@"tab_icon_item_normal" selectedImage:@"tab_item_selected" title:@"首页"];
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    BaseNavigationViewController *nav2 = [self setUpOneChildVcWithVc:secondVc Image:@"tab_boss_normal" selectedImage:@"tab_boss_selected" title:@"数据"];
    ThirdViewController * thirdVc = [[ThirdViewController alloc] init];
    BaseNavigationViewController *nav3 = [self setUpOneChildVcWithVc:thirdVc Image:@"tab_chat_normal" selectedImage:@"tab_chat_selected" title:@"自选"];
    MyCenterViewController * myCVc = [[MyCenterViewController alloc] init];
    BaseNavigationViewController *nav4 = [self setUpOneChildVcWithVc:myCVc Image:@"tab_me_normal" selectedImage:@"tab_me_selected" title:@"我的"];
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
}


#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  设置单个tabBarButton
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (BaseNavigationViewController *)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:Vc];
    Vc.view.backgroundColor = [UIColor whiteColor];
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    return nav;
}

//重新设置了一下他的标题和TabBar内容
- (void)addChildVcItem:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{// 设置子控制器的图片
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = myImage;
    //声明显示图片的原始式样 不要渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.title = title;
}
@end
