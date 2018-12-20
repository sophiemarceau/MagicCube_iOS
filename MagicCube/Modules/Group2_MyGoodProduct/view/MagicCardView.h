//
//  MagicCardView.h
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicCardView : UIView
- (void)setUpDistributeDict:(NSDictionary *)dataDict;

- (void)setUpGoodsDict:(NSDictionary *)dataDict;
@end

NS_ASSUME_NONNULL_END
