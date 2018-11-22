//
//  SalerTableViewCell.h
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SalerTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
- (void)configDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
