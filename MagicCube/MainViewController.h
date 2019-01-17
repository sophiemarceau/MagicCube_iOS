//
//  MainViewController.h
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UITabBarController
@property(nonatomic,strong)  HomePageViewController *homeVc;
@end

NS_ASSUME_NONNULL_END
