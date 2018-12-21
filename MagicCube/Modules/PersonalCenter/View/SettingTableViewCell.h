//
//  SettingTableViewCell.h
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
- (void)configDict:(NSDictionary *)dict;
- (void)configDict:(NSDictionary *)dict showRightArrow:(BOOL)hasRightArrow;
@end

NS_ASSUME_NONNULL_END
