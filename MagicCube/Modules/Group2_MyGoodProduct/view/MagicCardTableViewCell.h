//
//  MagicCardTableViewCell.h
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicCardTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
+ (CGFloat)cellDetailHeight;
- (void)configDict:(NSString *)imageName;
- (void)configDataDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
