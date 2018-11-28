//
//  HomeListViewController.h
//  MagicCube
//
//  Created by sophie on 2018/11/28.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListViewController : BaseViewController
@property (nonatomic,copy) void(^DidScrollBlock)(CGFloat scrollY);
@end

NS_ASSUME_NONNULL_END
